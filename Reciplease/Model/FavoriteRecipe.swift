//
//  FavoriteRecipe.swift
//  Reciplease
//
//  Created by Gilles Sagot on 20/08/2021.
//

import Foundation
import CoreData


public class FavoriteRecipe: NSManagedObject {
    
    //MARK: - GET ALL FAVORITE RECIPES
    
    static var all: [FavoriteRecipe] {
        let requestFavorite: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let resultFavorite = try? AppDelegate.viewContext.fetch(requestFavorite) else {return []}
        return resultFavorite
    }
    
    static func makePresentable(favorites:[FavoriteRecipe])->[Recipe] {
        var recipes = [Recipe]()
  
        for recipe in favorites {
            let ingredients = Ingredient.listOfIngredients(from: recipe.label!)
            
            let result  = Recipe(label: recipe.label!, image: recipe.image!, url: recipe.url!, yield: recipe.yield, ingredientLines: ingredients, totalTime: recipe.totalTime)
            
            recipes.append(result)
            
        }
        
        return recipes
    }

    //MARK: - ADD RECIPE TO FAVORITE
    
    static func saveRecipeToFavorite(title:String, image:String, ingredients:[String], yield:Double, totalTime:Double, url:String)  {
        // Create object for recipe
        let recipe = FavoriteRecipe(context: AppDelegate.viewContext)
     
        recipe.label = title
        recipe.image = image
        recipe.yield = yield
        recipe.totalTime = totalTime
        recipe.url = url

         
        for ingredient in ingredients {
            let item = Ingredient(context: AppDelegate.viewContext)
            item.name = ingredient
            item.recipe = recipe
            item.awakeFromInsert()
        }
 
        // Save context
        guard ((try? AppDelegate.viewContext.save()) != nil) else {return}
        
    }
    
    //MARK: - DELETE A RECIPE
    
    static func deleteRecipe (title:String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoriteRecipe")
        let filter = title
        let predicate = NSPredicate(format: "label = %@", filter)
        fetchRequest.predicate = predicate

        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        guard ((try? AppDelegate.viewContext.execute(deleteRequest)) != nil) else {return}
    
    }
    
    static func findRecipe (title:String)->Bool {
        for favorite in all {
            if favorite.label == title {
                return true
            }
        }
        return false
    }
    
    
    
    //MARK: - DELETE ALL RECIPES
    
    static func deleteAllCoreDataItems () {
        
        //To delete things in core data...
        
        var fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoriteRecipe")
        var deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      
        guard ((try? AppDelegate.viewContext.execute(deleteRequest)) != nil)else{return}
        
        fetchRequest = NSFetchRequest(entityName: "Ingredient")
        deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        try! AppDelegate.viewContext.execute(deleteRequest)
        
        guard ((try? AppDelegate.viewContext.execute(deleteRequest)) != nil)else{return}

          
    }
    
    
}

