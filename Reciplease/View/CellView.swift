//
//  SearchResultCellView.swift
//  Reciplease
//
//  Created by Gilles Sagot on 08/08/2021.
//

import Foundation

import UIKit

class CellView : UITableViewCell {
    
    var title: UILabel!
    var ingredientsView: UILabel!
    var insertView: InsertView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // Title
        title = UILabel()
        title.textColor = UIColor.white
        title.font = UIFont(name: "helvetica-bold", size: 18)
        title.frame = CGRect(x: 0, y: 110, width: 300, height: 30)
        
        // desciption
        ingredientsView = UILabel()
        ingredientsView.textColor = UIColor.white
        ingredientsView.adjustsFontSizeToFitWidth = false
        ingredientsView.lineBreakMode = .byTruncatingTail
        ingredientsView.text = "Chicken, rice, tomatoe, mushroom"
        ingredientsView.font = UIFont(name: "helvetica", size: 16)
        ingredientsView.frame = CGRect(x: 0, y: 130, width: 300, height: 30)
        
        
        // Insert
        insertView = InsertView(frame: CGRect(x: 300, y: 20, width: 120, height: 90))

        
        // Add to view
        self.addSubview(title)
        self.addSubview(ingredientsView)
        self.addSubview(insertView)
        
    }
    
    func gradient(frame:CGRect) {
       
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 100, width: frame.width, height: 60)
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        let baseColor = UIColor.init(red: 20/255, green: 20/255, blue: 20/255, alpha: 0)
        let lightColor = UIColor.init(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        layer.colors = [baseColor.cgColor,lightColor.cgColor]
        layer.name = "gradient"
        
        for item in self.layer.sublayers! where item.name == "gradient"{
            item.removeFromSuperlayer()
            item.removeAllAnimations()
        }
        
        self.layer.insertSublayer(layer, at: 0)
    
    }
    
}
