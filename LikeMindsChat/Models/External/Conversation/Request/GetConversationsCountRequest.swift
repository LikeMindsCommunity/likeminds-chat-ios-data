//
//  GetConversationsCountRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class GetConversationsCountRequest {
    private let chatroomId: String
    private let type: GetConversationCountType
    private let conversation: Conversation
    
    private init(chatroomId: String, type: GetConversationCountType, conversation: Conversation) {
        self.chatroomId = chatroomId
        self.type = type
        self.conversation = conversation
    }
    
    enum CodingKeys: String, CodingKey {
        case conversationId = "conversation_id"
        case chatroomId = "chatroom_id"
        case conversation
    }
    
    class Builder {
        private var chatroomId: String = ""
        private var type: GetConversationCountType = .none
        private var conversation: Conversation = Conversation.Builder().build()
        
        func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func type(_ type: GetConversationCountType) -> Builder {
            self.type = type
            return self
        }
        
        func conversation(_ conversation: Conversation) -> Builder {
            self.conversation = conversation
            return self
        }
        
        func build() -> GetConversationsCountRequest {
            return GetConversationsCountRequest(
                chatroomId: chatroomId,
                type: type,
                conversation: conversation
            )
        }
    }
    
    func toBuilder() -> Builder {
        return Builder()
            .chatroomId(chatroomId)
            .type(type)
            .conversation(conversation)
    }
}
