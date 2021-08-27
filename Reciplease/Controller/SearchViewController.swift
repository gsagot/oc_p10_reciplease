//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Gilles Sagot on 09/08/2021.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    // MARK: - DATA VARIABLES
    
    var search = String()
    var firstSearch = true
    var recipes: Recipes!
    
    // MARK: - UI VARIABLES
    
    var searchView:SearchView!
    
    var indicator = UIActivityIndicatorView()
    
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
        
        // Add search view
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - topBarHeight - bottomBarHeight)
    
        searchView = SearchView(frame: frame)
        self.view.addSubview(searchView)
        
        // Gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
        let search = UITapGestureRecognizer(target: self, action: #selector(self.handleSearch(_:)))
        self.searchView.buttonRequest.addGestureRecognizer(search)
        
        let add = UITapGestureRecognizer(target: self, action: #selector(self.handleAdd(_:)))
        self.searchView.buttonAddLine.addGestureRecognizer(add)
        
        let clear = UITapGestureRecognizer(target: self, action: #selector(self.handleClear(_:)))
        self.searchView.buttonClearList.addGestureRecognizer(clear)
        
        // Indicator
        indicator.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        indicator.color = UIColor.white
        indicator.hidesWhenStopped = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicator)
        
        
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
        indicator.startAnimating()
        RecipeService.shared.getRecipes(query:search ,completionHandler: { (success, error, recipes) in
            if success{
                self.recipes = recipes
                self.updateView()
            }else{
                self.presentUIAlertController(title: "error", message: error!)
            }
        })
        
  
    }
    
    func updateView (){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "Result") as? TableViewController {
            self.firstSearch = false
            // Push it onto the navigation controller
            vc.recipes = recipes
            indicator.stopAnimating()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    // Add Ingredient(s)
    @objc func handleAdd(_ sender: UITapGestureRecognizer? = nil) {
        
        if searchView.textEditable.text != nil {
            
            let modifiedArray = searchView.textEditable.text.map { $0.components(separatedBy: ",") }
            
            searchView.textQuerryList.text?.append("\n" )
            
            for i in 0..<modifiedArray!.count {
                search.append(modifiedArray![i] + " ")
                searchView.textQuerryList.text?.append(" - \(modifiedArray![i])\n" )
            }// End loop
            
        }// End condition
        
    }// End function
    
    
    // Delete Ingredient(s)
    @objc func handleClear(_ sender: UITapGestureRecognizer? = nil) {
        search = ""
        searchView.textQuerryList.text = "Your Ingredients :"
        
    }
    
    
    // Hide Keyboard
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        searchView.textEditable.resignFirstResponder()
    }
 
}

