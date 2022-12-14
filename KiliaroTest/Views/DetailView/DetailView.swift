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
    
    
    
    init(imageOriginalUrl:URL?,creatDate:String) {
        
        self.model = DetailViewModel(imgUrl: imageOriginalUrl, creatDate: creatDate)
    }
    
    @State private var hidenavigationbar:Bool = false
    
    
    var body: some View {
        
        VStack {
            WebImage(url: model.imageUrl)
                .placeholder(content: {
                    ActivityIndicator(style: .large, color: .gray, isAnimating: .constant(true))
                })
                .resizable()
                .aspectRatio( contentMode: .fit)
                .ignoresSafeArea(.container, edges: .all)
                .onTapGesture {
                    withAnimation(.easeInOut){
                        self.hidenavigationbar.toggle()
                    }
                }

        }
        .frame(maxWidth:.infinity,maxHeight:.infinity)
        .background(Color.black.ignoresSafeArea())
        .overlay(headerView.opacity(hidenavigationbar ? 0 : 1),alignment: .top)

    }
    
    var headerView:some View {
        
        HStack{
            
            Text(model.creatDate)
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.leading,16)
            
            Spacer()
            
            Button(action: {
                
                prensentationValue.wrappedValue.dismiss()
                
            }, label: {
                Image(systemName: "chevron.down")
                    .resizable()
                    .renderingMode(.template)
                    .accentColor(.white)
                    .frame(width:32,height: 16,alignment: .center)
            })
            .padding(.trailing,16)
            
     
        }
        .frame(height:64)
        .background(Color.blue.blur(radius: 4).opacity(0.4).blendMode(BlendMode.colorBurn))
    }
    
}


