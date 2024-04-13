//
//  SaveConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public class SaveConversationRequest {
    private let conversation: Conversation?
    
    private init(conversation: Conversation?) {
        self.conversation = conversation
    }
    
    public class Builder {
        private var conversation: Conversation?
                
        @discardableResult
        public func conversation(_ conversation: Conversation?) -> Builder {
            self.conversation = conversation
            return self
        }
        
        public func build() -> SaveConversationRequest {
            return SaveConversationRequest(conversation: conversation)
        }
    }
    
    public static func builder() -> Builder {
        return Builder()
    }
    
    public func toBuilder() -> Builder {
        return Builder().conversation(conversation)
    }
}
