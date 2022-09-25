//
//  PlantModel.swift
//  BotanyApp
//
//  Created by Gwinyai Nyatsoka on 25/9/2022.
//

import Foundation
import UIKit

class PlantModel {
    let id = UUID().uuidString
    var image: UIImage
    var title: String
    var notes: String
    let date = Date()
    var isFavorite = false
    init(image: UIImage, title: String, notes: String, isFavorite: Bool = false) {
        self.image = image
        self.title = title
        self.notes = notes
        self.isFavorite = isFavorite
    }
    func toggleFavorite() {
        isFavorite = !isFavorite
    }
}
