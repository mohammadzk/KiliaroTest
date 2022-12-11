//
//  Result.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/11/22.
//

import Foundation
import Alamofire

enum Result<T> where T:Codable {
    case succes(T)
    case failure(AFError)
}
