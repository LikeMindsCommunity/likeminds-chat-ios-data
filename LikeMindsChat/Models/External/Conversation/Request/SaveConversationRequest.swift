//
//  SaveConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class SaveConversationRequest {
    private let conversation: Conversation?
    
    private init(conversation: Conversation?) {
        self.conversation = conversation
    }
    
    class Builder {
        private var conversation: Conversation?

        @discardableResult
        func conversation(_ conversation: Conversation?) -> Builder {
            self.conversation = conversation
            return self
        }
        
        func build() -> SaveConversationRequest {
            return SaveConversationRequest(conversation: conversation)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().conversation(conversation)
    }
}
