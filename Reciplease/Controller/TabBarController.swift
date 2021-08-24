//
//  TabBarViewController.swift
//  Reciplease
//
//  Created by Gilles Sagot on 24/08/2021.
//

import UIKit

class TabBarController: UITabBarController{


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    

    // Layout
    override func viewDidAppear(_ animated: Bool) {

        let attributes = [NSAttributedString.Key.font:UIFont(name: "Chalkduster", size: 16)]
        
        tabBar.isTranslucent = true
        tabBar.barStyle = .black
        tabBar.backgroundColor = UIColor.init(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        tabBar.tintColor = UIColor.white
        
        tabBar.items![0].setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        tabBar.items![1].setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        tabBar.items![0].titlePositionAdjustment.vertical = -10
        tabBar.items![1].titlePositionAdjustment.vertical = -10
    }
    
    // Manage Data
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        if item.title == "Search" {
            let vc  = self.viewControllers![0] as! NavigationController
            vc.isFavorite = false
             

        }
        if item.title == "Favorite" {       
            let vc  = self.viewControllers![1] as! NavigationController
            vc.isFavorite = true
        }
    }

}

