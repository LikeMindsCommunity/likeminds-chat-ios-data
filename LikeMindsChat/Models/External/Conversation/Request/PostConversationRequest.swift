//
//  PostConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 21/07/23.
//

import Foundation

public class PostConversationRequest: Encodable {
    public private(set) var chatroomId: String
    public private(set) var text: String
    public private(set) var isFromNotification: Bool?
    public private(set) var shareLink: String?
    public private(set) var ogTags: LinkOGTags?
    public private(set) var repliedConversationId: String?
    public private(set) var attachmentCount: Int?
    public private(set) var temporaryId: String?
    public private(set) var repliedChatroomId: String?
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
        case ogTags = "og_tags"
        case text
        case shareLink = "share_link"
        case attachmentCount = "attachment_count"
        case temporaryId = "temporary_id"
        case repliedChatroomId = "replied_chatroom_id"
        case repliedConversationId = "replied_conversation_id"
        case isFromNotification = "is_from_notification"
    }
    
    private init(chatroomId: String, text: String, isFromNotification: Bool?, shareLink: String?, ogTags: LinkOGTags?, repliedConversationId: String?, attachmentCount: Int?, temporaryId: String?, repliedChatroomId: String?) {
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
    
    public class Builder {
        private var chatroomId: String = ""
        private var text: String = ""
        private var isFromNotification: Bool? = nil
        private var shareLink: String? = nil
        private var ogTags: LinkOGTags? = nil
        private var repliedConversationId: String? = nil
        private var attachmentCount: Int? = nil
        private var temporaryId: String? = nil
        private var repliedChatroomId: String? = nil
        
        public init() {}
        
        public func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func text(_ text: String) -> Builder {
            self.text = text
            return self
        }
        
        public func isFromNotification(_ isFromNotification: Bool?) -> Builder {
            self.isFromNotification = isFromNotification
            return self
        }
        
        public func shareLink(_ shareLink: String?) -> Builder {
            self.shareLink = shareLink
            return self
        }
        
        public func ogTags(_ ogTags: LinkOGTags?) -> Builder {
            self.ogTags = ogTags
            return self
        }
        
        public func repliedConversationId(_ repliedConversationId: String?) -> Builder {
            self.repliedConversationId = repliedConversationId
            return self
        }
        
        public func attachmentCount(_ attachmentCount: Int?) -> Builder {
            self.attachmentCount = attachmentCount
            return self
        }
        
        public func temporaryId(_ temporaryId: String?) -> Builder {
            self.temporaryId = temporaryId
            return self
        }
        
        public func repliedChatroomId(_ repliedChatroomId: String?) -> Builder {
            self.repliedChatroomId = repliedChatroomId
            return self
        }
        
        public func build() -> PostConversationRequest {
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
    
    public func toBuilder() -> Builder {
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
