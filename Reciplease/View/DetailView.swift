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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(inView: UIView) {
        let rect = CGRect(x: 0, y: 0, width: inView.frame.width, height: inView.frame.height)
        self.init(frame: rect)
        
        // Image
        imageRecipe = UIImageView()
        imageRecipe.clipsToBounds = true
        imageRecipe.contentMode = .scaleAspectFill
        imageRecipe.frame = CGRect(x: 0,
                                   y: 0,
                                   width: rect.width,
                                   height: 200)
        
        
        // Title
        textRecipeTitle = UITextField()
        textRecipeTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 21)
        textRecipeTitle.textColor = .white
        textRecipeTitle.backgroundColor = .blue
        textRecipeTitle.frame = CGRect(x: 0,
                                       y: imageRecipe.frame.maxY,
                                       width: rect.width,
                                       height: 50)
        
        
        
        
        // List
        textListOfIngredients = UITextView()
        textListOfIngredients.textColor = .white
        textListOfIngredients.backgroundColor = UIColor.init(white: 1, alpha: 0)
        textListOfIngredients.font = UIFont(name: "Chalkduster", size: 16)
        textListOfIngredients.frame = CGRect(x: 0,
                                             y: textRecipeTitle.frame.maxY,
                                             width: rect.width,
                                             height: rect.height - imageRecipe.frame.maxY - 100)
        
        
        
        
        // Add to view
        self.addSubview(imageRecipe)
        self.addSubview(textRecipeTitle)
        self.addSubview(textListOfIngredients)
        
      
    }

        
}

