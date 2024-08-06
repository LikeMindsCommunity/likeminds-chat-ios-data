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
    
    enum CodingKeys: String, CodingKey {
        case id, conversation
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIntToStringIfPresent(forKey: .id)
        conversation = try container.decodeIfPresent(Conversation.self, forKey: .conversation)
    }
}
