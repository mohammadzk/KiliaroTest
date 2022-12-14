//
//  Formatters.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/13/22.
//

import Foundation


extension DateFormatter {
    
    struct Project{
        
        static let gmtDateFormatter:DateFormatter = {
            
            let formater = DateFormatter()
            
            formater.locale = Locale(identifier: "en_US_POSXI")
            
             formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            return formater
        }()
        
        static let currentTimeDateFormatter: DateFormatter = {
            let formater = DateFormatter()
            
            formater.locale = Locale(identifier: "en_US_POSXI")
            
            formater.dateFormat = "yyyy-MM-dd-HH:mm"
            
            formater.timeZone = .current
            
            return formater
            
        }()
        
    }
    
}
