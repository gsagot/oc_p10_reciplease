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
    
    init(session:Session) {
        self.sessionManager = session
    }
    
    func start(){
        RecipeService.shared = RecipeService()
    }
    
    func getRecipes(query:String, completionHandler: @escaping ((Bool, String?, Recipes? ) -> Void)) {
        
        let url = "https://api.edamam.com/api/recipes/v2"
        let queryParameters: [String: String] = ["type": "public",
                                                 "q": query,
                                                 "app_id": key.app_id,
                                                 "app_key": key.app_key,
                                                 "ingr": "3-8"]
        
        sessionManager.request(url, parameters: queryParameters).responseDecodable(of: Recipes.self) { response in
            /*
            guard let recipes = response.value else {
                return completionHandler (false,"An error occured",nil)
            }
            completionHandler(true,nil,recipes)
             */
            
            switch response.result {
            case .success(_):
                print("success")
                completionHandler(true,nil,response.value)
            
            case .failure(let error):
                
                switch error {

                case .responseSerializationFailed(_):
                    completionHandler(false,"An error occured, Please try again",nil)
                default:
                    completionHandler(false,"Session task failed, Please check connection",nil)
                }// End error switch
                
            }// End response switch
            
        }// end closure
        
    }// end function
    
    
    func getImage(url:String, completionHandler: @escaping ((Bool, String?, Data? ) -> Void)) {
        
        sessionManager.request(url).response { response in
            
            switch response.result {
            case .success(_):
                completionHandler(true,nil,response.data)
            
            case .failure(_):
                    completionHandler(false,"Session task failed, Please check connection",nil)
                
            }// End response switch
            
         }// end closure
        
    }
          
    
}


// Without Alamofire ...

/*
class RecipeService {
    
    static var shared = RecipeService()
    
    private var recipeSession = URLSession(configuration: .default)
    private var task: URLSessionDataTask?
    
    private init () {}

    init(recipeSession: URLSession) {
        self.recipeSession = recipeSession
    }
    
    func getRecipes(completionHandler: @escaping ((Bool, String?, Recipes? ) -> Void)) {
        
        let changeUrl = URL(string: "https://api.edamam.com/api/recipes/v2")!
        
        var request = URLRequest(url: changeUrl)
        request.httpMethod = "GET"
        
        task?.cancel()
        
        task = recipeSession.dataTask(with: request) { (data, response, error) in

            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print ("ERROR: \(String(describing: error?.localizedDescription))")
                    completionHandler (false, "Please verify connexion",nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print ("ERROR: \(String(describing: response))")
                    completionHandler (false, "Can't find recipe", nil)
                    return
                }
                guard let result = try? JSONDecoder().decode(Recipes.self, from: data) else {
                    print("JSON ERROR: \(String(describing: error?.localizedDescription))")
                    completionHandler (false, "An error occured", nil)
                    return
                }
                
                completionHandler (true, nil, result)
            }
        }
        task?.resume()
        
    }
 
    
}
*/



// All possible errors return by Alamofire ...
/*
switch error {

case .invalidURL(let url):
    print("Invalid URL: \(url)")
    errorHandler = "Invalid URL: \(url)"
case .parameterEncodingFailed(_):
    print("Parameter encoding failed")
    errorHandler = "Parameter encoding failed"
case .multipartEncodingFailed(_):
    print("Multipart encoding failed")
    errorHandler = "Multipart encoding failed"
case .responseValidationFailed(_):
    print("Response validation failed")
    errorHandler = "Response validation failed"
case .createUploadableFailed(_):
    print("Create uploadable failed")
    errorHandler = "Create uploadable failed"
case .createURLRequestFailed(_):
    print("Create url request failed")
    errorHandler = "Create url request failed"
case .downloadedFileMoveFailed(error: _, source: _, destination: _):
    print("Dowloaded file move failed")
    errorHandler = "Dowloaded file move failed"
case .explicitlyCancelled:
    print("Explicitly cancelled")
    errorHandler = "Explicitly cancelled"
case .parameterEncoderFailed(_):
    print("Parameter encoder failed")
    errorHandler = "Parameter encoder failed"
case .requestAdaptationFailed(_):
    print("Request adaptation failed")
    errorHandler = "Request adaptation failed"
case .requestRetryFailed(retryError: _, originalError: _):
    print("Request Retry failed")
    errorHandler = "Request Retry failed"
case .responseSerializationFailed(_):
    print("Response serialization failed")
    errorHandler = "Response serialization failed"
case .serverTrustEvaluationFailed(_):
    print("Server trust evaluation failed")
    errorHandler = "Server trust evaluation failed"
case .sessionDeinitialized:
    print("Session deinitialized")
    errorHandler = "Session deinitialized"
case .sessionInvalidated(_):
    print("Session invalidated")
    errorHandler = "Session invalidated"
case .sessionTaskFailed(_):
    print("Session task failed")
    errorHandler = "Session task failed"
case .urlRequestValidationFailed(_):
    print("URL request validation failed")
    errorHandler = "URL request validation failed"
    
}// End error switch
*/
