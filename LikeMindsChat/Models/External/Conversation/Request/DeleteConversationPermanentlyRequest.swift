//
//  DeleteConversationPermanentlyRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class DeleteConversationPermanentlyRequest {
    private let conversationId: String
    private let chatroomId: String
    
    private init(conversationId: String, chatroomId: String) {
        self.conversationId = conversationId
        self.chatroomId = chatroomId
    }
    
    class Builder {
        private var conversationId: String = ""
        private var chatroomId: String = ""
        
        func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func build() -> DeleteConversationPermanentlyRequest {
            return DeleteConversationPermanentlyRequest(conversationId: conversationId, chatroomId: chatroomId)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().conversationId(conversationId).chatroomId(chatroomId)
    }
}
