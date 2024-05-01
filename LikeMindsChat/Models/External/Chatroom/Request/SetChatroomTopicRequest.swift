//
//  SetChatroomTopicRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

public class SetChatroomTopicRequest: Encodable {
    let chatroomId: String
    let conversationId: String
    
    private init(chatroomId: String, conversationId: String) {
        self.chatroomId = chatroomId
        self.conversationId = conversationId
    }
    
    public static func builder() -> Builder {
        Builder()
    }
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
        case conversationId = "conversation_id"
    }
    
    public class Builder {
        private var chatroomId: String = ""
        private var conversationId: String = ""
        
        public func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        public func build() -> SetChatroomTopicRequest {
            return SetChatroomTopicRequest(chatroomId: chatroomId, conversationId: conversationId)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder()
            .chatroomId(chatroomId)
            .conversationId(conversationId)
    }
}
