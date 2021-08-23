//
//  DetailView.swift
//  Reciplease
//
//  Created by Gilles Sagot on 21/08/2021.
//

import UIKit

class DetailView: UIView {

    var textListOfIngredients: UITextView!
    var textRecipeTitle: UITextField!
    var imageRecipe:UIImageView!
    var buttonGetDirections:UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Image
        imageRecipe = UIImageView()
        imageRecipe.clipsToBounds = true
        imageRecipe.contentMode = .scaleAspectFill
        imageRecipe.layer.cornerRadius = 10
        imageRecipe.frame = CGRect(x: 10,
                                   y: 0,
                                   width: frame.width - 20,
                                   height: 200)
        
        
        // Title
        textRecipeTitle = UITextField()
        textRecipeTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 21)
        textRecipeTitle.textColor = .white
        textRecipeTitle.backgroundColor = .init(white: 1, alpha: 0)
        textRecipeTitle.frame = CGRect(x: 10,
                                       y: imageRecipe.frame.maxY,
                                       width: frame.width - 20,
                                       height: 50)
        
        
        // Button
        buttonGetDirections = UIButton()
        buttonGetDirections.backgroundColor = .blue
        buttonGetDirections.setTitle("Get directions", for: .normal)
        buttonGetDirections.titleLabel?.font = UIFont(name: "Avenir", size: 24)
        buttonGetDirections.frame = CGRect(x: 30,
                                           y: frame.maxY - 80,
                                           width: frame.width - 60,
                                           height: 50)
        
        
        // List
        textListOfIngredients = UITextView()
        textListOfIngredients.textColor = .white
        textListOfIngredients.isEditable = false
        textListOfIngredients.isSelectable = false
        textListOfIngredients.isScrollEnabled = true
        textListOfIngredients.backgroundColor = UIColor.init(white: 1, alpha: 0)
        textListOfIngredients.font = UIFont(name: "Chalkduster", size: 16)
        textListOfIngredients.frame = CGRect(x: 10,
                                             y: textRecipeTitle.frame.maxY,
                                             width: frame.width - 20,
                                             height: buttonGetDirections.frame.minY
                                                - textRecipeTitle.frame.maxY - 10)
        
        
        // Add to view
        self.addSubview(imageRecipe)
        self.addSubview(textRecipeTitle)
        self.addSubview(textListOfIngredients)
        self.bringSubviewToFront(textListOfIngredients)
        self.addSubview(buttonGetDirections)
        
      
    }

    
    convenience init(inView: UIView) {
        let rect = CGRect(x: 0, y: 0, width: inView.frame.width, height: inView.frame.height)
        self.init(frame: rect)
    }
   
}

