//
//  GetConversationsRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class GetConversationsRequest {
    private let chatroomId: String
    private let type: GetConversationType
    private let conversation: Conversation?
    private let limit: Int
    
    private init(chatroomId: String, type: GetConversationType, conversation: Conversation?, limit: Int) {
        self.chatroomId = chatroomId
        self.type = type
        self.conversation = conversation
        self.limit = limit
    }
    
    class Builder {
        private var chatroomId: String = ""
        private var type: GetConversationType = GetConversationType.NONE
        private var conversation: Conversation? = nil
        private var limit: Int = 50
        
        func chatroomId(chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func type(type: GetConversationType) -> Builder {
            self.type = type
            return self
        }
        
        func conversation(conversation: Conversation?) -> Builder {
            self.conversation = conversation
            return self
        }
        
        func limit(limit: Int) -> Builder {
            self.limit = limit
            return self
        }
        
        func build() -> GetConversationsRequest {
            return GetConversationsRequest(chatroomId: chatroomId, type: type, conversation: conversation, limit: limit)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().chatroomId(chatroomId)
            .type(type)
            .conversation(conversation)
            .limit(limit)
    }
}
