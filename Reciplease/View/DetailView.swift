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
        
        // Image
        imageRecipe = UIImageView()
        imageRecipe.clipsToBounds = true
        imageRecipe.contentMode = .scaleAspectFill
        imageRecipe.frame = CGRect(x: 0,
                                   y: 0,
                                   width: frame.width,
                                   height: 200)
        
        
        // Title
        textRecipeTitle = UITextField()
        textRecipeTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 21)
        textRecipeTitle.textColor = .white
        textRecipeTitle.backgroundColor = .init(white: 1, alpha: 0)
        textRecipeTitle.frame = CGRect(x: 0,
                                       y: imageRecipe.frame.maxY,
                                       width: frame.width,
                                       height: 50)
        
        
        
        
        // List
        textListOfIngredients = UITextView()
        textListOfIngredients.textColor = .gray
        textListOfIngredients.isEditable = false
        textListOfIngredients.isSelectable = false
        textListOfIngredients.isScrollEnabled = true
        textListOfIngredients.backgroundColor = UIColor.init(white: 1, alpha: 0)
        textListOfIngredients.font = UIFont(name: "Chalkduster", size: 16)
        textListOfIngredients.frame = CGRect(x: 0,
                                             y: textRecipeTitle.frame.maxY,
                                             width: frame.width,
                                             height: frame.height - imageRecipe.frame.maxY - 100)
        
        
        
        
        // Add to view
        self.addSubview(imageRecipe)
        self.addSubview(textRecipeTitle)
        self.addSubview(textListOfIngredients)
        self.bringSubviewToFront(textListOfIngredients)
        
      
    }

    
    convenience init(inView: UIView) {
        let rect = CGRect(x: 0, y: 0, width: inView.frame.width, height: inView.frame.height)
        self.init(frame: rect)
    }
   
}

