//
//  SearchView.swift
//  Reciplease
//
//  Created by Gilles Sagot on 21/08/2021.
//

import UIKit

class SearchView: UIView {

    var area: UIView!
    var line: UIView!
    var buttonRequest: UIButton!
    var buttonAddLine: UIButton!
    var buttonClearList: UIButton!
    var textEditable: UITextField!
    var textQuerryList: UITextView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        // View
        area = UIView()
        area.backgroundColor = .white
        area.frame = CGRect(x: 0,
                            y: 0,
                            width: frame.width,
                            height: 200)
  
        
        // text
        textEditable = UITextField()
        textEditable.font = UIFont(name: "Avenir", size: 24)
        textEditable.text = nil
        textEditable.placeholder = "Chicken, rice, tomatoe..."
        textEditable.frame = CGRect(x: 10,
                                    y: 50,
                                    width: frame.width - 100,
                                    height: 50)
        
        
        
        // Buttons
        buttonAddLine = UIButton()
        buttonAddLine.backgroundColor = UIColor(red: 80/255, green: 140/255, blue: 80/255, alpha: 1.0)
        buttonAddLine.titleLabel?.font = UIFont(name: "Avenir", size: 24)
        buttonAddLine.setTitle("Add", for: .normal)
        buttonAddLine.setTitleColor(.white, for: .normal)
        buttonAddLine.frame = CGRect(x: textEditable.frame.maxX + 10,
                                     y: textEditable.frame.minY + 12,
                                     width: 70,
                                     height: 30)
        
        
        
        buttonRequest = UIButton()
        buttonRequest.backgroundColor = UIColor(red: 80/255, green: 140/255, blue: 80/255, alpha: 1.0)
        buttonRequest.titleLabel?.font = UIFont(name: "Avenir", size: 24)
        buttonRequest.setTitle("Search for recipes", for: .normal)
        buttonRequest.setTitleColor(.white, for: .normal)
        buttonRequest.frame = CGRect(x: frame.midX - 140,
                                     y: frame.maxY - 80,
                                     width: 280,
                                     height: 50)
        
        
        // List
        textQuerryList = UITextView()
        textQuerryList.backgroundColor = .init(white: 1, alpha: 0)
        textQuerryList.font = UIFont(name: "Chalkduster", size: 18)
        textQuerryList.textColor = .white
        textQuerryList.text = "Your Ingredients : \n"
        textQuerryList.isSelectable = false
        textQuerryList.isEditable = false
        textQuerryList.frame = CGRect(x: 0,
                                      y: area.frame.maxY + 10,
                                      width: frame.width,
                                      height: buttonRequest.frame.minY - area.frame.maxY)
        
        
        // Button
        buttonClearList = UIButton()
        buttonClearList.backgroundColor = UIColor.gray
        buttonClearList.titleLabel?.font = UIFont(name: "Avenir", size: 24)
        buttonClearList.setTitle("Clear", for: .normal)
        buttonClearList.setTitleColor(.white, for: .normal)
        buttonClearList.frame = CGRect(x: buttonAddLine.frame.minX,
                                       y: textQuerryList.frame.minY + 9,
                                     width: 70,
                                     height: 30)
     
        
        //Line
        line = UIView()
        line.backgroundColor = .lightGray
        line.frame = CGRect(x: 10,
                            y: textEditable.frame.maxY,
                            width: textEditable.frame.width,
                            height: 1)
        

        // Add to view
        self.addSubview(area)
        self.addSubview(buttonRequest)
        self.addSubview(buttonAddLine)
        self.addSubview(textEditable)
        self.addSubview(textQuerryList)
        self.addSubview(buttonClearList)
        self.addSubview(line)
    }
    
    convenience init(inView: UIView) {
        let rect = CGRect(x: 0, y: 0, width: inView.frame.width, height: inView.frame.height)
        self.init(frame: rect)
      
    }

        
}


