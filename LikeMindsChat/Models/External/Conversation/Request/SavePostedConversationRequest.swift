//
//  SavePostedConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class SavePostedConversationRequest {
    private let conversation: Conversation
    private let isFromNotification: Bool
    
    private init(conversation: Conversation, isFromNotification: Bool) {
        self.conversation = conversation
        self.isFromNotification = isFromNotification
    }
    
    class Builder {
        private var conversation: Conversation = Conversation.Builder().build()
        private var isFromNotification: Bool = false
        
        func conversation(_ conversation: Conversation) -> Builder {
            self.conversation = conversation
            return self
        }
        
        func isFromNotification(_ isFromNotification: Bool) -> Builder {
            self.isFromNotification = isFromNotification
            return self
        }
        
        func build() -> SavePostedConversationRequest {
            return SavePostedConversationRequest(conversation: conversation, isFromNotification: isFromNotification)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().conversation(conversation).isFromNotification(isFromNotification)
    }
}
