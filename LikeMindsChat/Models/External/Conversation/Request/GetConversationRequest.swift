//
//  GetConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class GetConversationRequest {
    private let conversationId: String
    
    private init(conversationId: String) {
        self.conversationId = conversationId
    }
    
    class Builder {
        private var conversationId: String = ""
        
        func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        func build() -> GetConversationRequest {
            return GetConversationRequest(conversationId: conversationId)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().conversationId(conversationId)
    }
}
