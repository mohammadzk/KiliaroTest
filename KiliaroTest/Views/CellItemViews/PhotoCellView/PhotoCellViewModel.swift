//
//  PhotoCellViewModel.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/13/22.
//

import Foundation

final  class PhotoCellViewModel:ObservableObject {
    
     
        @Published var imageUrl:URL?
     
       @Published    var fileSize:String
     
     
    
     
    
     
     init(imageUrl: URL?, fileSize: String) {
         
         self.fileSize = fileSize
 
         self.imageUrl = imageUrl

     }
     
     
     

}
