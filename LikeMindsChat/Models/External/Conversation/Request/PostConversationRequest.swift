//
//  PostConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 21/07/23.
//

import Foundation

public class PostConversationRequest: Codable {
    public private(set) var chatroomId: String
    public private(set) var text: String
    public private(set) var isFromNotification: Bool?
    public private(set) var shareLink: String?
    public private(set) var ogTags: LinkOGTags?
    public private(set) var repliedConversationId: String?
    public private(set) var triggerBot: Bool?
    public private(set) var attachments: [Attachment]?
    public private(set) var metadata: [String: Any]?

    public private(set) var temporaryId: String?
    public private(set) var repliedChatroomId: String?

    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
        case ogTags = "og_tags"
        case text, attachments, metadata
        case shareLink = "share_link"
        case triggerBot = "trigger_bot"
        case temporaryId = "temporary_id"
        case repliedChatroomId = "replied_chatroom_id"
        case repliedConversationId = "replied_conversation_id"
        case isFromNotification = "is_from_notification"
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        do {
            chatroomId = try container.decode(String.self, forKey: .chatroomId)
        } catch {
            print("Error decoding chatroomId: \(error)")
            chatroomId = ""
        }

        do {
            text = try container.decode(String.self, forKey: .text)
        } catch {
            print("Error decoding text: \(error)")
            text = ""
        }

        do {
            isFromNotification = try container.decodeIfPresent(
                Bool.self, forKey: .isFromNotification)
        } catch {
            print("Error decoding isFromNotification: \(error)")
            isFromNotification = nil
        }

        do {
            shareLink = try container.decodeIfPresent(
                String.self, forKey: .shareLink)
        } catch {
            print("Error decoding shareLink: \(error)")
            shareLink = nil
        }

        do {
            ogTags = try container.decodeIfPresent(
                LinkOGTags.self, forKey: .ogTags)
        } catch {
            print("Error decoding ogTags: \(error)")
            ogTags = nil
        }

        do {
            repliedConversationId = try container.decodeIfPresent(
                String.self, forKey: .repliedConversationId)
        } catch {
            print("Error decoding repliedConversationId: \(error)")
            repliedConversationId = nil
        }

        do {
            triggerBot = try container.decodeIfPresent(
                Bool.self, forKey: .triggerBot)
        } catch {
            print("Error decoding triggerBot: \(error)")
            triggerBot = nil
        }

        do {
            attachments = try container.decodeIfPresent(
                [Attachment].self, forKey: .attachments)
        } catch {
            print("Error decoding attachments: \(error)")
            attachments = nil
        }

        do {
            temporaryId = try container.decodeIfPresent(
                String.self, forKey: .temporaryId)
        } catch {
            print("Error decoding temporaryId: \(error)")
            temporaryId = nil
        }

        do {
            repliedChatroomId = try container.decodeIfPresent(
                String.self, forKey: .repliedChatroomId)
        } catch {
            print("Error decoding repliedChatroomId: \(error)")
            repliedChatroomId = nil
        }

        do {
            let decodedMetadata = try container.decodeIfPresent(
                [String: AnyDecodable].self, forKey: .metadata)
            metadata = decodedMetadata?.mapValues { $0.value }
        } catch {
            print("Error decoding metadata: \(error)")
            metadata = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        do {
            try container.encode(chatroomId, forKey: .chatroomId)
        } catch {
            print("Error encoding chatroomId: \(error)")
        }

        do {
            try container.encode(text, forKey: .text)
        } catch {
            print("Error encoding text: \(error)")
        }

        do {
            try container.encodeIfPresent(
                isFromNotification, forKey: .isFromNotification)
        } catch {
            print("Error encoding isFromNotification: \(error)")
        }

        do {
            try container.encodeIfPresent(shareLink, forKey: .shareLink)
        } catch {
            print("Error encoding shareLink: \(error)")
        }

        do {
            try container.encodeIfPresent(ogTags, forKey: .ogTags)
        } catch {
            print("Error encoding ogTags: \(error)")
        }

        do {
            try container.encodeIfPresent(
                repliedConversationId, forKey: .repliedConversationId)
        } catch {
            print("Error encoding repliedConversationId: \(error)")
        }

        do {
            try container.encodeIfPresent(triggerBot, forKey: .triggerBot)
        } catch {
            print("Error encoding triggerBot: \(error)")
        }

        do {
            try container.encodeIfPresent(attachments, forKey: .attachments)
        } catch {
            print("Error encoding attachments: \(error)")
        }

        do {
            try container.encodeIfPresent(temporaryId, forKey: .temporaryId)
        } catch {
            print("Error encoding temporaryId: \(error)")
        }

        do {
            try container.encodeIfPresent(
                repliedChatroomId, forKey: .repliedChatroomId)
        } catch {
            print("Error encoding repliedChatroomId: \(error)")
        }

        do {
            if let metadata = metadata {
                let encodedMetadata = metadata.mapValues { AnyEncodable($0) }
                try container.encode(encodedMetadata, forKey: .metadata)
            }
        } catch {
            print("Error encoding metadata: \(error)")
        }
    }

    private init(
        chatroomId: String, text: String, isFromNotification: Bool?,
        shareLink: String?, ogTags: LinkOGTags?, repliedConversationId: String?,
        temporaryId: String?, repliedChatroomId: String?, triggerBot: Bool?,
        attachments: [Attachment]?, metadata: [String: Any]?
    ) {
        self.chatroomId = chatroomId
        self.text = text
        self.isFromNotification = isFromNotification
        self.shareLink = shareLink
        self.ogTags = ogTags
        self.repliedConversationId = repliedConversationId
        self.triggerBot = triggerBot
        self.attachments = attachments ?? []
        self.temporaryId = temporaryId
        self.repliedChatroomId = repliedChatroomId
        self.metadata = metadata
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
        private var attachments: [Attachment]? = nil
        private var metadata: [String: Any]?

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

        public func repliedConversationId(_ repliedConversationId: String?)
            -> Builder
        {
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

        public func attachments(_ attachments: [Attachment]?) -> Builder {
            self.attachments = attachments
            return self
        }

        public func triggerBot(_ triggerBot: Bool?) -> Builder {
            self.triggerBot = triggerBot
            return self
        }

        public func metadata(_ metadata: [String: Any]?) -> Builder {
            self.metadata = metadata
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
                triggerBot: triggerBot,
                attachments: attachments,
                metadata: metadata
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
            .metadata(metadata)
    }
}
