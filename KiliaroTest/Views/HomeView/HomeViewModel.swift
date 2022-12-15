//
//  HomeViewModel.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/13/22.
//

import Foundation
import Combine
import SDWebImage

final class HomeViewModel:ObservableObject {
    
    @Published var items:[ItemModel] = []
    
    @Published var status:LoadStatus = .idle
    
    @Published var itemsPerRow:Int
    
    @Published var itemWidth:CGFloat = CGFloat.zero
    
    @Published var itemHeight:CGFloat = CGFloat.zero
    
    
    
    private var cache:CacheHandler<[PhotoModel]>
    
    private var cacheKey = "home"
    
    
    
    private   func clearImageCache(){
        
        SDImageCache.shared.clear(with: .all)
        
    }
    
    private var cancleables:Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(itemsperRow:Int = 3) {
        
        self.itemsPerRow = itemsperRow
        
        self.cache = CacheHandler<[PhotoModel]>()
        
        $status
            .first(where: {$0 == .loading})
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.load()
            }
            .store(in: &cancleables)
    }
    
  
    
    func refresh(){
        
        self.items = []
        
        self.status = .loading
        
        do{
            try cache.delete(with: "home")
            clearImageCache()
        }
        catch let error {
            
            debugPrint(error.localizedDescription)
            
        }
        self.loadPhotos()
    }
    
    func load(){
        guard cache.cacheDataExists(with: self.cacheKey) else {
            self.loadPhotos()
            return
        }
        do {
            let photos =  try cache.retrive(with: self.cacheKey)
            
            self.items = photos.compactMap({ photo in
                
                return  try?   ItemModel(itemId: photo.fileId, imageUrlstr: photo.thumbnailUrlStr, dateStr:photo.createdAt?.projectDateString() , size: photo.size.toMegabytes())
            })
            status = .firstBatchLoaded
        }
        catch let error {
            debugPrint(error.localizedDescription)
            self.loadPhotos()
        }
    }
    
    func loadPhotos(){
        
        let service = HomeService(baseUrl: APIConstants.baseURL, path: APIConstants.sharedEndPoint(with: APIConstants.costantSharedKey))
        
        service.run { [weak self] result in
            
            guard let strongSelf = self else {
                return
            }
            
            switch result {
                
            case .succes(let photos):
                
                
                
                strongSelf.items = photos.compactMap({ photo in
                    
                    return  try?   ItemModel(itemId: photo.fileId, imageUrlstr: photo.thumbnailUrlStr, dateStr:photo.createdAt?.projectDateString() , size: photo.size.toMegabytes())
                })
                
                
                strongSelf.status = .firstBatchLoaded
                
                do {
                    try strongSelf.cache.save(object: photos, with: strongSelf.cacheKey)
                }
                catch let error{
                    
                    debugPrint(error.localizedDescription)
                    
                }
            case .failure(let error):
                
                switch error {
                    
                case .responseSerializationFailed(_):
                    strongSelf.status = .failure(error:   "oh,Wrong data retrived ,Please be patient, we are working on it " )
                default:
                    strongSelf.status = .failure(error:   "oh,Something went wrong,Problem accessing data, Please check your Internet connection. " )
                    
                }
                
                debugPrint(error.errorDescription ?? "")
              
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

}

extension HomeViewModel {
    
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


