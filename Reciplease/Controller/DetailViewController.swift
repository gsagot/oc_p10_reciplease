//
//  DetailViewController.swift
//  Reciplease
//
//  Created by Gilles Sagot on 09/08/2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - DATA VARIABLES

    var isFavorite:Bool!
    var currentRecipe: Recipe!
    
    // MARK: - UI VARIABLES
    var detailView: DetailView!
    
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
    
    //MARK: - LAYOUT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // Navigation layout
        customizeNavigationItems()
        
        // View layout
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - topBarHeight - bottomBarHeight)
        detailView = DetailView(frame: frame)
        self.view.addSubview(detailView)
        
        // Gesture recognizer
        let getDirection = UITapGestureRecognizer(target: self, action: #selector(self.handleGetDirections(_:)))
        self.detailView.buttonGetDirections.addGestureRecognizer(getDirection)
              
    }
    

    override func viewDidDisappear(_ animated: Bool) {
        // Don't stay on this view when user switch between Search and Favorite
        navigationController?.popViewController(animated: false)       
  
    }
    
    // MARK: - ALERT CONTROLLER
    
    private func presentUIAlertController(title:String, message:String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    //MARK: - RESET TEXT AND IMAGE
    
    override func viewWillAppear(_ animated: Bool) {
        
        indicator.startAnimating()
        
        // Image
        ImageService.shared.getImage(url: currentRecipe.image, completionHandler: { (success, error, result) in
            if success {
                self.detailView.imageRecipe.image = UIImage(data: result!)
            }else {
                self.detailView.imageRecipe.image = UIImage(named: "full-english")
            }
            self.indicator.stopAnimating()
        })
    
        // Title
        detailView.textRecipeTitle.text = currentRecipe.label
        
        // Ingredients
        detailView.textListOfIngredients.text = ""
        
        for i in 0..<currentRecipe.ingredientLines.count {
            detailView.textListOfIngredients.text?.append("\(currentRecipe.ingredientLines[i])\n" )
            
        }
        
    }
    
    
    //MARK: - HANDLE USER INPUT
    
    @objc func handleAddFavorite(_ sender: UITapGestureRecognizer? = nil) {
        if FavoriteRecipe.findRecipe(title: currentRecipe.label) {
            presentUIAlertController(title: "Info", message: "Recipe already saved")
            
        }else {
            FavoriteRecipe.saveRecipeToFavorite(title: currentRecipe.label,
                                                image: currentRecipe.image,
                                                ingredients: currentRecipe.ingredientLines,
                                                yield: currentRecipe.yield,
                                                totalTime: currentRecipe.totalTime,
                                                url:currentRecipe.url,
                                                completionHandler: {(result,error)->() in
                                                    if result {
                                                        isFavorite = true
                                                        customizeNavigationItems()
                                                        presentUIAlertController(title: "Info", message: "Recipe saved")
                                                        
                                                    }else {
                                                        presentUIAlertController(title: "error", message: "An error occured, please try again")
                                                        
                                                    }
                                                })
            
            
        }
        
    }
    
    @objc func handleDeleteFromFavorite(_ sender: UITapGestureRecognizer? = nil) {
        FavoriteRecipe.deleteRecipe(title: currentRecipe.label,
                                    completionHandler: {(result,error)->() in
                                        if result {
                                            isFavorite = false
                                            customizeNavigationItems()
                                            presentUIAlertController(title: "Info", message: "Recipe deleted")
                                            
                                        }else {
                                            presentUIAlertController(title: "error", message: "An error occured, please try again")
                                        }
                                        
                                    })
        
    }
    
    @objc func handleGetDirections(_ sender: UITapGestureRecognizer? = nil) {
        if let url = URL(string: currentRecipe.url) {
            UIApplication.shared.open(url)
        }
    }
    
    
}

extension DetailViewController {
    
    //MARK: - CUSTOM NAVIGATIONBAR
    
    func customizeNavigationItems() {
        // Attempt to customize navigation controller...
        
        // title
        self.navigationItem.title = "Reciplease"
        
        // items
        let favoriteButton = UIButton(type: .system)
        
        if isFavorite {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            let deleteFromFavorite = UITapGestureRecognizer(target: self, action: #selector(self.handleDeleteFromFavorite(_:)))
            favoriteButton.addGestureRecognizer(deleteFromFavorite)
        }
        else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            let addFavorite = UITapGestureRecognizer(target: self, action: #selector(self.handleAddFavorite(_:)))
            favoriteButton.addGestureRecognizer(addFavorite)
            
        }
        
        // Indicator
        indicator.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        indicator.color = UIColor.white
        indicator.hidesWhenStopped = true
     
      
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: indicator),UIBarButtonItem(customView: favoriteButton)]

  
    }
    
}
