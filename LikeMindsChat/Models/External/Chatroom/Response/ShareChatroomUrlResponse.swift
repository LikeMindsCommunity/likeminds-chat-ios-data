//
//  ShareChatroomUrlResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

struct ShareChatroomUrlResponse: Decodable {
    var shareChatroomUrl: ShareChatroomUrl
    
    enum CodingKeys: String, CodingKey {
        case shareChatroomUrl = "share_chatroom_url"
    }
}

struct ShareChatroomUrl: Decodable {
    var shareUrl: String?
    var creatorShareUrl: String?
    var linkCreatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case shareUrl = "share_url"
        case creatorShareUrl = "creator_share_url"
        case linkCreatedAt = "link_created_at"
    }
}
