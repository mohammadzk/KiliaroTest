//
//  StringExtension.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/13/22.
//

import Foundation

extension String {
    
    func  projectDateString()->String?{

        guard let date =   DateFormatter.Project.gmtDateFormatter.date(from: self) else {
            return nil
        }
        return DateFormatter.Project.currentTimeDateFormatter.string(from: date)
    }
    
}
