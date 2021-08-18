//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Gilles Sagot on 09/08/2021.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var ingredientListText: UITextView!
    @IBOutlet var querryIngredientText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        customizeNavigationItems()
        
        /*
        print("hello")
        RecipeService.shared.getRecipes(completionHandler: { (success, error, recipe) in
            print ("success")
        })
        
        let myImageView = UIImageView()
        myImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        AF.request("https://robohash.org/123.png").response { response in
            myImageView.image = UIImage(data: response.data!, scale:1)
         }
        self.view.addSubview(myImageView)
        */
      
        ingredientListText.text = "Your Ingredients : \n"
        
        // gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
        let search = UITapGestureRecognizer(target: self, action: #selector(self.handleSearch(_:)))
        self.searchButton.addGestureRecognizer(search)
        
        let add = UITapGestureRecognizer(target: self, action: #selector(self.handleAdd(_:)))
        self.addButton.addGestureRecognizer(add)
        
        
        
    }
    
    
    
    @objc func handleSearch(_ sender: UITapGestureRecognizer? = nil) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Result") as? TableViewController {
            // Push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func handleAdd(_ sender: UITapGestureRecognizer? = nil) {
        
        if querryIngredientText.text != nil {
            let modifiedArray = querryIngredientText.text.map { $0.components(separatedBy: ",") }
            
            for i in 0..<modifiedArray!.count {
                ingredientListText.text?.append(" - \(modifiedArray![i])\n" )
            }
             
        }

    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        querryIngredientText.resignFirstResponder()

    }
    
    func customizeNavigationItems() {
        // Attempt to customize tabBar controller...
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.barStyle = .black
        self.tabBarController?.tabBar.backgroundColor = UIColor.init(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        self.tabBarController?.tabBar.tintColor = UIColor.white
        let attributes = [NSAttributedString.Key.font:UIFont(name: "Chalkduster", size: 16)]
        self.tabBarController?.tabBar.items![0].setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        self.tabBarController?.tabBar.items![1].setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        self.tabBarController?.tabBar.items![0].titlePositionAdjustment.vertical = -10
        self.tabBarController?.tabBar.items![1].titlePositionAdjustment.vertical = -10

        
        // Attempt to customize navigation controller...
        self.navigationItem.title = "Reciplease"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.init(name: "Chalkduster", size: 18)!]
        
    }
    
    
}
