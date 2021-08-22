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
        let requestRecipe: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let resultRecipe = try? AppDelegate.viewContext.fetch(requestRecipe) else {return []}
        return resultRecipe
    }

    //MARK: - ADD RECIPE TO FAVORITE
    
    static func saveRecipeToFavorite(title:String, image:String, ingredients:[String], yield:Double, totalTime:Double)  {
        // Create object for recipe
        let recipe = FavoriteRecipe(context: AppDelegate.viewContext)
     
        recipe.title = title
        recipe.image = image
        recipe.yield = yield
        recipe.totalTime = totalTime

         
        for ingredient in ingredients {
            let item = Ingredient(context: AppDelegate.viewContext)
            item.name = ingredient
            item.recipe = recipe
            item.awakeFromInsert()
        }
 
        // Save context
        guard ((try? AppDelegate.viewContext.save()) != nil) else {
            print ("An error occured please try again... ")
            return
        }
    }
    
    //MARK: - DELETE A RECIPE
    
    static func deleteRecipe (title:String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoriteRecipe")
        let filter = title
        let predicate = NSPredicate(format: "title = %@", filter)
        fetchRequest.predicate = predicate

        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        

        do {
            try AppDelegate.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    //MARK: - DELETE ALL RECIPES
    
    static func deleteAllCoreDataItems () {
        
        //To delete things in core data...
        
        var fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoriteRecipe")
        var deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      

        do {
            try AppDelegate.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        
        fetchRequest = NSFetchRequest(entityName: "Ingredient")
        deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
 
        do {
            try AppDelegate.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
          
    }
    
    
}
