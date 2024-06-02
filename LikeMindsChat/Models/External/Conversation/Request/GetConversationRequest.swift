//
//  GetConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public class GetConversationRequest: Encodable {
    let conversationId: String
    
    private init(conversationId: String) {
        self.conversationId = conversationId
    }
    
    public static func builder() -> Builder {
        return Builder()
    }
    
    enum CodingKeys: String, CodingKey {
        case conversationId = "conversation_id"
    }
    
    public class Builder {
        private var conversationId: String = ""
        
        public func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        public func build() -> GetConversationRequest {
            return GetConversationRequest(conversationId: conversationId)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder().conversationId(conversationId)
    }
}
