//
//  ObserveConversationsRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class ObserveConversationsRequest {
    private let chatroomId: String
    private let listener: ConversationChangeListener
    
    private init(chatroomId: String, listener: ConversationChangeListener) {
        self.chatroomId = chatroomId
        self.listener = listener
    }
    
    class Builder {
        private var chatroomId: String = ""
        private var listener: ConversationChangeListener?
        
        func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func listener(_ listener: ConversationChangeListener) -> Builder {
            self.listener = listener
            return self
        }
        
        func build() -> ObserveConversationsRequest {
            guard let listener = listener else {
                fatalError("Listener must be set")
            }
            return ObserveConversationsRequest(chatroomId: chatroomId, listener: listener)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().chatroomId(chatroomId)
    }
}
