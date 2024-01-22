//
//  PutReactionRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class PutReactionRequest: Encodable {
    private var conversationId: String?
    private var chatroomId: String?
    private var reaction: String = ""
    
    private init(conversationId: String?, chatroomId: String?, reaction: String) {
        self.conversationId = conversationId
        self.chatroomId = chatroomId
        self.reaction = reaction
    }
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
        case conversationId = "conversation_id"
        case reaction
    }
    
    class Builder {
        private var conversationId: String?
        private var chatroomId: String?
        private var reaction: String = ""
        
        func conversationId(_ conversationId: String?) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        func chatroomId(_ chatroomId: String?) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func reaction(_ reaction: String) -> Builder {
            self.reaction = reaction
            return self
        }
        
        func build() -> PutReactionRequest {
            return PutReactionRequest(
                conversationId: conversationId,
                chatroomId: chatroomId,
                reaction: reaction
            )
        }
    }
    
    func toBuilder() -> Builder {
        return Builder()
            .reaction(reaction)
            .chatroomId(chatroomId)
            .conversationId(conversationId)
    }
}
