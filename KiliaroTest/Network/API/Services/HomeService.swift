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
    
    var session: Alamofire.Session = {
        
        let configration = URLSessionConfiguration.af.default
        
        configration.timeoutIntervalForRequest = 15.0
        
        configration.requestCachePolicy = .returnCacheDataElseLoad
        
        return Session(configuration: configration)
        
    }()
    
    var baseUrl:String
    
    var pathItems:[String]
    
    var request: RequestBuilder{
        
        return RequestBuilder(self.baseUrl).addPathItems(parameters: pathItems)
        
    }
    
}
