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
    
    func getImage(url:String?, completionHandler: @escaping ((Bool, String?, Data? ) -> Void)) {
    
        guard let urlValide = url else {return completionHandler(false,nil,nil)}
        sessionManager.request(urlValide).response { response in
            
            switch response.result {
            case .success(_):
                completionHandler(true,nil,response.data)
            
            case .failure(_):
                completionHandler(false,"Session task failed, Please check connection",nil)
                
            }// End response switch
            
         }// end closure
        
    }
          
}
