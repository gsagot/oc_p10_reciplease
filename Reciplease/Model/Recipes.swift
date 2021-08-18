//
//  Recipe.swift
//  Reciplease
//
//  Created by Gilles Sagot on 07/08/2021.
//

import Foundation

struct Recipe : Codable {
    var label: String
    var image: String
    var url: String
    var ingredientLines:[String]
}

struct Hits : Codable {
    var recipe: Recipe
    
}

struct Recipes : Codable {
    var from: Int
    var to: Int
    var hits:[Hits]
    
}
