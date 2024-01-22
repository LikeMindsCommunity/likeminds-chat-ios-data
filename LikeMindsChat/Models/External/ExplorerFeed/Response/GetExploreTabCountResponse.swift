//
//  GetExploreTabCountResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 12/07/23.
//

import Foundation

public struct GetExploreTabCountResponse: Decodable {
    let unseenChatroomCount: Int?
    let totalChatroomCount: Int?
    
    private enum CodingKeys: String, CodingKey {
        case unseenChatroomCount = "unseen_channel_count"
        case totalChatroomCount = "total_channel_count"
    }
}
