//
//  PlantDetailViewController.swift
//  BotanyApp
//
//  Created by Gwinyai Nyatsoka on 15/9/2022.
//

import UIKit

protocol PlantDetailDelegate: AnyObject {
    func update(plant: PlantModel)
}

class PlantDetailViewController: UIViewController {
    
    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var plantTitleLabel: UILabel!
    @IBOutlet weak var plantNotesLabel: UILabel!
    var plant: PlantModel?
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let plant = plant {
            plantImageView.image = plant.image
            plantTitleLabel.text = plant.title
            plantNotesLabel.text = plant.notes
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ModifySegue" {
            let destinationVC = segue.destination as! UpdatePlantViewController
            let plant = sender as! PlantModel
            destinationVC.plantToEdit = plant
            destinationVC.editDelegate = self
        }
    }
    
    func deletePlantConfirmation() {
        let alert = UIAlertController(title: "Delete Confirm", message: "Are you sure you want to delete this plant?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            if let plant = self.plant {
                DataModel.shared.plants.removeAll { plantModel in
                    plantModel.id == plant.id
                }
                DataModel.shared.selectedPlants.removeAll { plantModel in
                    plantModel.id == plant.id
                }
                NotificationCenter.default.post(name: Notification.Name(relodCollectionViewNotificationKey), object: self)
                self.navigationController?.popViewController(animated: true)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            alert.dismiss(animated: true)
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.deletePlantConfirmation()
            alert.dismiss(animated: true)
        }
        let updateAction = UIAlertAction(title: "Update", style: .default) { _ in
            guard let plant = self.plant else {
                alert.dismiss(animated: true)
                return
            }
            self.performSegue(withIdentifier: "ModifySegue", sender: plant)
            alert.dismiss(animated: true)
        }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        alert.addAction(updateAction)
        present(alert, animated: true)
    }

}

extension PlantDetailViewController: PlantDetailDelegate {
    
    func update(plant: PlantModel) {
        self.plant = plant
        plantImageView.image = plant.image
        plantTitleLabel.text = plant.title
        plantNotesLabel.text = plant.notes
        guard let index = index else {
            return
        }
        DataModel.shared.plants[index] = plant
        let selectedPlantIndex = DataModel.shared.selectedPlants.firstIndex { plantModel in
            plantModel.id == plant.id
        }
        if let selectedPlantIndex = selectedPlantIndex {
            print("did update")
            DataModel.shared.selectedPlants[selectedPlantIndex] = plant
        }
        NotificationCenter.default.post(name: Notification.Name(relodCollectionViewNotificationKey), object: self)
    }
    
}
