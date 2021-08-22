//
//  ViewController.swift
//  Reciplease
//
//  Created by Gilles Sagot on 07/08/2021.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    
    var recipes: Recipes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        customizeNavigationItems()
        
        // Recipes from Edamam for testing
        // localTest()

        
        // delegate things ...
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // Local test
    func localTest() {
        let bundle = Bundle(for: TableViewController.self)
        let url = bundle.url(forResource: "Edamam", withExtension: "json")!
        let data = try? Data(contentsOf: url)
        
        let result = try? JSONDecoder().decode(Recipes.self, from: data!)
        recipes = result
    }
    
    
    //MARK: - CUSTOM NAVIGATIONBAR
    
    func customizeNavigationItems() {
        // Attempt to customize navigation controller...
        self.navigationItem.title = "Reciplease"
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.init(name: "Chalkduster", size: 18)!]
    }
    
    
}

extension  TableViewController: UITableViewDataSource {
    //MARK: - TABLEVIEW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.hits.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160;//Choose your custom row height
    }
    
    // Arrange Cell with image and text
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Customized cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellView
        
        // Image
        RecipeService.shared.getImage(url: recipes.hits[indexPath.row].recipe.image, completionHandler: { (success, error, result) in
            if success {
                cell.backgroundView = UIImageView(image: UIImage(data: result!) )
                cell.backgroundView?.contentMode = .scaleAspectFill
            }
        })
        
        // Title
        cell.title.text = recipes.hits[indexPath.row].recipe.label

        // Gradient
        cell.gradient(frame: cell.frame)
        
        // Insert
        cell.insertView.center.x = cell.frame.maxX - 60 - 10
        cell.insertView.textYield.text = String(recipes.hits[indexPath.row].recipe.yield)
        cell.insertView.textTime.text = timeToString(interval: recipes.hits[indexPath.row].recipe.totalTime )
        
        // Ready
        return cell
    }
    
    // Handle User input
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // Set its recipe property
            vc.currentTitle = recipes.hits[indexPath.row].recipe.label
            vc.currentImageName = recipes.hits[indexPath.row].recipe.image
            vc.isFavorite = false
            vc.currentYield = recipes.hits[indexPath.row].recipe.yield
            vc.currentTotalTime = recipes.hits[indexPath.row].recipe.totalTime
            
            // Set its Ingredients list
            var array = [String]()
            for ingredient in recipes.hits[indexPath.row].recipe.ingredientLines {
                array.append(ingredient)
            }
            vc.ingredientLines = array
            
            
            // Push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }// End if
        
    }// End func
    
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
