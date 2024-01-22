//
//  CommunityMetaNetworkModel.swift
//  CollabMates
//
//  Created by Devansh Mohata on 20/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

public struct Community: Decodable {
    let id: Int?
    let imageURL: String?
    let name: String?
    let membersCount: Int?
    let purpose: String?
    let subType: Int?
    let type: Int?
    let updatedAt: Int32?
    
    enum CodingKeys: String, CodingKey {
        case id,
             type,
             name,
             purpose
        
        case imageURL = "image_url",
             subType = "sub_type",
             membersCount = "members_count",
             updatedAt = "updated_at"
        
    }
}
