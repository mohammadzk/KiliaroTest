//
//  RequestBuilder.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/10/22.
//

import Foundation
import Alamofire

class RequestBuilder:URLRequestConvertible {
    
    var request:URLRequest
    
    typealias Parameters = [String:Any]
    
    init(request: URLRequest) {
        
        self.request = request
        
    }
    
    init(_ baseUrl:String,path:String = ""){
        
        guard let url = URL(string: "\(baseUrl)\(path)") else {
            
            fatalError("wrong baseurl and path")
        }
        
        self.request = URLRequest(url:url)
    }
    
    func add(headers:[String:String])-> RequestBuilder {
        
        var rq = self.request
        
        for(key,value) in headers {
            
            rq.setValue(value, forHTTPHeaderField: key)
            
        }
        
        return RequestBuilder(request: rq)
    }

    func addQuery( parameters:Parameters)->RequestBuilder {
        
        let rq = self.request
        
        guard let urlRequest = try? URLEncoding.default.encode(rq, with: parameters) else {
            fatalError("cannot encode parametes")
        }
        
        return RequestBuilder(request: urlRequest)
    }
    func setMethod(method:HTTPMethod)->RequestBuilder{
        
        var req = self.request
        
        req.method = method
        
        return RequestBuilder(request: req)
        
    }
    
    func asURLRequest() throws -> URLRequest {
        return self.request
    }
    
    func Url()->URL? {
        
        return self.request.url
        
    }
}




