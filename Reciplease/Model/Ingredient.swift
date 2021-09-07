//
//  Ingredient.swift
//  Reciplease
//
//  Created by Gilles Sagot on 18/08/2021.
//

import Foundation
import CoreData


public class Ingredient: NSManagedObject {
    
    static func listOfIngredients (from recipe:String)-> [String]{
        // Request Ingredient
        let filter = recipe
        let predicate = NSPredicate(format: "recipe.label = %@", filter)
        let requestIngredient: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        requestIngredient.predicate = predicate
        requestIngredient.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        guard let resultIngredient = try? AppDelegate.viewContext.fetch(requestIngredient) else {return []}
        
        var returnList = [String]()
        for i in 0..<resultIngredient.count {
            returnList.append(resultIngredient[i].name!)
        }
        
        return returnList
    }
}

extension Ingredient {
    override public func awakeFromInsert() {
        setPrimitiveValue(NSDate(), forKey: "createdAt")
    }

}


