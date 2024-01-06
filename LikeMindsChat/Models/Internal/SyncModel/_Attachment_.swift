//
//  CardAttachmentNetworkDataModel.swift
//  CollabMates
//
//  Created by Devansh Mohata on 20/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

struct _Attachment_: Decodable {
    let id: Int?
//    let dimensions: JSONNull?
    let index: Int?
    let width: Int?
    let thumbnailURL: String?
    let collabcardID: Int?
    let type, attachment: String?
    let fileURL: String?
    let height: Int?
//    let meta: JSONNull?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, 
//             dimensions,
             index,
             width
        case thumbnailURL = "thumbnail_url"
        case collabcardID = "collabcard_id"
        case type, 
             attachment
        case fileURL = "file_url"
        case height, 
//             meta,
             name
    }
}
