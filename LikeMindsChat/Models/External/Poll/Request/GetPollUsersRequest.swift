//
//  GetPollUsersRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public class GetPollUsersRequest: Encodable {
    
    let pollOptionId: String
    let conversationId: String
    
    private init(pollOptionId: String, conversationId: String) {
        self.pollOptionId = pollOptionId
        self.conversationId = conversationId
    }
    
    enum CodingKeys: String, CodingKey {
        case conversationId = "conversation_id"
        case pollOptionId = "option_id"
    }
    
    public static func builder() -> Builder {
        return Builder()
    }
    
    public class Builder {
        private var pollOptionId: String = ""
        private var conversationId: String = ""
        
        public func pollOptionId(_ pollOptionId: String) -> Builder {
            self.pollOptionId = pollOptionId
            return self
        }
        
        public func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        public func build() -> GetPollUsersRequest {
            return GetPollUsersRequest(pollOptionId: pollOptionId, conversationId: conversationId)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder()
            .pollOptionId(pollOptionId)
            .conversationId(conversationId)
    }
}
