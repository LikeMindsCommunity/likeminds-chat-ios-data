//
//  AddPollOptionRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class AddPollOptionRequest {
    private let conversationId: String
    private let poll: Poll
    
    private init(conversationId: String, poll: Poll) {
        self.conversationId = conversationId
        self.poll = poll
    }
    
    class Builder {
        private var conversationId: String = ""
        private var poll: Poll = Poll.Builder().build()
        
        func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        func poll(_ poll: Poll) -> Builder {
            self.poll = poll
            return self
        }
        
        func build() -> AddPollOptionRequest {
            return AddPollOptionRequest(conversationId: conversationId, poll: poll)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().conversationId(conversationId).poll(poll)
    }
}
