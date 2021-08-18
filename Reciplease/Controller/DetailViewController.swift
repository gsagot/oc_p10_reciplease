//
//  DetailViewController.swift
//  Reciplease
//
//  Created by Gilles Sagot on 09/08/2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var selectedRecipe:Hits!
    
    var currentImageName:String!
    var currentTitle:String!
    var ingredientLines:[String]!
    
    var ingredientText:UITextView!
    var titleLabel:UITextField!
    
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
    
    @objc func handleAddFavorite(_ sender: UITapGestureRecognizer? = nil) {
        saveRecipeToFavorite()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        RecipeService.shared.getImage(url: currentImageName, completionHandler: { (success, error, result) in
            if success {
                self.imageView.image = result
            }
        })
       
        ingredientText.text = ""
        
        for i in 0..<ingredientLines.count {
            ingredientText.text?.append("\(ingredientLines[i])\n" )
        
        }
         
        
        titleLabel.text = currentTitle
        
    }
    
    func saveRecipeToFavorite() {
        // Create object for recipe
        let recipe = FavoriteRecipe(context: AppDelegate.viewContext)
     
        recipe.title = titleLabel.text
        recipe.image = currentImageName

        
        // Create object for ingredients
        let items:[String] = ingredientLines
         
        for i in 0..<items.count {
            let ingredient = Ingredient(context: AppDelegate.viewContext)
            ingredient.name = ingredientLines[i]
            ingredient.recipe = recipe
            //ingredient.setPrimitiveValue(NSDate(), forKey: "createdAt")
            ingredient.awakeFromInsert()
        }
 
        // Save context
        guard ((try? AppDelegate.viewContext.save()) != nil) else {
            print ("An error occured please try again... ")
            return
        }
    }
    
    func customizeNavigationItems() {
        // Attempt to customize navigation controller...
        self.navigationItem.title = "Reciplease"
        self.navigationController!.navigationBar.titleTextAttributes =
            [.foregroundColor: UIColor.white, .font: UIFont.init(name: "Chalkduster", size: 18)!]
        
        let addFavoriteButton = UIButton(type: .system)
        addFavoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addFavoriteButton)
        
        let addFavorite = UITapGestureRecognizer(target: self, action: #selector(self.handleAddFavorite(_:)))
        addFavoriteButton.addGestureRecognizer(addFavorite)
    }
    

}
