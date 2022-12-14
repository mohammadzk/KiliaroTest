//
//  DetailView.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/14/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    
    @ObservedObject private var model:DetailViewModel
    
    @Environment (\.presentationMode) private var prensentationValue
    
    @Environment (\.colorScheme) private var coloScheme
    
    init(imageOriginalUrl:URL?,creatDate:String) {
        
        self.model = DetailViewModel(imgUrl: imageOriginalUrl, creatDate: creatDate)
    }
    
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                WebImage(url: model.imageUrl)
                    .resizable()
                    .aspectRatio( contentMode: .fill)
                    .ignoresSafeArea(.container, edges: .bottom)
                
            }
            .background(Color.black)
            .navigationBarTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Text(model.creatDate)
                .foregroundColor(coloScheme == .light ? .black : .white)
                .font(.headline)
                                , trailing: Button(action: {
                
                prensentationValue.wrappedValue.dismiss()
                
            }, label: {
                Image(systemName: "chevron.down")
                    .resizable()
                    .renderingMode(.template)
                    .accentColor(.gray)
                    .frame(width:32,height: 16,alignment: .center)
                    
                
            }))
            
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


