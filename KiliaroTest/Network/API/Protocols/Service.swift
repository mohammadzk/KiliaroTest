//
//  Service.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/10/22.
//

import Foundation
import Alamofire

/// unique sessionmanager that creat single session for all services with same host

let sessionManager:Alamofire.Session = {
    /// alamofire urlconfigartion
    let configration = URLSessionConfiguration.af.default
    
    configration.timeoutIntervalForRequest = 15.0
    
    configration.timeoutIntervalForResource = 15.0
    
    
    return Session(configuration: configration)
    
    
}()

///protocol 'Service' for each service that should be created
protocol Service {
    
    associatedtype ResultType : Codable
    
    //specefic session for each service
    var  session:Alamofire.Session {set get}
    
    var request:RequestBuilder {get}
    
    
    var path:String {set get}
  
    
    func run (_ completionHandler:@escaping (Result<ResultType>) -> Void)
}

//an extension for handling run function
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


