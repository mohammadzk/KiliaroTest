//
//  PhotoCell.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/13/22.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI


struct PhotoCell:View {
    
    @ObservedObject private var model:PhotoCellViewModel
    
    init(imageUrl:URL?,fileSize:String) {
        
        self.model = PhotoCellViewModel(imageUrl: imageUrl, fileSize: fileSize)
    }
    
    var body: some View{
        
            WebImage(url: model.imageUrl)
                .resizable()
                .placeholder {
                    
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.gray)
                        .overlay(ActivityIndicator(style: .medium, color: .darkGray, isAnimating: .constant(true)))
                 
                }
                .aspectRatio( contentMode: .fill)
                .overlay (
                    Text(model.fileSize)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth:.infinity)
                        .background(Color.gray.blur(radius: 4).opacity(0.5))
                    ,alignment: .bottom )
                .cornerRadius(6)
               
        
        
    }
}
