//
//  EditConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public class EditConversationRequest: Encodable {
    private let conversationId: String
    private let text: String
    private let shareLink: String?
    
    private init(conversationId: String, text: String, shareLink: String?) {
        self.conversationId = conversationId
        self.text = text
        self.shareLink = shareLink
    }
    
    public static func builder() -> Builder {
        return Builder()
    }
    
    enum CodingKeys: String, CodingKey {
        case conversationId = "conversation_id"
        case text
        case shareLink = "share_link"
    }
    
    public class Builder {
        private var conversationId: String = ""
        private var text: String = ""
        private var shareLink: String?
        
        public func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        public func text(_ text: String) -> Builder {
            self.text = text
            return self
        }
        
        public func shareLink(_ shareLink: String?) -> Builder {
            self.shareLink = shareLink
            return self
        }
        
        public func build() -> EditConversationRequest {
            return EditConversationRequest(conversationId: conversationId, text: text, shareLink: shareLink)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder()
            .conversationId(conversationId)
            .text(text)
            .shareLink(shareLink)
    }
}
