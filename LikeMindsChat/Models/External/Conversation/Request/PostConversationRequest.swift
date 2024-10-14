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
    public private(set) var triggerBot: Bool?
    public private(set) var attachments: [Attachment]?

    public private(set) var temporaryId: String?
    public private(set) var repliedChatroomId: String?
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
        case ogTags = "og_tags"
        case text, attachments
        case shareLink = "share_link"
        case triggerBot = "trigger_bot"
        case temporaryId = "temporary_id"
        case repliedChatroomId = "replied_chatroom_id"
        case repliedConversationId = "replied_conversation_id"
        case isFromNotification = "is_from_notification"
    }
    
    private init(chatroomId: String, text: String, isFromNotification: Bool?, shareLink: String?, ogTags: LinkOGTags?, repliedConversationId: String?, temporaryId: String?, repliedChatroomId: String?, triggerBot: Bool?, attachments: Attachment?) {
        self.chatroomId = chatroomId
        self.text = text
        self.isFromNotification = isFromNotification
        self.shareLink = shareLink
        self.ogTags = ogTags
        self.repliedConversationId = repliedConversationId
        self.triggerBot = triggerBot
        self.attachments = attachments
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
        private var temporaryId: String? = nil
        private var repliedChatroomId: String? = nil
        private var triggerBot: Bool? = nil
        private var attachments: Attachment? = nil
        
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
        
        public func temporaryId(_ temporaryId: String?) -> Builder {
            self.temporaryId = temporaryId
            return self
        }
        
        public func repliedChatroomId(_ repliedChatroomId: String?) -> Builder {
            self.repliedChatroomId = repliedChatroomId
            return self
        }
        
        public func attachments(_ attachments: [Attachment]?) -> Builder{
            self.attachments = attachments
            return self
        }
        
        public func triggerBot(_ triggerBot: Bool?) -> Builder{
            self.triggerBot = triggerBot
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
                temporaryId: temporaryId,
                repliedChatroomId: repliedChatroomId,
                attachments: attachments,
                triggerBot: triggerBot
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
            .temporaryId(temporaryId)
            .repliedChatroomId(repliedChatroomId)
            .attachments(attachments)
            .triggerBot(triggerBot)
    }
}
