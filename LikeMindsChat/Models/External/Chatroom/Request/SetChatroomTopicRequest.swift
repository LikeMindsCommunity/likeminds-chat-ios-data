//
//  SetChatroomTopicRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

class SetChatroomTopicRequest {
    private let chatroomId: String
    private let conversationId: String
    
    private init(chatroomId: String, conversationId: String) {
        self.chatroomId = chatroomId
        self.conversationId = conversationId
    }
    
    class Builder {
        private var chatroomId: String = ""
        private var conversationId: String = ""
        
        func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        func build() -> SetChatroomTopicRequest {
            return SetChatroomTopicRequest(chatroomId: chatroomId, conversationId: conversationId)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder()
            .chatroomId(chatroomId)
            .conversationId(conversationId)
    }
}
