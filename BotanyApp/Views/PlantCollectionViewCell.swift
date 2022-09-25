//
//  PlantCollectionViewCell.swift
//  BotanyApp
//
//  Created by Gwinyai Nyatsoka on 4/9/2022.
//

import UIKit

class PlantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var plantNameLabel: UILabel!
    var plant: PlantModel?
    
    @IBAction func didTapFavoriteButton(_ sender: Any) {
        guard let plant = plant else {
            return
        }
        plant.toggleFavorite()
        if plant.isFavorite {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            DataModel.shared.selectedPlants.append(plant)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            DataModel.shared.selectedPlants.removeAll { plantModel in
                plantModel.id == plant.id
            }
        }
        
    }
    
}
