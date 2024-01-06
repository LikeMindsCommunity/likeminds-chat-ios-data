//
//  GetConversationMetaRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 21/07/23.
//

import Foundation

public class GetConversationMetaRequest: Encodable {
    var chatroomId: Int?
    var conversationId: Int?
    
    /// Initiate method
    private init() {}
    
    public static func builder() -> GetConversationMetaRequest {
        return GetConversationMetaRequest()
    }
    
    public func build() -> GetConversationMetaRequest {
        return self
    }
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
        case conversationId = "conversation_id"
    }
    
    public func chatroomId(_ chatroomId: Int) -> GetConversationMetaRequest {
        self.chatroomId = chatroomId
        return self
    }
    
    public func conversationId(_ conversationId: Int) -> GetConversationMetaRequest {
        self.conversationId = conversationId
        return self
    }
}
