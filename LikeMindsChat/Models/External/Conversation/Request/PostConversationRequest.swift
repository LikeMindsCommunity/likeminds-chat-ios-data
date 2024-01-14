//
//  PostConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 21/07/23.
//

import Foundation

class PostConversationRequest {
    private let chatroomId: String
    private let text: String
    private let isFromNotification: Bool
    private let shareLink: String?
    private let ogTags: LinkOGTags?
    private let repliedConversationId: String?
    private let attachmentCount: Int?
    private let temporaryId: String?
    private let repliedChatroomId: String?
    
    private init(chatroomId: String, text: String, isFromNotification: Bool, shareLink: String?, ogTags: LinkOGTags?, repliedConversationId: String?, attachmentCount: Int?, temporaryId: String?, repliedChatroomId: String?) {
        self.chatroomId = chatroomId
        self.text = text
        self.isFromNotification = isFromNotification
        self.shareLink = shareLink
        self.ogTags = ogTags
        self.repliedConversationId = repliedConversationId
        self.attachmentCount = attachmentCount
        self.temporaryId = temporaryId
        self.repliedChatroomId = repliedChatroomId
    }
    
    class Builder {
        private var chatroomId: String = ""
        private var text: String = ""
        private var isFromNotification: Bool = false
        private var shareLink: String? = nil
        private var ogTags: LinkOGTags? = nil
        private var repliedConversationId: String? = nil
        private var attachmentCount: Int? = nil
        private var temporaryId: String? = nil
        private var repliedChatroomId: String? = nil
        
        func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func text(_ text: String) -> Builder {
            self.text = text
            return self
        }
        
        func isFromNotification(_ isFromNotification: Bool) -> Builder {
            self.isFromNotification = isFromNotification
            return self
        }
        
        func shareLink(_ shareLink: String?) -> Builder {
            self.shareLink = shareLink
            return self
        }
        
        func ogTags(_ ogTags: LinkOGTags?) -> Builder {
            self.ogTags = ogTags
            return self
        }
        
        func repliedConversationId(_ repliedConversationId: String?) -> Builder {
            self.repliedConversationId = repliedConversationId
            return self
        }
        
        func attachmentCount(_ attachmentCount: Int?) -> Builder {
            self.attachmentCount = attachmentCount
            return self
        }
        
        func temporaryId(_ temporaryId: String?) -> Builder {
            self.temporaryId = temporaryId
            return self
        }
        
        func repliedChatroomId(_ repliedChatroomId: String?) -> Builder {
            self.repliedChatroomId = repliedChatroomId
            return self
        }
        
        func build() -> PostConversationRequest {
            return PostConversationRequest(
                chatroomId: chatroomId,
                text: text,
                isFromNotification: isFromNotification,
                shareLink: shareLink,
                ogTags: ogTags,
                repliedConversationId: repliedConversationId,
                attachmentCount: attachmentCount,
                temporaryId: temporaryId,
                repliedChatroomId: repliedChatroomId
            )
        }
    }
    
    func toBuilder() -> Builder {
        return Builder()
            .chatroomId(chatroomId)
            .text(text)
            .isFromNotification(isFromNotification)
            .shareLink(shareLink)
            .ogTags(ogTags)
            .repliedConversationId(repliedConversationId)
            .attachmentCount(attachmentCount)
            .temporaryId(temporaryId)
            .repliedChatroomId(repliedChatroomId)
    }
}
