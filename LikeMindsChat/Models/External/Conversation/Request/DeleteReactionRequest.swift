//
//  DeleteReactionRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class DeleteReactionRequest: Encodable {
    private var conversationId: String?
    private var chatroomId: String?
    
    private init(conversationId: String?, chatroomId: String?) {
        self.conversationId = conversationId
        self.chatroomId = chatroomId
    }
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
        case conversationId = "conversation_id"
    }
    
    class Builder {
        private var conversationId: String?
        private var chatroomId: String?
        
        func conversationId(_ conversationId: String?) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        func chatroomId(_ chatroomId: String?) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func build() -> DeleteReactionRequest {
            return DeleteReactionRequest(conversationId: conversationId, chatroomId: chatroomId)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().conversationId(conversationId).chatroomId(chatroomId)
    }
}
