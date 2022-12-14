//
//  DetailViewModel.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/14/22.
//

import Foundation

class DetailViewModel:ObservableObject {
    
    @Published var imageUrl:URL?
    
    @Published var creatDate:String
    
    init(imgUrl:URL?,creatDate:String){
        
        self.imageUrl = imgUrl
        
        self.creatDate = creatDate
    }
    
}
