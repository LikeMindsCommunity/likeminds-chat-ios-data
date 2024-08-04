//
//  SubmitPollRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public class SubmitPollRequest: Encodable {
    
    let conversationId: String
    let chatroomId: String
    let polls: [Poll]
    
    private init(conversationId: String, chatroomId: String, polls: [Poll]) {
        self.conversationId = conversationId
        self.chatroomId = chatroomId
        self.polls = polls
    }
    
    public static func builder() -> Builder {
        return Builder()
    }
    
    public class Builder {
        private var conversationId: String = ""
        private var chatroomId: String = ""
        private var polls: [Poll] = []
        
        public func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        public func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func polls(_ polls: [Poll]) -> Builder {
            self.polls = polls
            return self
        }
        
        public func build() -> SubmitPollRequest {
            return SubmitPollRequest(conversationId: conversationId, chatroomId: chatroomId, polls: polls)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder()
            .conversationId(conversationId)
            .chatroomId(chatroomId)
            .polls(polls)
    }
}
