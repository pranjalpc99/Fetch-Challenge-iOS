//
//  Meal.swift
//  fetchcodingchallenge
//
//  Created by Pranjal Chaudhari on 07/06/24.
//

import Foundation
import Combine

struct Meal: Codable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    
    var id: String { idMeal }
}

struct MealsResponse: Codable {
    let meals: [Meal]
}
