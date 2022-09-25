//
//  FavoriteTableViewCell.swift
//  BotanyApp
//
//  Created by Gwinyai Nyatsoka on 21/9/2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var plantTitleLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    weak var delegate: FavoritesDelegate?
    var plant: PlantModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func favoritesButtonTapped(_ sender: Any) {
        guard let plant = plant else {
            return
        }
        plant.isFavorite = false
        for (index, selectedPlant) in DataModel.shared.selectedPlants.enumerated() {
            if selectedPlant.id == plant.id {
                DataModel.shared.selectedPlants.remove(at: index)
            }
        }
        delegate?.reloadData()
    }
    

}
