//
//  MainWindowEnvironmentKey.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/13/22.
//

import Foundation
import SwiftUI

private struct MainWindowKey:EnvironmentKey{
    
    static let defaultValue:CGSize = CGSize.zero
}

extension EnvironmentValues{
    
    var mainWindowSize:CGSize {
        get {self[MainWindowKey.self]}
        set{self[MainWindowKey.self] = newValue}
    }
}
