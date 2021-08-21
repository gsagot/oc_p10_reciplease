//
//  DetailViewController.swift
//  Reciplease
//
//  Created by Gilles Sagot on 09/08/2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - DATA VARIABLE
    var currentImageName:String!
    var currentTitle:String!
    var ingredientLines:[String]!
    var isFavorite:Bool!
    
    // MARK: - UI VARIABLE
    var detailView: DetailView!
    

    
    //MARK: - LAYOUT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Navigation layout
        customizeNavigationItems()
        
        // View layout
        detailView = DetailView(inView: self.view)
        self.view.addSubview(detailView)
            
    }
    
    //MARK: - HANDLE USER INPUT
    
    @objc func handleAddFavorite(_ sender: UITapGestureRecognizer? = nil) {
        FavoriteRecipe.saveRecipeToFavorite(title: currentTitle!, image: currentImageName!, ingredients: ingredientLines)
        isFavorite = true
        customizeNavigationItems()
    }
    
    @objc func handleDeleteFromFavorite(_ sender: UITapGestureRecognizer? = nil) {
        FavoriteRecipe.deleteRecipe(title: currentTitle)
        isFavorite = false
        customizeNavigationItems()
    }
    
    //MARK: - RESET TEXT AND IMAGE
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Image
        RecipeService.shared.getImage(url: currentImageName, completionHandler: { (success, error, result) in
            if success { self.detailView.imageRecipe.image = UIImage(data: result!)}
        })
    
        // Title
        detailView.textRecipeTitle.text = currentTitle
        
        // Ingredients
        detailView.textListOfIngredients.text = ""
        
        for i in 0..<ingredientLines.count {
            detailView.textListOfIngredients.text?.append("\(ingredientLines[i])\n" )
            
        }
        
    }
    
    
}

extension DetailViewController {
    
    //MARK: - CUSTOM NAVIGATIONBAR
    
    func customizeNavigationItems() {
        // Attempt to customize navigation controller...
        self.navigationItem.title = "Reciplease"
        self.navigationController!.navigationBar.titleTextAttributes =
            [.foregroundColor: UIColor.white, .font: UIFont.init(name: "Chalkduster", size: 18)!]
        
        let favoriteButton = UIButton(type: .system)
        
        if isFavorite {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            let deleteFromFavorite = UITapGestureRecognizer(target: self, action: #selector(self.handleDeleteFromFavorite(_:)))
            favoriteButton.addGestureRecognizer(deleteFromFavorite)
        }
        else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            let addFavorite = UITapGestureRecognizer(target: self, action: #selector(self.handleAddFavorite(_:)))
            favoriteButton.addGestureRecognizer(addFavorite)
            
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
        
  
    }
    
}
