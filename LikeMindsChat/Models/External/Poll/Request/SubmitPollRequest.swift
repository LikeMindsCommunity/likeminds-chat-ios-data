//
//  SubmitPollRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class SubmitPollRequest: Encodable {
    let conversationId: String
    let chatroomId: String
    let polls: [Poll]
    
    private init(conversationId: String, chatroomId: String, polls: [Poll]) {
        self.conversationId = conversationId
        self.chatroomId = chatroomId
        self.polls = polls
    }
    
    class Builder {
        private var conversationId: String = ""
        private var chatroomId: String = ""
        private var polls: [Poll] = []
        
        func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func polls(_ polls: [Poll]) -> Builder {
            self.polls = polls
            return self
        }
        
        func build() -> SubmitPollRequest {
            return SubmitPollRequest(conversationId: conversationId, chatroomId: chatroomId, polls: polls)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder()
            .conversationId(conversationId)
            .chatroomId(chatroomId)
            .polls(polls)
    }
}
