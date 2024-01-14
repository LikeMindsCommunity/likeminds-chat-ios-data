//
//  DeleteConversationsRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class DeleteConversationsRequest {
    private let conversationIds: [String]
    
    private init(conversationIds: [String]) {
        self.conversationIds = conversationIds
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
