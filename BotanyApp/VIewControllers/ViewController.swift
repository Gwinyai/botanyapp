//
//  ViewController.swift
//  BotanyApp
//
//  Created by Gwinyai Nyatsoka on 4/9/2022.
//

import UIKit

let updatePostsNotificationKey = "com.gwinyai.botanyapp.updateposts"
let relodCollectionViewNotificationKey = "com.gwinyai.botanyapp.reloadCollectionView"

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionVIew: UICollectionView!
    var plants: [PlantModel] {
        return DataModel.shared.plants
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlantDetailSegue" {
            let destinationVC = segue.destination as! PlantDetailViewController
            let index = sender as! Int
            destinationVC.plant = plants[index]
            destinationVC.index = index
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionVIew.dataSource = self
        collectionVIew.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView(_:)), name: Notification.Name(relodCollectionViewNotificationKey), object: nil)
        
    }
    
    @objc func reloadCollectionView(_ notification: NSNotification) {
        collectionVIew.reloadData()
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let plant = plants[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlantCollectionViewCell", for: indexPath) as! PlantCollectionViewCell
        cell.plantImageView.image = plant.image
        cell.plantNameLabel.text = plant.title
        cell.plant = plant
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let spacing: CGFloat = 10
        let cellWidth = (width - (spacing * 2)) / 3
        return CGSize(width: cellWidth, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PlantDetailSegue", sender: indexPath.row)
    }
    
}

