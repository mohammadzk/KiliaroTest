//
//  HomeViewModel.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/13/22.
//

import Foundation
import Combine

class HomeViewModel:ObservableObject {
    
    @Published var items:[ItemModel] = []
    
    @Published var status:LoadStatus = .idle
    
    @Published var itemsPerRow:Int
    
    @Published var itemWidth:CGFloat = CGFloat.zero
    
    @Published var itemHeight:CGFloat = CGFloat.zero
    
    private var cancleables:Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(itemsperRow:Int = 3) {
        
        self.itemsPerRow = itemsperRow
        
        $status
            .first(where: {$0 == .loading})
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.loadPhotos()
            }
            .store(in: &cancleables)
    }
    
    
    func loadPhotos(){
        
        let service = HomeService(baseUrl: APIConstants.baseURL, path: APIConstants.sharedEndPoint(with: APIConstants.costantSharedKey))
        
        service.run { result in
            
            switch result {
                
            case .succes(let photos):
                
                
                
                self.items = photos.compactMap({ photo in
                    
                    return  try?   ItemModel(itemId: photo.fileId, imageUrlstr: photo.thumbnailUrlStr, dateStr:photo.createdAt?.projectDateString() , size: photo.size.toMegabytes())
                })
                
                self.status = .firstBatchLoaded
                
            case .failure(let error):
                
                self.status = .failure(error: error.errorDescription!)
                
            }
        }
        
    }
    
    func idealSizeImageUrl(imgUrl:URL?)->URL?{
        
        let formater = NumberFormatter()
        
        guard
            let imageUrl = imgUrl,
            let widthStr = formater.string(from: NSNumber.init(value: Int(self.itemWidth))),
            let heightStr = formater.string(from: NSNumber(value: Int(self.itemHeight)))
        else {
            return nil
        }
    
       return RequestBuilder(request: URLRequest.init(url: imageUrl))
                                                   .addQuery(parameters: ["w":widthStr , "h":heightStr ,"m":"crop"])
                                                   .Url()
       
 
    }
    
    struct  ItemModel:Identifiable {
        
        var id:String
        
        var imageUrl:URL
        
        var creatDate:String
        
        var size:String
        
        init(itemId:String,imageUrlstr:String?,dateStr:String?,size:String)throws{
            
            guard let imgstr = imageUrlstr,
           let imgurl = URL (string: imgstr) else {
                throw Objectvalidator.invalid("image url is nil")
            }
            self.id = itemId
            
            self.imageUrl = imgurl
            
            self.creatDate  = dateStr == nil ? "no date recorded" : dateStr!
            
            self.size = size
            
            
        }
        
    }
    
}


