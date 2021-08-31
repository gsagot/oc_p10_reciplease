//
//  CoreDataTests.swift
//  RecipleaseTests
//
//  Created by Gilles Sagot on 30/08/2021.
//

import XCTest

@testable import Reciplease
import CoreData

class CoreDataTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testFavoriteRecipeShouldReturnOneEntityWhenAddOneEntity() {
        //Given
        AppDelegate.container = CoreDataStore(.inMemory).persistentContainer
        FavoriteRecipe.deleteAllCoreDataItems()
        //When
        
        // Add One entity
        FavoriteRecipe.saveRecipeToFavorite(title:"title", image:"image", ingredients:[" one ingredient"], yield:0.0, totalTime:0.0, url:"https://openclassrooms.com")
        //Then
        XCTAssert(FavoriteRecipe.all.count == 1)
        XCTAssert(FavoriteRecipe.all[0].title == "title")
        XCTAssert(Ingredient.listOfIngredients(from: "title").count == 1)
    }
 
    
    func testFavoriteRecipeShouldDeleteEntityWhenDeleteEntity() {
        //Given
        AppDelegate.container = CoreDataStore(.inMemory).persistentContainer
        FavoriteRecipe.deleteAllCoreDataItems()
        // With One entity
        FavoriteRecipe.saveRecipeToFavorite(title:"title", image:"image", ingredients:[" one ingredient"], yield:0.0, totalTime:0.0, url:"https://openclassrooms.com")
        
        //When
        FavoriteRecipe.deleteRecipe(title: "title")
        //Then
        XCTAssert(FavoriteRecipe.all.count == 0)
       
    }
    
    func testFavoriteRecipeShouldReturnEmptyArrayWhendeleteAllEntities() {
        //Given
        AppDelegate.container = CoreDataStore(.inMemory).persistentContainer
        FavoriteRecipe.deleteAllCoreDataItems()
        // With Two entities
        FavoriteRecipe.saveRecipeToFavorite(title:"title", image:"image", ingredients:[" first ingredient", "second ingredient"], yield:0.0, totalTime:0.0, url:"https://openclassrooms.com")
        FavoriteRecipe.saveRecipeToFavorite(title:"title2", image:"image2", ingredients:[" one ingredient"], yield:0.0, totalTime:0.0, url:"https://openclassrooms.com")
        //When
        FavoriteRecipe.deleteAllCoreDataItems()
        //Then
        XCTAssert(FavoriteRecipe.all.count == 0)
      
       
    }
    
    
 
    
    

}
