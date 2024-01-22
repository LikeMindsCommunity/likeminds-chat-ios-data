//
//  Attachment.swift
//  CollabMates
//
//  Created by Devansh Mohata on 20/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

struct Attachment: Decodable {
    let id: String?
    let name: String?
    let url: String?
    let type: String?
    let index: Int?
    let width: Int?
    let height: Int?
    let awsFolderPath: String?
    let localFilePath: String?
    let thumbnailUrl: String?
    let thumbnailAWSFolderPath: String?
    let thumbnailLocalFilePath: String?
    let meta: AttachmentMeta?
    let createdAt: Int64?
    let updatedAt: Int64?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case type
        case index
        case width
        case height
        case awsFolderPath = "aws_folder_path"
        case localFilePath = "local_file_path"
        case thumbnailUrl = "thumbnail_url"
        case thumbnailAWSFolderPath = "thumbnail_aws_folder_path"
        case thumbnailLocalFilePath = "thumbnail_local_folder_path"
        case meta
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        index = try container.decodeIfPresent(Int.self, forKey: .index)
        width = try container.decodeIfPresent(Int.self, forKey: .width)
        height = try container.decodeIfPresent(Int.self, forKey: .height)
        awsFolderPath = try container.decodeIfPresent(String.self, forKey: .awsFolderPath)
        localFilePath = try container.decodeIfPresent(String.self, forKey: .localFilePath)
        thumbnailUrl = try container.decodeIfPresent(String.self, forKey: .thumbnailUrl)
        thumbnailAWSFolderPath = try container.decodeIfPresent(String.self, forKey: .thumbnailAWSFolderPath)
        thumbnailLocalFilePath = try container.decodeIfPresent(String.self, forKey: .thumbnailLocalFilePath)
        meta = try container.decodeIfPresent(AttachmentMeta.self, forKey: .meta)
        createdAt = try container.decodeIfPresent(Int64.self, forKey: .createdAt)
        updatedAt = try container.decodeIfPresent(Int64.self, forKey: .updatedAt)
    }
}
