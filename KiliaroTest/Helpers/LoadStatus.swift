//
//  LoadStatus.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/13/22.
//

import Foundation

enum LoadStatus:Equatable{
    
        case loading
    
        case firstBatchLoaded
    
        case idle
    
        case failure(error:String)
    
}

func ==(lhs: LoadStatus, rhs: LoadStatus) -> Bool {
    
    switch (lhs,rhs){
        
    case (.idle,.idle):
        
            return true
        
    case (.firstBatchLoaded,.firstBatchLoaded):
        
            return true
        
    case (.loading,.loading):
        
            return true
        
    case (.failure(error:let  erstrl),.failure(error: let erstr2)):
        
            if erstrl == erstr2 {
            
                return true
            
                }
        
                return false
        
    default:
        
                return false
        
    }
    
}
