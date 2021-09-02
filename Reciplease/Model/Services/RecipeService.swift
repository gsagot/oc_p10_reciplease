//
//  RecipeService.swift
//  Reciplease
//
//  Created by Gilles Sagot on 07/08/2021.
//

import Foundation
import Alamofire


class RecipeService {
    
    static var shared = RecipeService()
    
    private var sessionManager:Session = {
      let configuration = URLSessionConfiguration.af.default
      //configuration.timeoutIntervalForRequest = 1
      configuration.waitsForConnectivity = false
      return Session(configuration: configuration)
    }()
    
    private init () {}
    
    private(set) var recipes = [Recipe]()
    
    init(session:Session) {
        self.sessionManager = session
    }
    
    func start(){
        RecipeService.shared = RecipeService()
    }
    
    func getRecipes(query:String, completionHandler: @escaping ((Bool, String?) -> Void)) {
        
        let url = "https://api.edamam.com/api/recipes/v2"
        let queryParameters: [String: String] = ["type": "public",
                                                 "q": query,
                                                 "app_id": key.app_id,
                                                 "app_key": key.app_key,
                                                 "ingr": "3-8"]
        
        
        //sessionManager.cancelAllRequests()
        
        sessionManager.request(url, parameters: queryParameters).responseDecodable(of: Recipes.self) { response in
            
            switch response.result {
            case .success(_):
                self.recipes.removeAll()
                // Check if we have recipes
                guard response.value!.to != 0 else { return completionHandler(false,"no recipe found") }
                
                // Save recipes with only wanted variables
                for i in response.value!.from...response.value!.to {
                    self.recipes.append((response.value?.hits[i-1].recipe)!)
                }
                completionHandler(true,nil)
                
            case .failure(let error):
                
                switch error {
                
                case .responseSerializationFailed(_):
                    completionHandler(false,"An error occured, Please try again")
                default:
                    completionHandler(false,"Session task failed, Please check connection")
                }// End error switch
            
            }// End response switch
            
        }// end closure
        
    }// end function
          
    
}
