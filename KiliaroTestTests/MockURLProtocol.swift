//
//  MockAlamofireSession.swift
//  KiliaroTestTests
//
//  Created by Mohammad khazaee on 12/11/22.
//

import Foundation


class MockURLProtocol:URLProtocol {
    
    var activeTask:URLSessionTask?
    
   static  var response:ResponseType!
    
    private lazy var session:URLSession = {
        let configration = URLSession(configuration: URLSessionConfiguration.ephemeral)
        return configration
    }()
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return false
    }
    
    override func startLoading() {
        
        activeTask =  session.dataTask(with:request.urlRequest!)
        activeTask?.delegate = self

       activeTask?.cancel()
        
    }
    override func stopLoading() {
        
        activeTask?.cancel()
    }
    enum ResponseType{
        case error(Error)
        case success(HTTPURLResponse)
    }
}

extension MockURLProtocol:URLSessionDataDelegate{
    
    enum mockError:Error {
    case none
    }
  static   func responseWithError(){
        MockURLProtocol.response = .error(mockError.none)
    }
 static   func responseWithSuccesWith(statusCode:Int,url:URL){
        MockURLProtocol.response = .success(HTTPURLResponse(url: url, statusCode:statusCode , httpVersion: nil, headerFields: nil)!)
    }
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        client?.urlProtocol(self, didLoad: data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        switch MockURLProtocol.response{
            
        case .error(let error):
            client?.urlProtocol(self, didFailWithError: error)
        case .success(let response):
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        default:
            break
        }
        client?.urlProtocolDidFinishLoading(self)
    }
}


