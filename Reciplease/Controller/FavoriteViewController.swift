//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Gilles Sagot on 10/08/2021.
//

import UIKit

import CoreData

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var recipes:[FavoriteRecipe]!
    var ingredients:[Ingredient]!
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        customizeNavigationItems()

        //deleteCoreDataItems ()

        // delegate things ...
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Request recipes
        let requestRecipe: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let resultRecipe = try? AppDelegate.viewContext.fetch(requestRecipe) else {
            return
        }
        
        /*
        // Request Ingredient
        let requestIngredient: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        
        let filter = "Mexican Rice"
        let predicate = NSPredicate(format: "recipe.title = %@", filter)
        requestIngredient.predicate = predicate
        
        guard let resultIngredient = try? AppDelegate.viewContext.fetch(requestIngredient) else {
            return
        }
        ingredients = resultIngredient
        */
        
        recipes = resultRecipe
        
        tableView.reloadData()
          
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchResultCellView
        
        // Set title
        cell.title.text = recipes[indexPath.row].title
        
        // Load image with Alamofire
        
        RecipeService.shared.getImage(url: recipes[indexPath.row].image!, completionHandler: { (success, error, result) in
            if success {
                cell.backgroundView = UIImageView(image: UIImage(data: result!) )
                cell.backgroundView?.contentMode = .scaleAspectFill
            }
        })
 
        // Cell is ready
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // Set its recipe property
            //vc.selectedRecipe.recipe.ingredientLines = recipes[indexPath.row].ingredients
            vc.currentImageName = recipes[indexPath.row].image
            vc.currentTitle = recipes[indexPath.row].title
            
            // Request Ingredient
            let requestIngredient: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
            
            let filter = recipes[indexPath.row].title
            let predicate = NSPredicate(format: "recipe.title = %@", filter!)
            requestIngredient.predicate = predicate
            requestIngredient.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
            guard let resultIngredient = try? AppDelegate.viewContext.fetch(requestIngredient) else {
                return
            }
            var array = [String]()
            for i in 0..<resultIngredient.count {
                array.append(resultIngredient[i].name!)
            }
            vc.ingredientLines = array
            // Push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func customizeNavigationItems(){
        // Attempt to customize navigation controller...
        self.navigationItem.title = "Reciplease"
        self.navigationController!.navigationBar.titleTextAttributes =
            [.foregroundColor: UIColor.white, .font: UIFont.init(name: "Chalkduster", size: 18)!]
    }
    
    
    func deleteCoreDataItems () {
        
        //To delete things in core data...
        
        var fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoriteRecipe")
        var deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      

        do {
            try AppDelegate.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        
        fetchRequest = NSFetchRequest(entityName: "Ingredient")
        deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
 
        do {
            try AppDelegate.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        
        
        
    }
    
    
    
}
