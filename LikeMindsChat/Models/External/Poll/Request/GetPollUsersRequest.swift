//
//  GetPollUsersRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class GetPollUsersRequest {
    private let pollId: String
    private let conversationId: String
    
    private init(pollId: String, conversationId: String) {
        self.pollId = pollId
        self.conversationId = conversationId
    }
    
    class Builder {
        private var pollId: String = ""
        private var conversationId: String = ""
        
        func pollId(_ pollId: String) -> Builder {
            self.pollId = pollId
            return self
        }
        
        func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        func build() -> GetPollUsersRequest {
            return GetPollUsersRequest(pollId: pollId, conversationId: conversationId)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder()
            .pollId(pollId)
            .conversationId(conversationId)
    }
}
