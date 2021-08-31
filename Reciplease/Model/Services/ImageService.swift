//
//  ImageService.swift
//  Reciplease
//
//  Created by Gilles Sagot on 26/08/2021.
//

import Foundation
import Alamofire


class ImageService {
    static var shared = ImageService()

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
        ImageService.shared = ImageService()
    }
    
    func getImage(url:String, completionHandler: @escaping ((Bool, String?, Data? ) -> Void)) {
        
        sessionManager.cancelAllRequests()
        
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

