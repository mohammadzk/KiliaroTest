//
//  APIConstans.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/13/22.
//

import Foundation

struct APIConstants{
    
    static var baseURL = "https://api1.kiliaro.com"
    
    
    static var costantSharedKey = "djlCbGusTJamg_ca4axEVw"
    
     
    static func sharedEndPoint(with sharedKey:String) -> String {
        return String(format: "/shared/%@/media", sharedKey)
    }
    
    
}
