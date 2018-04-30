//
//  SavedFoodModel.swift
//  foodpedia
//
//  Created by Fakhrus Ramadhan on 23/04/18.
//  Copyright © 2018 Fakhrus Ramadhan. All rights reserved.
//

import Foundation

class SavedFoodModel {
    var foodName : String?
    var foodCalories : Double?
    var foodImage : String?
    
    init(foodName : String, foodCalories : Double, foodImage : String) {
        self.foodName = foodName
        self.foodCalories = foodCalories
        self.foodImage = foodImage

    }
}
