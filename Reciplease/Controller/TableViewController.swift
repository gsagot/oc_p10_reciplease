//
//  ViewController.swift
//  Reciplease
//
//  Created by Gilles Sagot on 07/08/2021.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate {
    
    //MARK: - UI VARIABLES
    
    @IBOutlet weak var tableView: UITableView!
    
    var indicator = UIActivityIndicatorView()
    
    var officer = UILabel()
   
    //MARK: - DATA VARIABLES
    
    var recipes:[Presentable]!

    var isFavorite = false
    
    //MARK: - PREPARE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Reciplease"
      
        // Prepare array with from persistent data
        if isFavorite{
            recipes =  FavoriteRecipe.makePresentable(favorites: FavoriteRecipe.all)
        }

        // Delegate things ...
        tableView.delegate = self
        tableView.dataSource = self
        
        // Officer
        officer.font = UIFont(name: "HelveticaNeue", size: 21)
        officer.frame = CGRect(x: 10, y: 0, width: self.view.frame.width - 20, height: 200)
        officer.center.y = self.view.center.y - 100
        officer.textColor = .white
        officer.numberOfLines = 0
        officer.isHidden = true
        officer.backgroundColor = .clear
        self.view.addSubview(officer)
     
        // Indicator
        indicator.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        indicator.color = UIColor.white
        indicator.hidesWhenStopped = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicator)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isFavorite{
            recipes =  FavoriteRecipe.makePresentable(favorites: FavoriteRecipe.all)
            if recipes.count == 0 {
                officer.isHidden = false
                
                print (self.view.frame)
                officer.text = "It's empty here ! Please make a search first, then choose a recipe. You should be able to add it in your favorite with the icon in the upper left "
            }else {
                officer.isHidden = true
            }
        }
        
        tableView.reloadData()
    }

    
}


extension  TableViewController: UITableViewDataSource {
    
    //MARK: - TABLEVIEW
    
    // Row number
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return recipes.count
    }
    
    // Row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160;
    }
    
    // Arrange Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        indicator.startAnimating()
        
        // Customized cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellView
        
        // Image
        var image = String()
        image = recipes[indexPath.row].image
        
        ImageService.shared.getImage(url: image, completionHandler: { (success, error, result) in
            if success {
                cell.backgroundView = UIImageView(image: UIImage(data: result!) )
            }else {
                cell.backgroundView = UIImageView(image: UIImage(named: "full-english") )
            }
            cell.backgroundView?.contentMode = .scaleAspectFill
        })
         
        // Title
        cell.title.text = recipes[indexPath.row].label
 
        // Desciption
        cell.ingredientsView.text = formatString(recipes[indexPath.row].ingredientLines)
        
        // Gradient
        cell.gradient(frame: cell.frame)
        
        // Insert
        cell.insertView.center.x = cell.frame.maxX - 60 - 10
        
        cell.insertView.textYield.text = String(recipes[indexPath.row].yield)
        cell.insertView.textTime.text = timeToString(interval:recipes[indexPath.row].totalTime)

        indicator.stopAnimating()
        
        // Ready
        return cell
    }
    
    // Handle User input
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            if isFavorite {
                vc.isFavorite = true
            }else {
                vc.isFavorite = false
            }
            
            vc.currentRecipe = recipes[indexPath.row]
           
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
    
    func formatString (_ recipe:[String])->String {
        var string = String()
        
        for step in recipe {
            var ingredient = step.replacingOccurrences(of: "\\s?\\([\\w\\s]*\\)", with: "", options: .regularExpression)
            ingredient = ingredient.components(separatedBy: CharacterSet.decimalDigits).joined()
            ingredient = ingredient.components(separatedBy: CharacterSet.punctuationCharacters).joined()
            
            for substring in ingredient.components(separatedBy: " ") {
                if substring.count < 3 {
                    ingredient = ingredient.components(separatedBy: substring).joined()
                }
            }
 
            ingredient = ingredient.replacingOccurrences(of: "  ", with: " ")
            
            string.append(ingredient)
            string.append(",")
        }
        
        if let i = string.lastIndex(of: ","){
            string.remove(at: i)
            string.append(".")
        }
       
        return string

    }
    
    
}// End class
