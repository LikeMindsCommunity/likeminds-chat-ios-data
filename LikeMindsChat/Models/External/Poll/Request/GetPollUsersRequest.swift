//
//  GetPollUsersRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public class GetPollUsersRequest: Encodable {
    private let pollId: String
    private let conversationId: String
    
    private init(pollId: String, conversationId: String) {
        self.pollId = pollId
        self.conversationId = conversationId
    }
    
    enum CodingKeys: String, CodingKey {
        case conversationId = "conversation_id"
        case pollId = "poll_id"
    }
    
    public class Builder {
        private var pollId: String = ""
        private var conversationId: String = ""
        
        public func pollId(_ pollId: String) -> Builder {
            self.pollId = pollId
            return self
        }
        
        public func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        public func build() -> GetPollUsersRequest {
            return GetPollUsersRequest(pollId: pollId, conversationId: conversationId)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder()
            .pollId(pollId)
            .conversationId(conversationId)
    }
}
