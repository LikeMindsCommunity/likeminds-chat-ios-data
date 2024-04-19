//
//  DeleteConversationPermanentlyRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public class DeleteConversationPermanentlyRequest {
    private let conversationId: String
    private let chatroomId: String
    
    private init(conversationId: String, chatroomId: String) {
        self.conversationId = conversationId
        self.chatroomId = chatroomId
    }
    
    public static func builder() -> Builder {
        Builder()
    }
    
    public class Builder {
        private var conversationId: String = ""
        private var chatroomId: String = ""
        
        public func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        public func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func build() -> DeleteConversationPermanentlyRequest {
            return DeleteConversationPermanentlyRequest(conversationId: conversationId, chatroomId: chatroomId)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder().conversationId(conversationId).chatroomId(chatroomId)
    }
}
