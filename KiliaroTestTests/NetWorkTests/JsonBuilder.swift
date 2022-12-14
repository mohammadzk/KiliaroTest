//
//  JsonBuilder.swift
//  KiliaroTestTests
//
//  Created by Mohammad khazaee on 12/9/22.
//

import Foundation
import XCTest

class fakeJsonBuilder{
    
    func datafromJsonFile(fileName:String)throws -> Data{
        let bundle = Bundle(for: fakeJsonBuilder.self)
        let jsonUrl = try XCTUnwrap(bundle.url(forResource:fileName ,withExtension:"json"))
        return try  Data(contentsOf: jsonUrl)
    }
    
}

