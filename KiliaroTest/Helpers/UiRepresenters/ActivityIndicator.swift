//
//  ActivityIndicator.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/14/22.
//

import Foundation
import SwiftUI

struct ActivityIndicator:UIViewRepresentable {
    
    typealias UIViewType = UIActivityIndicatorView
    
    var style :UIActivityIndicatorView.Style
    
    var color: UIColor
    
    @Binding var isAnimating:Bool
    
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        
        let view  = UIActivityIndicatorView()
        
        view.style = self.style
        
        view.color = color
        
        view.startAnimating()
        
        return view
        
    
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
        if isAnimating {
            uiView.startAnimating()
        }
        else {
            uiView.stopAnimating()
        }
        
    }
    
    
    
    
}
