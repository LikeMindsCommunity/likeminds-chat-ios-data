//
//  EditConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class EditConversationRequest {
    private let conversationId: String
    private let text: String
    private let shareLink: String?
    
    private init(conversationId: String, text: String, shareLink: String?) {
        self.conversationId = conversationId
        self.text = text
        self.shareLink = shareLink
    }
    
    class Builder {
        private var conversationId: String = ""
        private var text: String = ""
        private var shareLink: String?
        
        func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        func text(_ text: String) -> Builder {
            self.text = text
            return self
        }
        
        func shareLink(_ shareLink: String?) -> Builder {
            self.shareLink = shareLink
            return self
        }
        
        func build() -> EditConversationRequest {
            return EditConversationRequest(conversationId: conversationId, text: text, shareLink: shareLink)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder()
            .conversationId(conversationId)
            .text(text)
            .shareLink(shareLink)
    }
}
