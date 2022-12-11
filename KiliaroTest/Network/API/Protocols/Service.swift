//
//  Service.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/10/22.
//

import Foundation
import Alamofire

protocol Service {
    
    associatedtype ResultType : Codable
    
    var  session:Alamofire.Session {set get}
    
    var request:RequestBuilder {get}
    
  
    
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


