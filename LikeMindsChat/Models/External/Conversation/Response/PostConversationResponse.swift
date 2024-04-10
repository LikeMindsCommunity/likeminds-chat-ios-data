//
//  PostConversationResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 11/01/24.
//

import Foundation

public class PostConversationResponse: Decodable {
    public var conversation: Conversation?
    public var id: String?
    
    enum CodingKeys: String, CodingKey {
        case id, conversation
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIntToStringIfPresent(forKey: .id)
        conversation = try container.decodeIfPresent(Conversation.self, forKey: .conversation)
    }
}
