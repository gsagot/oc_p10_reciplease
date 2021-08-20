//
//  DetailViewController.swift
//  Reciplease
//
//  Created by Gilles Sagot on 09/08/2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var currentImageName:String!
    var currentTitle:String!
    var ingredientLines:[String]!
    var isFavorite:Bool!
    
    var ingredientText:UITextView!
    var titleLabel:UITextField!
    
    //MARK: - LAYOUT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        customizeNavigationItems()
        
        // Layout
        let frame = self.view.frame

        ingredientText = UITextView()
        ingredientText.textColor = .white
        ingredientText.backgroundColor = UIColor.init(white: 1, alpha: 0)
        ingredientText.font = UIFont(name: "Chalkduster", size: 16)
        ingredientText.frame = CGRect(x:0,
                                      y: imageView.frame.maxY,
                                      width: frame.width,
                                      height: frame.height - imageView.frame.maxY - 100)
        
        self.view.addSubview(ingredientText)
        
        titleLabel = UITextField()
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 21)
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x:0,
                                  y: imageView.frame.maxY - 50,
                                  width: frame.width,
                                  height: 50)
        
        self.view.addSubview(titleLabel)
        
    }
    
    //MARK: - HANDLE USER INPUT
    
    @objc func handleAddFavorite(_ sender: UITapGestureRecognizer? = nil) {
        FavoriteRecipe.saveRecipeToFavorite(title: titleLabel.text!, image: currentImageName!, ingredients: ingredientLines)
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
        
        // Image...
        RecipeService.shared.getImage(url: currentImageName, completionHandler: { (success, error, result) in
            if success { self.imageView.image = UIImage(data: result!)}
        })
    
        // Title ...
        titleLabel.text = currentTitle
        
        // All Ingredients...
        ingredientText.text = ""
        for i in 0..<ingredientLines.count { ingredientText.text?.append("\(ingredientLines[i])\n" ) }
        
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
