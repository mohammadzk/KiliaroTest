//
//  NumberExtetion.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/13/22.
//

import Foundation

extension Int {
    
    func toMegabytes()->String{
        
       let numberinDouble = Double(self)
        
        let mb = numberinDouble / 1_024 / 1_024
        
        let mbStringFormated = String(format: "%.2f", mb)
        
        return "\(mbStringFormated) MB"
    }
    
}
