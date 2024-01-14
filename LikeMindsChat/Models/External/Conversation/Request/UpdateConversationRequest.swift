//
//  UpdateConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class UpdateConversationRequest {
    private var conversation: Conversation?
    
    private init(conversation: Conversation?) {
        self.conversation = conversation
    }
    
    class Builder {
        private var conversation: Conversation?
        
        func conversation(_ conversation: Conversation?) -> Builder {
            self.conversation = conversation
            return self
        }
        
        func build() -> UpdateConversationRequest {
            return UpdateConversationRequest(conversation: conversation)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().conversation(conversation)
    }
}
