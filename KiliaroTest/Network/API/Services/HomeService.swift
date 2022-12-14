//
//  HomeService.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/11/22.
//

import Foundation
import Alamofire

struct HomeService:Service {
    
    typealias ResultType = [PhotoModel]
    
    var session: Alamofire.Session = sessionManager
    
    var baseUrl:String
    
    var path:String
    
    var request: RequestBuilder{
      
        return RequestBuilder(self.baseUrl,path: path)
        
    }
  
    
}
