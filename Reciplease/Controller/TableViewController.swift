//
//  ViewController.swift
//  Reciplease
//
//  Created by Gilles Sagot on 07/08/2021.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var tableView: UITableView!
    
    var recipes: Recipes!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        customizeNavigationItems()
        
        // Recipes from Edamam for testing
        let bundle = Bundle(for: TableViewController.self)
        let url = bundle.url(forResource: "Edamam", withExtension: "json")!
        let data = try? Data(contentsOf: url)

        let result = try? JSONDecoder().decode(Recipes.self, from: data!)
        // print (result?.hits[0].recipe.image ?? "🔴 erreur ...")
        
        recipes = result
        
        // delegate things ...
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.hits.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchResultCellView
    
        // Load image with Alamofire
        RecipeService.shared.getImage(url: recipes.hits[indexPath.row].recipe.image, completionHandler: { (success, error, result) in
            if success {
                cell.backgroundView = UIImageView(image: result)
                cell.backgroundView?.contentMode = .scaleAspectFill
            }
        })
        
        // Set title
        cell.title.text = recipes.hits[indexPath.row].recipe.label
        
        // Cell is ready 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // Set its recipe property
            vc.currentTitle = recipes.hits[indexPath.row].recipe.label
            vc.currentImageName = recipes.hits[indexPath.row].recipe.image
            
            // Set its Ingredients list
            var array = [String]()
            for ingredient in recipes.hits[indexPath.row].recipe.ingredientLines {
                array.append(ingredient)
            }
            vc.ingredientLines = array
            
            // Push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func customizeNavigationItems() {
        // Attempt to customize navigation controller...
        self.navigationItem.title = "Reciplease"
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.init(name: "Chalkduster", size: 18)!]
    }
    
    


}

