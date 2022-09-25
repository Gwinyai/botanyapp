//
//  Data.swift
//  BotanyApp
//
//  Created by Gwinyai Nyatsoka on 16/9/2022.
//

import Foundation

class DataModel {
    
    static let shared = DataModel()
    var plants = [PlantModel]()
    var selectedPlants = [PlantModel]()
    
    private init() {
        
    }
    
}
