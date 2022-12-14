//
//  Service.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/10/22.
//

import Foundation
import Alamofire

let sessionManager:Alamofire.Session = { 
    
    let configration = URLSessionConfiguration.af.default
    
    configration.timeoutIntervalForRequest = 15.0
    
    configration.timeoutIntervalForResource = 15.0
    
    
    return Session(configuration: configration)
    
    
}()

protocol Service {
    
    associatedtype ResultType : Codable
    
    var  session:Alamofire.Session {set get}
    
    var request:RequestBuilder {get}
    
    var path:String {set get}
  
    
    func run (_ completionHandler:@escaping (Result<ResultType>) -> Void)
}

extension Service {
    
    
    func run (_ completionHandler:@escaping (Result<ResultType>) -> Void) {
        
        self.session.request(self.request).response { response in
            
            switch response.result {
                
            case.success(let data):
                
                guard let responseData = data else {
                    
                    completionHandler(.failure(.responseSerializationFailed(reason: .inputDataNilOrZeroLength)))
                    return
                }
              
                do {
                    
                    let parsedObject = try JSONDecoder().decode(ResultType.self, from: responseData)
                    
                    completionHandler(.succes(parsedObject))
                }
                
                catch let error {
                    completionHandler(.failure(.responseSerializationFailed(reason: .decodingFailed(error: error))))
                }
                
            case .failure(let error):
                completionHandler(.failure(error))
                
            }
            
        }
    }
    
}


