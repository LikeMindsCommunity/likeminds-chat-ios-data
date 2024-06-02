//
//  UpdateConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public class UpdateConversationRequest {
    private var conversation: Conversation?
    
    private init(conversation: Conversation?) {
        self.conversation = conversation
    }
    
    public static func builder() -> Builder {
        Builder()
    }
    
    public class Builder {
        private var conversation: Conversation?
        
        public func conversation(_ conversation: Conversation?) -> Builder {
            self.conversation = conversation
            return self
        }
        
        public func build() -> UpdateConversationRequest {
            return UpdateConversationRequest(conversation: conversation)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder().conversation(conversation)
    }
}
