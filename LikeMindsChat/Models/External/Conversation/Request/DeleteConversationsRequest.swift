//
//  DeleteConversationsRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public class DeleteConversationsRequest: Encodable {
    private let conversationIds: [String]
    
    private init(conversationIds: [String]) {
        self.conversationIds = conversationIds
    }
    
    enum CodingKeys: String, CodingKey {
        case conversationIds = "conversation_ids"
    }
    
    public static func builder() -> Builder {
        return Builder()
    }
    
    public class Builder {
        private var conversationIds: [String] = []
        
        public func conversationIds(_ conversationIds: [String]) -> Builder {
            self.conversationIds = conversationIds
            return self
        }
        
        public func build() -> DeleteConversationsRequest {
            return DeleteConversationsRequest(conversationIds: conversationIds)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder().conversationIds(conversationIds)
    }
}
