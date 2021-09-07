//
//  Recipe.swift
//  Reciplease
//
//  Created by Gilles Sagot on 07/08/2021.
//

import Foundation

struct Recipe: Codable {
    let label: String
    let image: String
    let url: String
    let yield: Double
    let ingredientLines:[String]
    let totalTime: Double
}

struct Hits: Codable {
    let recipe: Recipe
    
}

struct Recipes: Codable {
    let from: Int
    let to: Int
    let hits:[Hits]
    
}


    
    
    


