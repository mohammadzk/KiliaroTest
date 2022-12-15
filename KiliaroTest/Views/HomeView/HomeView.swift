//
//  HomeView.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/12/22.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject var model:HomeViewModel
    
    @State private var selectedItem:HomeViewModel.ItemModel? = nil
    
    init(model: HomeViewModel = HomeViewModel()) {
        
        self.model = model
        
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { reader in
                
                ScrollView(.vertical,showsIndicators: false){
                    
                    getView
                    
                }
                .onAppear{
                    
                    model.status = .loading
                    //getting the item width due to screnn width
                    let fixedwidth  =  (reader.frame(in: .global).width  / CGFloat(model.itemsPerRow)) - CGFloat((model.itemsPerRow + 1) * 4 )
                    
                    self.model.itemWidth = fixedwidth
                    
                    self.model.itemHeight = fixedwidth
                    
                }
                
            }
            .frame(maxWidth:.infinity)
            .navigationTitle(Text("Kiliaro"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                
                model.refresh()
                
            }, label: {
                Image(systemName:"arrow.triangle.2.circlepath")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width:40,height:30)
            }))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(item: $selectedItem, onDismiss: {
            selectedItem = nil
        }, content: { item in
            DetailView(imageOriginalUrl: item.imageUrl, creatDate: item.creatDate)
        })
    
    }
    //MARK: specefic views and function
    var getView:some View {
        VStack(alignment:.center) {
            switch model.status {
            case .idle,.firstBatchLoaded:
                
                
                LazyVGrid(columns: self.columns,spacing: 16) {
                    
                    ForEach(model.items) { item in
                        
                        PhotoCell(imageUrl: model.idealSizeImageUrl( imgUrl: item.imageUrl), fileSize: item.size)
                            .frame(width: model.itemWidth,height: model.itemHeight)
                            .onTapGesture {
                                
                                self.selectedItem = item
        
                            }
                        
                    }
                }
                .padding()
                
            case .loading:
                
                
                
                ActivityIndicator(style: .large, color: .darkGray, isAnimating: .constant(true))
                    .position(x:UIScreen.main.bounds.midX,y: UIScreen.main.bounds.midY)
                
                
                
            case .failure(error:let  message):
                
                Spacer()
                
                VStack {
                    Spacer()
                    Image(systemName: "xmark.octagon")
                        .resizable()
                        .frame(width: 32,height: 32)
                    
                    Text(message)
                        .font(.body)
                        .padding()
                }
                
                Spacer()
              
            }
        }
      
    }
    /// colums for grid with items per row
    private var columns: [GridItem]{
        
        var colums = [GridItem]()
        
        for _ in (0..<model.itemsPerRow)  {
            
            colums.append(GridItem(.flexible()))
        }
        return colums
    }
}


