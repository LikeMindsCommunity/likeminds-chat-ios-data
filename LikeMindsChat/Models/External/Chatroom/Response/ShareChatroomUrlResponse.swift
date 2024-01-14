//
//  ShareChatroomUrlResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

struct ShareChatroomUrlResponse {
    var shareChatroomUrl: ShareChatroomUrl
}

struct ShareChatroomUrl {
    var shareUrl: String?
    var creatorShareUrl: String?
    var linkCreatedAt: String?
}
