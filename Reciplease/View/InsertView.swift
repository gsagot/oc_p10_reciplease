//
//  InsertView.swift
//  Reciplease
//
//  Created by Gilles Sagot on 22/08/2021.
//

import UIKit

class InsertView: UIView {

    var textYield: UITextField!
    var textTime: UITextField!
    var imageYield:UIImageView!
    var imageTime:UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.init(red: 50 / 255 , green: 50 / 255, blue: 50 / 255, alpha: 0.6)
        self.frame = frame
        
    
        // Images
        imageYield = UIImageView()
        imageYield.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        imageYield.image = UIImage(systemName: "person.fill")
        imageYield.tintColor = .white
       
        imageTime = UIImageView()
        imageTime.frame = CGRect(x: 10, y: 50, width: 30, height: 30)
        imageTime.image = UIImage(systemName: "clock.fill")
        imageTime.tintColor = .white
        
        // Texts
        textYield = UITextField()
        textYield.frame = CGRect(x: 10, y: 10, width: 50, height: 30)
        textYield.center.x += 40
        textYield.text = "4.0"
        textYield.textColor = .white
        
        textTime = UITextField()
        textTime.frame = CGRect(x: 10, y: 50, width: 50, height: 30)
        textTime.center.x += 40
        textTime.text = "10m"
        textTime.textColor = .white
        
        
        // Add to view
        self.addSubview(imageYield)
        self.addSubview(imageTime)
        self.addSubview(textYield)
        self.addSubview(textTime)
      
    }

    
    convenience init(inView: UIView) {
        let rect = CGRect(x: 0, y: 0, width: inView.frame.width, height: inView.frame.height)
        self.init(frame: rect)
    }
   
}


