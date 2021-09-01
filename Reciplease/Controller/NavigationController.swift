//
//  NavigationController.swift
//  Reciplease
//
//  Created by Gilles Sagot on 24/08/2021.
//

import UIKit

class NavigationController: UINavigationController {
    
    var isFavorite = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //isFavorite = false
        self.navigationBar.topItem?.title = "Reciplease"
        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.init(name: "Chalkduster", size: 18)!]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isFavorite {
            let vc  = self.viewControllers[0] as! TableViewController
            vc.isFavorite = true
        }

  
    }
    


}
