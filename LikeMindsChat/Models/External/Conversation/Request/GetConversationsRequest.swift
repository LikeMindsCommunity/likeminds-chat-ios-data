//
//  GetConversationsRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public class GetConversationsRequest {
    public let chatroomId: String
    public let type: GetConversationType
    public let conversation: Conversation?
    public let limit: Int
    public let observer: ConversationClientObserver?
    
    private init(chatroomId: String, type: GetConversationType, conversation: Conversation?, limit: Int, observer: ConversationClientObserver?) {
        self.chatroomId = chatroomId
        self.type = type
        self.conversation = conversation
        self.limit = limit
        self.observer = observer
    }
    
    public static func builder() -> Builder {
        return Builder()
    }
    
    public class Builder {
        private var chatroomId: String = ""
        private var type: GetConversationType = .none
        private var conversation: Conversation? = nil
        private var limit: Int = 50
        private var observer: ConversationClientObserver?
        
        public init() { }
        
        public func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func type(_ type: GetConversationType) -> Builder {
            self.type = type
            return self
        }
        
        public func conversation(_ conversation: Conversation?) -> Builder {
            self.conversation = conversation
            return self
        }
        
        public func limit(_ limit: Int) -> Builder {
            self.limit = limit
            return self
        }
        
        public func observer(_ observer: ConversationClientObserver?) -> Builder {
            self.observer = observer
            return self
        }
        
        public func build() -> GetConversationsRequest {
            return GetConversationsRequest(chatroomId: chatroomId, type: type, conversation: conversation, limit: limit, observer: observer)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder().chatroomId(chatroomId)
            .type(type)
            .conversation(conversation)
            .limit(limit)
            .observer(observer)
    }
}
