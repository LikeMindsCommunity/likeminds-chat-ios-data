//
//  AddPollOptionRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public class AddPollOptionRequest: Encodable {
    private let conversationId: String
    private let poll: Poll
    
    private init(conversationId: String, poll: Poll) {
        self.conversationId = conversationId
        self.poll = poll
    }
    
    enum CodingKeys: String, CodingKey {
        case conversationId = "conversation_id"
        case poll
    }
    
    public static func builder() -> Builder {
        return Builder()
    }
    
    public class Builder {
        private var conversationId: String = ""
        private var poll: Poll = Poll.Builder().build()
        
        public func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        public func poll(_ poll: Poll) -> Builder {
            self.poll = poll
            return self
        }
        
        public func build() -> AddPollOptionRequest {
            return AddPollOptionRequest(conversationId: conversationId, poll: poll)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder().conversationId(conversationId).poll(poll)
    }
}
