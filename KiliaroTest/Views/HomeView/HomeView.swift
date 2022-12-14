//
//  HomeView.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/12/22.
//

import SwiftUI

struct HomeView: View {
    
    
    
    
    @ObservedObject var model:HomeViewModel
    
    init(model: HomeViewModel = HomeViewModel()) {
        
        self.model = model
        
    }
    
    var body: some View {
        GeometryReader { reader in
            ScrollView(.vertical,showsIndicators: false){
                
                getView
                
            }
            .onAppear{
                
                model.status = .loading
                self.model.itemWidth = (reader.frame(in: .global).width  / CGFloat(model.itemsPerRow)) - CGFloat((model.itemsPerRow + 1) * 4 )
                
                self.model.itemHeight = (reader.frame(in: .global).width / CGFloat(model.itemsPerRow)) - CGFloat((model.itemsPerRow + 1) * 4 )
                
            }
            
        }
        .frame(maxWidth:.infinity)
        
        
    }
    
    var getView:some View {
        VStack {
            switch model.status {
            case .idle,.firstBatchLoaded:
                
                
                LazyVGrid(columns: self.columns) {
                    
                    ForEach(model.items) { item in
                        
                        PhotoCell(imageUrl: model.idealSizeImageUrl( imgUrl: item.imageUrl), fileSize: item.size)
                            .frame(width: model.itemWidth,height: model.itemHeight)
                        
                    }
                }
                .padding()
                
            case .loading:
                Text("Loading ..")
                
            case .failure(error:let  message):
                
                Text(message)
            }
        }
    }
    
    private var columns: [GridItem]{
        
        var colums = [GridItem]()
        
        for _ in (0..<model.itemsPerRow)  {
            
            colums.append(GridItem(.flexible()))
        }
        return colums
    }
}


