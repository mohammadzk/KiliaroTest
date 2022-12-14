//
//  PhotoModel.swift
//  KiliaroTest
//
//  Created by Mohammad khazaee on 12/9/22.
//

import Foundation

struct PhotoModel:Codable {
    
    let fileId:String
    
    let userId:String
    
    let mediaType:String
    
    let fileName:String
    
    let size:Int
    
    var createdAt:String?
    
    var takenAt:String?
    
    var guessedTakenAt:String?
    
    var md5sum:String?
    
    var contentType:String?
    
    var videoUrlStr:String?
    
    var thumbnailUrlStr:String?
    
    var  downloadUrlStr:String?
    
    var   resx:Double?
    
    var resy:Double?
    
    private enum PhotoCodingKeys:String,CodingKey {
        
        case fileId = "id"
        
        case userId = "user_id"
        
        case mediaType = "media_type"
        
        case filename
        
        case size
        
        case createdAt = "created_at"
        
        case takenAt = "taken_at"
        
        case guessedTakenAt = "guessed_taken_at"
        
        case md5sum
        
        case contentType = "contentType"
        
        case videoUrl = "video"
        
        case thumbnailUrl = "thumbnail_url"
        
        case downloadUrl = "download_url"
        
        case resx
        
        case resy
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: PhotoCodingKeys.self)
        
        self.fileId = try container.decode(String.self, forKey: .fileId)
        
        self.userId = try container.decode(String.self, forKey: .userId)
        
        self.mediaType = try container.decode(String.self, forKey: .mediaType)
        
        self.fileName = try container.decode(String.self, forKey: .filename)
        
        self.size = try container.decode(Int.self, forKey: .size)
        
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        
        self.takenAt = try container.decodeIfPresent(String.self, forKey: .takenAt)
        
        self.guessedTakenAt = try container.decodeIfPresent(String.self, forKey: .guessedTakenAt)
        
        self.md5sum = try container.decodeIfPresent(String.self, forKey: .md5sum)
        
        self.contentType = try  container.decodeIfPresent(String.self, forKey: .contentType)
        
        self.videoUrlStr = try container.decodeIfPresent(String.self, forKey: .videoUrl)
        
        self.thumbnailUrlStr = try container.decodeIfPresent(String.self, forKey: .thumbnailUrl)
        
        self.downloadUrlStr = try container.decodeIfPresent(String.self, forKey: .downloadUrl)
        
        self.resx = try container.decodeIfPresent(Double.self, forKey: .resx)
        
        self.resy = try container.decodeIfPresent(Double.self, forKey: .resy)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PhotoCodingKeys.self)
        
        try container.encode(fileId, forKey: .fileId)
        
        try  container.encode(userId, forKey: .userId)
        
        try  container.encode(mediaType, forKey: .mediaType)
        
        try container.encode(fileName, forKey: .filename)
        
        try  container.encode(size, forKey: .size)
        
        try container.encodeIfPresent(createdAt, forKey: .createdAt)
        
        try container.encodeIfPresent(takenAt, forKey: .takenAt)
        
        try container.encodeIfPresent(guessedTakenAt, forKey: .guessedTakenAt)
        
        try container.encodeIfPresent(contentType, forKey: .contentType)
        
        try container.encodeIfPresent(videoUrlStr, forKey: .videoUrl)
        
        try container.encodeIfPresent(thumbnailUrlStr, forKey: .thumbnailUrl)
        
        try container.encodeIfPresent(downloadUrlStr, forKey: .downloadUrl)
        
        try container.encodeIfPresent(resx, forKey: .resx)
        
        
        try container.encodeIfPresent(resy, forKey: .resy)
        
        
    }
    
}



