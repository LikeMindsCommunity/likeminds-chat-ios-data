//
//  ConversationAttachmentMetaNetworkModel.swift
//  CollabMates
//
//  Created by Devansh Mohata on 20/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

struct _ConversationAttachment_: Decodable {
    let answerID: Int?
    let createdAt: Int?
    let fileURL: String?
    let id: Int?
    let index: Int?
    
//    let locationLat,
//        locationLong,
//        locationName,
//        dimensions,
//        height,
//        width: String?
    
    let meta: Meta?
    let name: String?
    let thumbnailURL: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case answerID = "answer_id",
             createdAt = "created_at",
             fileURL = "file_url",
             thumbnailURL = "thumbnail_url"
        
        case type,
             meta,
             name,
             id,
             index
        
//        case dimensions,
//             height,
//             width,
//             locationLat = "location_lat",
//             locationLong = "location_long",
//             locationName = "location_name"
    }
    
    struct Meta: Decodable {
        let duration,
            size: Int?
    }
}
