//
//  DeleteConversationsRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class DeleteConversationsRequest: Encodable {
    private let conversationIds: [String]
    
    private init(conversationIds: [String]) {
        self.conversationIds = conversationIds
    }
    
    enum CodingKeys: String, CodingKey {
        case conversationIds = "conversation_ids"
    }
    
    class Builder {
        private var conversationIds: [String] = []
        
        func conversationIds(_ conversationIds: [String]) -> Builder {
            self.conversationIds = conversationIds
            return self
        }
        
        func build() -> DeleteConversationsRequest {
            return DeleteConversationsRequest(conversationIds: conversationIds)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().conversationIds(conversationIds)
    }
}
