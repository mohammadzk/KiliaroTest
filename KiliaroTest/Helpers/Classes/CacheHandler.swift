//
//  CacheHandler.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/14/22.
//

import Foundation

final class CacheHandler<T:Codable> {
    
    let fileManager:FileManager
    
    let directory:FileManager.SearchPathDirectory
    
    let domainMask:FileManager.SearchPathDomainMask
    
    
    init (fileManager:FileManager = .default, directory:FileManager.SearchPathDirectory = .cachesDirectory,domainMask:FileManager.SearchPathDomainMask = .userDomainMask){
        
        self.fileManager = fileManager
        
        self.directory = directory
        
        self.domainMask = domainMask
        
    }
    
    private func fileUrl(with key:String)-> URL {
        
        let directoryUrls = fileManager.urls(for: directory, in: domainMask)
        
        return directoryUrls[0].appendingPathComponent(key + ".cache")
    }
    
    func cacheDataExists(with key:String) -> Bool {
        
        let fileurl = self.fileUrl(with: key)
        
        return fileManager.fileExists(atPath: fileurl.path)
    }
    
    func save(object:T,with key:String)throws{

        let fileurl = self.fileUrl(with: key)
        
        if  fileManager.fileExists(atPath: fileurl.path){
           try  self.delete(with: key)
        }
        
        let json = try JSONEncoder().encode(object)
        
        try json.write(to:fileurl )
        

    }
    
    func retrive(with key:String)throws -> T {
        
        let fileurl = self.fileUrl(with: key)
        
        let data = try Data(contentsOf:fileurl)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func delete(with key:String)throws {
        
        let fileurl = self.fileUrl(with: key)
        
       try   fileManager.removeItem(at: fileurl)
        
    }
    
    
}





















