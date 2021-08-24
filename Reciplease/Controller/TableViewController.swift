//
//  ViewController.swift
//  Reciplease
//
//  Created by Gilles Sagot on 07/08/2021.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate {
    
    //MARK: - UI VARIABLES
    
    @IBOutlet var tableView: UITableView!
   
    //MARK: - DATA VARIABLES
    
    var recipes: Recipes!
    
    var favoriteRecipes:[FavoriteRecipe]!
    var ingredients:[Ingredient]!
    
    var isFavorite = false
    
    //MARK: - PREPARE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Reciplease"
        
        // delegate things ...
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteRecipes = FavoriteRecipe.all
        tableView.reloadData()
    }
    
}


extension  TableViewController: UITableViewDataSource {
    
    //MARK: - TABLEVIEW
    
    // Row number
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFavorite == true {
            return favoriteRecipes.count
        }
        else if isFavorite == false {
            return recipes.hits.count
        }
        else{
            return 0
        }
    }
    
    // Row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160;
    }
    
    // Arrange Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Customized cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellView
        
        // Image
        var image = String()
        if isFavorite {
            image = favoriteRecipes[indexPath.row].image!
        }
        else {
            image = recipes.hits[indexPath.row].recipe.image
        }
        RecipeService.shared.getImage(url: image, completionHandler: { (success, error, result) in
            if success {
                cell.backgroundView = UIImageView(image: UIImage(data: result!) )
                cell.backgroundView?.contentMode = .scaleAspectFill
            }
        })
        
        // Title
        if isFavorite {
            cell.title.text = favoriteRecipes[indexPath.row].title
        }
        else{
            cell.title.text = recipes.hits[indexPath.row].recipe.label
        }
        
        // Gradient
        cell.gradient(frame: cell.frame)
        
        // Insert
        cell.insertView.center.x = cell.frame.maxX - 60 - 10
        
        if isFavorite {
            cell.insertView.textYield.text = String(favoriteRecipes[indexPath.row].yield)
            cell.insertView.textTime.text = timeToString(interval:favoriteRecipes[indexPath.row].totalTime)
        }
        else{
            cell.insertView.textYield.text = String(recipes.hits[indexPath.row].recipe.yield)
            cell.insertView.textTime.text = timeToString(interval: recipes.hits[indexPath.row].recipe.totalTime )
        }
        
        // Ready
        return cell
    }
    
    // Handle User input
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            if isFavorite {
                // Set its recipe property
                vc.currentTitle = favoriteRecipes[indexPath.row].title
                vc.currentImageName = favoriteRecipes[indexPath.row].image
                vc.ingredientLines = Ingredient.listOfIngredients (from:favoriteRecipes[indexPath.row].title!)
                vc.isFavorite = true
                vc.currentYield = favoriteRecipes[indexPath.row].yield
                vc.currentTotalTime = favoriteRecipes[indexPath.row].totalTime
                vc.currentUrl = favoriteRecipes[indexPath.row].url
            }else {
                // Set its recipe property
                vc.currentTitle = recipes.hits[indexPath.row].recipe.label
                vc.currentImageName = recipes.hits[indexPath.row].recipe.image
                vc.isFavorite = false
                vc.currentYield = recipes.hits[indexPath.row].recipe.yield
                vc.currentTotalTime = recipes.hits[indexPath.row].recipe.totalTime
                vc.currentUrl = recipes.hits[indexPath.row].recipe.url
                
                // Set its Ingredients list
                var array = [String]()
                for ingredient in recipes.hits[indexPath.row].recipe.ingredientLines {
                    array.append(ingredient)
                }
                vc.ingredientLines = array
            }
            
            // Present controller
            navigationController?.pushViewController(vc, animated: true)
            
        }// End condition
        
    }// End function
    
    //MARK: - UTILS
    
    func timeToString (interval:Double) ->String{
        if interval != 0 {
            let time = TimeInterval(interval * 60)
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .abbreviated
            formatter.allowedUnits = [.hour, .minute]
            return formatter.string(from: time)!
        }else{
            return "N/A"
        }
    }
    
    
}// End class
