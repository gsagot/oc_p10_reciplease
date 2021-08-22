//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Gilles Sagot on 10/08/2021.
//

import UIKit

import CoreData

class FavoriteViewController: UIViewController, UITableViewDelegate {
    
    var recipes:[FavoriteRecipe]!
    var ingredients:[Ingredient]!
    
    @IBOutlet var tableView: UITableView!
    
    //MARK: - LAYOUT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        customizeNavigationItems()

        // FavoriteRecipe.deleteAllCoreDataItems ()

        // delegate things ...
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    //MARK: - RESET
    
    override func viewWillAppear(_ animated: Bool) {
        
        recipes = FavoriteRecipe.all
        tableView.reloadData()
          
    }
    
   
    //MARK: - CUSTOM NAVIGATIONBAR
    
    func customizeNavigationItems(){
        // Attempt to customize navigation controller...
        self.navigationItem.title = "Reciplease"
        self.navigationController!.navigationBar.titleTextAttributes =
            [.foregroundColor: UIColor.white, .font: UIFont.init(name: "Chalkduster", size: 18)!]
    }
    
    
}

extension FavoriteViewController: UITableViewDataSource {
    //MARK: - TABLEVIEW
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Customized cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellView
        
        // Image
        
        RecipeService.shared.getImage(url: recipes[indexPath.row].image!, completionHandler: { (success, error, result) in
            if success {
                cell.backgroundView = UIImageView(image: UIImage(data: result!) )
                cell.backgroundView?.contentMode = .scaleAspectFill
            }
        })
        
        // Title
        cell.title.text = recipes[indexPath.row].title
        
        // Gradient
        cell.gradient(frame: cell.frame)
 
        // Ready
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // Set its recipe property
            //vc.selectedRecipe.recipe.ingredientLines = recipes[indexPath.row].ingredients
            vc.currentImageName = recipes[indexPath.row].image
            vc.currentTitle = recipes[indexPath.row].title
            vc.ingredientLines = Ingredient.listOfIngredients (from:recipes[indexPath.row].title!)
            vc.isFavorite = true
            // Push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
