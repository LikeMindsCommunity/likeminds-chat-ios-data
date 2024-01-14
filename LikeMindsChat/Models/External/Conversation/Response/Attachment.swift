//
//  Attachment.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 11/01/24.
//

import Foundation

struct Attachment {
    
    var id: String?
    var name: String?
    var url: String
    var type: String
    var index: Int?
    var width: Int?
    var height: Int?
    var awsFolderPath: String?
    var localFilePath: String?
    var thumbnailUrl: String?
    var thumbnailAWSFolderPath: String?
    var thumbnailLocalFilePath: String?
    var meta: AttachmentMeta?
    var createdAt: Int?
    var updatedAt: Int?
    
}
