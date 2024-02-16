//
//  PostPollConversationResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

struct PostPollConversationResponse: Decodable {
    var id: String
    var conversation: Conversation
}
