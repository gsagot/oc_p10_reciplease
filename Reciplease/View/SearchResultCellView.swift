//
//  SearchResultCellView.swift
//  Reciplease
//
//  Created by Gilles Sagot on 08/08/2021.
//

import Foundation

import UIKit

class SearchResultCellView : UITableViewCell {
    
    var title = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        
        title.textColor = UIColor.white
        title.font = UIFont(name: "helvetica", size: 18)
        title.frame = CGRect(x: 0, y: 130, width: 400, height: 30)
        self.addSubview(title)
        
        
        let frame = CGRect(x: 0, y: 100, width: 800, height: 60)
        self.layer.insertSublayer(gradient(frame: frame), at:0)
        
  
    }
    
    func gradient(frame:CGRect) -> CAGradientLayer {

        let layer = CAGradientLayer()
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        let baseColor = UIColor.init(red: 20/255, green: 20/255, blue: 20/255, alpha: 0)
        let lightColor = UIColor.init(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        layer.colors = [baseColor.cgColor,lightColor.cgColor]
        
        return layer
    }
    
    
    
}
