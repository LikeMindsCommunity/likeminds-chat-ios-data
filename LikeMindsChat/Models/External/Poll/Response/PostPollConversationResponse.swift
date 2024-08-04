//
//  PostPollConversationResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public struct PostPollConversationResponse: Decodable {
    public var id: String?
    public var conversation: Conversation?
}
