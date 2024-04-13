//
//  ObserveConversationsRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class ObserveConversationsRequest {
    let chatroomId: String
    let listener: ConversationChangeDelegate
    
    private init(chatroomId: String, listener: ConversationChangeDelegate) {
        self.chatroomId = chatroomId
        self.listener = listener
    }
    
    public class Builder {
        private var chatroomId: String = ""
        private var listener: ConversationChangeDelegate?
        
        public func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func listener(_ listener: ConversationChangeDelegate) -> Builder {
            self.listener = listener
            return self
        }
        
        public func build() -> ObserveConversationsRequest {
            guard let listener = listener else {
                fatalError("Listener must be set")
            }
            return ObserveConversationsRequest(chatroomId: chatroomId, listener: listener)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder().chatroomId(chatroomId)
    }
}
