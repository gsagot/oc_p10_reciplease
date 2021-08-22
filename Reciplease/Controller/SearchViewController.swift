//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Gilles Sagot on 09/08/2021.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    var searchView:SearchView!
    var search = String()
    
    var topBarHeight:CGFloat {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let frameWindow = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let frameNavigationBar = self.navigationController?.navigationBar.frame.height ?? 0
        return frameWindow + frameNavigationBar
    }
    
    var bottomBarHeight:CGFloat {
        let frameTabBar = self.tabBarController?.tabBar.frame.height ?? 0
        return frameTabBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Customize navigation bars
        customizeNavigationItems()
        
        // Add search view
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - topBarHeight - bottomBarHeight)
    
        searchView = SearchView(frame: frame)
        self.view.addSubview(searchView)
        
        // gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
        let search = UITapGestureRecognizer(target: self, action: #selector(self.handleSearch(_:)))
        self.searchView.buttonRequest.addGestureRecognizer(search)
        
        let add = UITapGestureRecognizer(target: self, action: #selector(self.handleAdd(_:)))
        self.searchView.buttonAddLine.addGestureRecognizer(add)
        
        let clear = UITapGestureRecognizer(target: self, action: #selector(self.handleClear(_:)))
        self.searchView.buttonClearList.addGestureRecognizer(clear)
        
        
        
    }
    
    // MARK: - ALERT CONTROLLER
    
    private func presentUIAlertController(title:String, message:String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    //MARK: - HANDLE USER INPUT
    
    // Request
    @objc func handleSearch(_ sender: UITapGestureRecognizer? = nil) {
        
        RecipeService.shared.getRecipes(query:search ,completionHandler: { (success, error, recipes) in
            if success{
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "Result") as? TableViewController {
                    // Push it onto the navigation controller
                    vc.recipes = recipes
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }else{
                self.presentUIAlertController(title: "error", message: error!)
            }
        })
        
  
    }
    
    
    // Add Ingredient(s)
    @objc func handleAdd(_ sender: UITapGestureRecognizer? = nil) {
        
        if searchView.textEditable.text != nil {
            
            let modifiedArray = searchView.textEditable.text.map { $0.components(separatedBy: ",") }
            
            searchView.textQuerryList.text?.append("\n" )
            
            for i in 0..<modifiedArray!.count {
                search.append(modifiedArray![i] + " ")
                searchView.textQuerryList.text?.append(" - \(modifiedArray![i])\n" )
            }// End for
            
        }// End if
        
    }// End func
    
    
    // Delete Ingredient(s)
    @objc func handleClear(_ sender: UITapGestureRecognizer? = nil) {
        
        searchView.textQuerryList.text = "Your Ingredients :"
        
    }// End func
    
    
    // Hide Keyboard
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        searchView.textEditable.resignFirstResponder()

    }
 
}

//MARK: - CUSTOM NAVIGATIONBAR

extension SearchViewController {

    func customizeNavigationItems() {
        
        // TabBar controller
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.barStyle = .black
        self.tabBarController?.tabBar.backgroundColor = UIColor.init(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        self.tabBarController?.tabBar.tintColor = UIColor.white
        let attributes = [NSAttributedString.Key.font:UIFont(name: "Chalkduster", size: 16)]
        self.tabBarController?.tabBar.items![0].setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        self.tabBarController?.tabBar.items![1].setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        self.tabBarController?.tabBar.items![0].titlePositionAdjustment.vertical = -10
        self.tabBarController?.tabBar.items![1].titlePositionAdjustment.vertical = -10

        
        // Navigation controller
        self.navigationItem.title = "Reciplease"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.init(name: "Chalkduster", size: 18)!]
        
    }
    
    
}
