//
//  Conversation.swift
//  RealmRestSync
//
//  Created by Pushpendra Singh on 19/12/23.
//  Copyright © 2023 LikeMinds. All rights reserved.
//

import Foundation

/// A class representing a conversation in a chatroom.
///
/// The `Conversation` class encapsulates all the information about a single conversation/message
/// in a chatroom, including its content, attachments, reactions, polls, and metadata.
///
/// ## Overview
/// - Handles text messages, attachments, polls, and reactions
/// - Supports reply threading and conversation states
/// - Manages anonymous conversations and widget integrations
/// - Tracks conversation status and modifications
///
/// ## Usage Example
/// ```swift
/// let conversation = Conversation.builder()
///     .id("123")
///     .chatroomId("456")
///     .answer("Hello World!")
///     .build()
/// ```
public class Conversation: Decodable {
    
    /// Unique identifier for the conversation
    public private(set) var id: String?
    
    /// ID of the chatroom this conversation belongs to
    public private(set) var chatroomId: String?
    
    /// ID of the community this conversation belongs to
    public private(set) var communityId: String?
    
    /// Member who created this conversation
    public private(set) var member: Member?
    
    /// The main text content of the conversation
    public private(set) var answer: String
    
    /// ISO 8601 formatted creation timestamp
    public private(set) var createdAt: String?
    
    /// Current state of the conversation (e.g., normal, deleted, hidden)
    public private(set) var state: ConversationState
    
    /// Array of attachments (images, files, etc.) associated with this conversation
    public private(set) var attachments: [Attachment]?
    
    /// Indicates if this conversation has been seen by the current user
    public private(set) var lastSeen: Bool?
    
    /// Open Graph metadata if the conversation contains a link
    public private(set) var ogTags: LinkOGTags? 
    
    /// Formatted date string for display purposes
    public private(set) var date: String?
    
    /// Indicates if the conversation has been edited
    public private(set) var isEdited: Bool?
    
    /// ID of the member who created this conversation
    public private(set) var memberId: String?
    
    /// ID of the conversation this is replying to, if any
    public private(set) var replyConversationId: String?
    
    /// ID of the user who deleted this conversation, if applicable
    public private(set) var deletedBy: String?
    
    /// Unix timestamp of when the conversation was created
    public private(set) var createdEpoch: Int?
    
    /// Number of attachments in this conversation
    public private(set) var attachmentCount: Int?
    
    /// Indicates if all attachments have been uploaded successfully
    public private(set) var attachmentUploaded: Bool?
    
    /// UUID of the worker handling attachment uploads
    public private(set) var uploadWorkerUUID: String?
    
    /// Temporary ID used before the conversation is synced with the server
    public private(set) var temporaryId: String?
    
    /// Local creation timestamp for offline message handling
    public private(set) var localCreatedEpoch: Int?
    
    /// Array of reactions added to this conversation
    public private(set) var reactions: [Reaction]?
    
    /// Indicates if this is an anonymous conversation
    public private(set) var isAnonymous: Bool?
    
    /// For polls: indicates if users can add new options
    public private(set) var allowAddOption: Bool?
    
    /// For polls: type of poll (single choice, multiple choice, etc.)
    public private(set) var pollType: Int?
    
    /// For polls: display text for the poll type
    public private(set) var pollTypeText: String?
    
    /// For polls: display text for the submit action
    public private(set) var submitTypeText: String?
    
    /// For polls: timestamp when the poll expires
    public private(set) var expiryTime: Int?
    
    /// For polls: number of options that can be selected in multiple choice
    public private(set) var multipleSelectNum: Int?
    
    /// For polls: current state of multiple selection
    public private(set) var multipleSelectState: Int?
    
    /// For polls: array of poll options and their responses
    public private(set) var polls: [Poll]?
    
    /// For polls: indicates if poll results should be visible
    public private(set) var toShowResults: Bool?
    
    /// For polls: text representation of the poll answer
    public private(set) var pollAnswerText: String?
    
    /// ID of the chatroom being replied to (for cross-chatroom replies)
    public private(set) var replyChatroomId: String?
    
    /// ID of the device that created this conversation
    public private(set) var deviceId: String?
    
    /// Indicates if the conversation contains file attachments
    public private(set) var hasFiles: Bool?
    
    /// Indicates if the conversation has any reactions
    public private(set) var hasReactions: Bool?
    
    /// Unix timestamp of the last update to this conversation
    public private(set) var lastUpdated: Int?
    
    /// Member object of the user who deleted this conversation
    public private(set) var deletedByMember: Member?
    
    /// The conversation being replied to, if any
    public private(set) var replyConversation: Conversation?
    
    /// Current status of the conversation (e.g., sending, sent, failed)
    public private(set) var conversationStatus: ConversationStatus?
    
    /// ID of the associated widget, if any
    public private(set) var widgetId: String
    
    /// Associated widget object, if any
    public private(set) var widget: Widget?
    
    /// Unix timestamp when attachments were uploaded
    public private(set) var attachmentUploadedEpoch: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case chatroomId = "chatroom_id"
        case communityId = "community_id"
        case member, widget
        case answer
        case createdAt = "created_at"
        case state
        case attachments
        case lastSeen = "last_seen"
        case ogTags = "og_tags"
        case date
        case isEdited = "is_edited"
        case memberId = "member_id"
        case replyConversationId = "reply_conversation"
        case deletedBy = "delete_by_user_id"
        case createdEpoch = "created_epoch"
        case attachmentCount = "attachment_count"
        case attachmentUploaded = "attachments_uploaded"
        case uploadWorkerUUID = "upload_worker_uuid"
        case temporaryId = "temporary_id"
        case localCreatedEpoch = "local_created_epoch"
        case reactions
        case isAnonymous = "is_anonymous"
        case allowAddOption = "allow_add_option"
        case pollType = "poll_type"
        case pollTypeText = "poll_type_text"
        case submitTypeText = "submit_type_text"
        case expiryTime = "expiry_time"
        case multipleSelectNum = "multiple_select_no"
        case multipleSelectState = "multiple_select_state"
        case polls
        case toShowResults = "to_show_results"
        case pollAnswerText = "poll_answer_text"
        case replyChatroomId = "reply_chatroom_id"
        case deviceId = "device_id"
        case hasFiles = "has_files"
        case hasReactions = "has_reactions"
        case lastUpdated = "last_updated"
        case deletedByMember = "deleted_by_member"
        case replyConversation = "reply_conversation_model"
        case conversationStatus = "conversation_status"
        case widgetId = "widget_id"
        case attachmentUploadedEpoch = "attachment_uploaded_epoch"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIntToStringIfPresent(forKey: .id)
        chatroomId = try container.decodeIntToStringIfPresent(forKey: .chatroomId)
        communityId = try container.decodeIntToStringIfPresent(forKey: .communityId)
        member = try container.decodeIfPresent(Member.self, forKey: .member)
        answer = try container.decode(String.self, forKey: .answer)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        state = try container.decode(ConversationState.self, forKey: .state)
        attachments = try container.decodeIfPresent([Attachment].self, forKey: .attachments)
        lastSeen = try container.decodeIfPresent(Bool.self, forKey: .lastSeen)
        ogTags = try container.decodeIfPresent(LinkOGTags.self, forKey: .ogTags)
        date = try container.decodeIfPresent(String.self, forKey: .date)
        isEdited = try container.decodeIfPresent(Bool.self, forKey: .isEdited)
        memberId = try container.decodeIntToStringIfPresent(forKey: .memberId)
        replyConversationId = try container.decodeIntToStringIfPresent(forKey: .replyConversationId)
        deletedBy = try container.decodeIfPresent(String.self, forKey: .deletedBy)
        createdEpoch = try container.decodeIfPresent(Int.self, forKey: .createdEpoch)
        attachmentCount = try container.decodeIfPresent(Int.self, forKey: .attachmentCount)
        attachmentUploaded = try container.decodeIfPresent(Bool.self, forKey: .attachmentUploaded)
        uploadWorkerUUID = try container.decodeIfPresent(String.self, forKey: .uploadWorkerUUID)
        temporaryId = try container.decodeIfPresent(String.self, forKey: .temporaryId)
        localCreatedEpoch = try container.decodeIfPresent(Int.self, forKey: .localCreatedEpoch)
        reactions = try container.decodeIfPresent([Reaction].self, forKey: .reactions)
        isAnonymous = try container.decodeIfPresent(Bool.self, forKey: .isAnonymous)
        allowAddOption = try container.decodeIfPresent(Bool.self, forKey: .allowAddOption)
        pollType = try container.decodeIfPresent(Int.self, forKey: .pollType)
        pollTypeText = try container.decodeIfPresent(String.self, forKey: .pollTypeText)
        submitTypeText = try container.decodeIfPresent(String.self, forKey: .submitTypeText)
        expiryTime = try container.decodeIfPresent(Int.self, forKey: .expiryTime)
        multipleSelectNum = try container.decodeIfPresent(Int.self, forKey: .multipleSelectNum)
        multipleSelectState = try container.decodeIfPresent(Int.self, forKey: .multipleSelectState)
        polls = try container.decodeIfPresent([Poll].self, forKey: .polls)
        toShowResults = try container.decodeIfPresent(Bool.self, forKey: .toShowResults)
        pollAnswerText = try container.decodeIfPresent(String.self, forKey: .pollAnswerText)
        replyChatroomId = try container.decodeIntToStringIfPresent(forKey: .replyChatroomId)
        deviceId = try container.decodeIfPresent(String.self, forKey: .deviceId)
        hasFiles = try container.decodeIfPresent(Bool.self, forKey: .hasFiles)
        hasReactions = try container.decodeIfPresent(Bool.self, forKey: .hasReactions)
        lastUpdated = try container.decodeIfPresent(Int.self, forKey: .lastUpdated)
        deletedByMember = try container.decodeIfPresent(Member.self, forKey: .deletedByMember)
        replyConversation = try container.decodeIfPresent(Conversation.self, forKey: .replyConversation)
        widgetId = try container.decodeIfPresent(String.self, forKey: .widgetId) ?? ""
        widget = try container.decodeIfPresent(Widget.self, forKey: .widget)
        attachmentUploadedEpoch = try container.decodeIfPresent(Int.self, forKey: .attachmentUploadedEpoch)
    }
    
    private init(
        id: String?,
        chatroomId: String?,
        communityId: String?,
        member: Member?,
        answer: String,
        createdAt: String?,
        state: Int,
        attachments: [Attachment]?,
        lastSeen: Bool?,
        ogTags: LinkOGTags?,
        date: String?,
        isEdited: Bool?,
        memberId: String?,
        replyConversationId: String?,
        replyConversation: Conversation?,
        deletedBy: String?,
        createdEpoch: Int?,
        attachmentCount: Int?,
        attachmentUploaded: Bool?,
        uploadWorkerUUID: String?,
        temporaryId: String?,
        localCreatedEpoch: Int?,
        reactions: [Reaction]?,
        isAnonymous: Bool?,
        allowAddOption: Bool?,
        pollType: Int?,
        pollTypeText: String?,
        submitTypeText: String?,
        expiryTime: Int?,
        multipleSelectNum: Int?,
        multipleSelectState: Int?,
        polls: [Poll]?,
        toShowResults: Bool?,
        pollAnswerText: String?,
        replyChatroomId: String?,
        deviceId: String?,
        hasFiles: Bool?,
        hasReactions: Bool?,
        lastUpdated: Int?,
        deletedByMember: Member?,
        conversationStatus: ConversationStatus?,
        widgetId: String?,
        widget: Widget?,
        attachmentUploadedEpoch: Int?
    ) {
        self.id = id
        self.chatroomId = chatroomId
        self.communityId = communityId
        self.member = member
        self.answer = answer
        self.createdAt = createdAt
        self.state = ConversationState(rawValue: state) ?? .normal
        self.attachments = attachments
        self.lastSeen = lastSeen
        self.ogTags = ogTags
        self.date = date
        self.isEdited = isEdited
        self.memberId = memberId
        self.replyConversationId = replyConversationId
        self.replyConversation = replyConversation
        self.deletedBy = deletedBy
        self.createdEpoch = createdEpoch
        self.attachmentCount = attachmentCount
        self.attachmentUploaded = attachmentUploaded
        self.uploadWorkerUUID = uploadWorkerUUID
        self.temporaryId = temporaryId
        self.localCreatedEpoch = localCreatedEpoch
        self.reactions = reactions
        self.isAnonymous = isAnonymous
        self.allowAddOption = allowAddOption
        self.pollType = pollType
        self.pollTypeText = pollTypeText
        self.submitTypeText = submitTypeText
        self.expiryTime = expiryTime
        self.multipleSelectNum = multipleSelectNum
        self.multipleSelectState = multipleSelectState
        self.polls = polls
        self.toShowResults = toShowResults
        self.pollAnswerText = pollAnswerText
        self.replyChatroomId = replyChatroomId
        self.deviceId = deviceId
        self.hasFiles = hasFiles
        self.hasReactions = hasReactions
        self.lastUpdated = lastUpdated
        self.deletedByMember = deletedByMember
        self.conversationStatus = conversationStatus
        self.widgetId = widgetId ?? ""
        self.widget = widget
        self.attachmentUploadedEpoch = attachmentUploadedEpoch
    }
    
    /// Creates a new builder instance for constructing a Conversation object.
    ///
    /// - Returns: A new `Builder` instance
    public static func builder() -> Builder {
        Builder()
    }
    
    /// Builder class for creating Conversation instances.
    ///
    /// The Builder pattern provides a fluent interface for constructing Conversation objects
    /// with optional parameters. Each setter method returns the builder instance for method chaining.
    ///
    /// ## Example Usage
    /// ```swift
    /// let conversation = Conversation.builder()
    ///     .id("123")
    ///     .chatroomId("456")
    ///     .answer("Hello World!")
    ///     .build()
    /// ```
    public class Builder {
        private var id: String? = ""
        private var chatroomId: String? = nil
        private var communityId: String? = nil
        private var member: Member? = nil
        private var answer: String = ""
        private var createdAt: String? = nil
        private var state: ConversationState = .unknown
        private var attachments: [Attachment]? = nil
        private var lastSeen: Bool? = nil
        private var ogTags: LinkOGTags? = nil
        private var date: String? = nil
        private var isEdited: Bool? = nil
        private var memberId: String? = nil
        private var replyConversation: Conversation? = nil
        private var replyConversationId: String? = nil
        private var deletedBy: String? = nil
        private var createdEpoch: Int? = nil
        private var attachmentCount: Int? = nil
        private var attachmentUploaded: Bool? = nil
        private var uploadWorkerUUID: String? = nil
        private var temporaryId: String? = nil
        private var localCreatedEpoch: Int? = nil
        private var reactions: [Reaction]? = nil
        private var isAnonymous: Bool? = nil
        private var allowAddOption: Bool? = nil
        private var pollType: Int? = nil
        private var pollTypeText: String? = nil
        private var submitTypeText: String? = nil
        private var expiryTime: Int? = nil
        private var multipleSelectNum: Int? = nil
        private var multipleSelectState: Int? = nil
        private var polls: [Poll]? = nil
        private var toShowResults: Bool? = nil
        private var pollAnswerText: String? = nil
        private var replyChatroomId: String? = nil
        private var deviceId: String? = nil
        private var hasFiles: Bool? = false
        private var hasReactions: Bool? = false
        private var lastUpdated: Int? = nil
        private var deletedByMember: Member? = nil
        private var conversationStatus: ConversationStatus?
        private var widgetId: String = ""
        private var widget: Widget?
        private var attachmentUploadedEpoch: Int?
        
        public init() {}
        
        public func id(_ id: String?) -> Builder {
            self.id = id
            return self
        }
        
        public func chatroomId(_ chatroomId: String?) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func communityId(_ communityId: String?) -> Builder {
            self.communityId = communityId
            return self
        }
        
        public func member(_ member: Member?) -> Builder {
            self.member = member
            return self
        }
        
        public func answer(_ answer: String) -> Builder {
            self.answer = answer
            return self
        }
        
        public func createdAt(_ createdAt: String?) -> Builder {
            self.createdAt = createdAt
            return self
        }
        
        public func state(_ state: Int) -> Builder {
            self.state = ConversationState(rawValue: state) ?? .unknown
            return self
        }
        
        public func attachments(_ attachments: [Attachment]?) -> Builder {
            self.attachments = attachments
            return self
        }
        
        public func lastSeen(_ lastSeen: Bool?) -> Builder {
            self.lastSeen = lastSeen
            return self
        }
        
        public func ogTags(_ ogTags: LinkOGTags?) -> Builder {
            self.ogTags = ogTags
            return self
        }
        
        public func date(_ date: String?) -> Builder {
            self.date = date
            return self
        }
        
        public func isEdited(_ isEdited: Bool?) -> Builder {
            self.isEdited = isEdited
            return self
        }
        
        public func memberId(_ memberId: String?) -> Builder {
            self.memberId = memberId
            return self
        }
        
        public func replyConversationId(_ replyConversationId: String?) -> Builder {
            self.replyConversationId = replyConversationId
            return self
        }
        
        public func replyConversation(_ replyConversation: Conversation?) -> Builder {
            self.replyConversation = replyConversation
            return self
        }
        
        public func deletedBy(_ deletedBy: String?) -> Builder {
            self.deletedBy = deletedBy
            return self
        }
        
        public func createdEpoch(_ createdEpoch: Int?) -> Builder {
            self.createdEpoch = createdEpoch
            return self
        }
        
        public func attachmentCount(_ attachmentCount: Int?) -> Builder {
            self.attachmentCount = attachmentCount
            return self
        }
        
        public func attachmentUploaded(_ attachmentUploaded: Bool?) -> Builder {
            self.attachmentUploaded = attachmentUploaded
            return self
        }
        
        public func uploadWorkerUUID(_ uploadWorkerUUID: String?) -> Builder {
            self.uploadWorkerUUID = uploadWorkerUUID
            return self
        }
        
        public func temporaryId(_ temporaryId: String?) -> Builder {
            self.temporaryId = temporaryId
            return self
        }
        
        public func localCreatedEpoch(_ localCreatedEpoch: Int?) -> Builder {
            self.localCreatedEpoch = localCreatedEpoch
            return self
        }
        
        public func reactions(_ reactions: [Reaction]?) -> Builder {
            self.reactions = reactions
            return self
        }
        
        public func isAnonymous(_ isAnonymous: Bool?) -> Builder {
            self.isAnonymous = isAnonymous
            return self
        }
        
        public func allowAddOption(_ allowAddOption: Bool?) -> Builder {
            self.allowAddOption = allowAddOption
            return self
        }
        
        public func pollType(_ pollType: Int?) -> Builder {
            self.pollType = pollType
            return self
        }
        
        public func pollTypeText(_ pollTypeText: String?) -> Builder {
            self.pollTypeText = pollTypeText
            return self
        }
        
        public func submitTypeText(_ submitTypeText: String?) -> Builder {
            self.submitTypeText = submitTypeText
            return self
        }
        
        public func expiryTime(_ expiryTime: Int?) -> Builder {
            self.expiryTime = expiryTime
            return self
        }
        
        public func multipleSelectNum(_ multipleSelectNum: Int?) -> Builder {
            self.multipleSelectNum = multipleSelectNum
            return self
        }
        
        public func multipleSelectState(_ multipleSelectState: Int?) -> Builder {
            self.multipleSelectState = multipleSelectState
            return self
        }
        
        public func polls(_ polls: [Poll]?) -> Builder {
            self.polls = polls
            return self
        }
        
        public func toShowResults(_ toShowResults: Bool?) -> Builder {
            self.toShowResults = toShowResults
            return self
        }
        
        public func pollAnswerText(_ pollAnswerText: String?) -> Builder {
            self.pollAnswerText = pollAnswerText
            return self
        }
        
        public func replyChatroomId(_ replyChatroomId: String?) -> Builder {
            self.replyChatroomId = replyChatroomId
            return self
        }
        
        public func deviceId(_ deviceId: String?) -> Builder {
            self.deviceId = deviceId
            return self
        }
        
        public func hasFiles(_ hasFiles: Bool?) -> Builder {
            self.hasFiles = hasFiles
            return self
        }
        
        public func hasReactions(_ hasReactions: Bool?) -> Builder {
            self.hasReactions = hasReactions
            return self
        }
        
        public func lastUpdated(_ lastUpdated: Int?) -> Builder {
            self.lastUpdated = lastUpdated
            return self
        }
        
        public func deletedByMember(_ deletedByMember: Member?) -> Builder {
            self.deletedByMember = deletedByMember
            return self
        }
        
        public func conversationStatus(_ conversationStatus: ConversationStatus?) -> Builder {
            self.conversationStatus = conversationStatus
            return self
        }
        
        public func widgetId(_ widgetId: String?) -> Builder {
            self.widgetId = widgetId ?? ""
            return self
        }
        
        public func widget(_ widget: Widget?) -> Builder {
            self.widget = widget
            return self
        }
        
        public func attachmentUploadedEpoch(_ attachmentUploadedEpoch: Int?) -> Builder {
            self.attachmentUploadedEpoch = attachmentUploadedEpoch
            return self
        }
        
        public func build() -> Conversation {
            return Conversation(
                id: id,
                chatroomId: chatroomId,
                communityId: communityId,
                member: member,
                answer: answer,
                createdAt: createdAt,
                state: state.rawValue,
                attachments: attachments,
                lastSeen: lastSeen,
                ogTags: ogTags,
                date: date,
                isEdited: isEdited,
                memberId: memberId,
                replyConversationId: replyConversationId,
                replyConversation: replyConversation,
                deletedBy: deletedBy,
                createdEpoch: createdEpoch,
                attachmentCount: attachmentCount,
                attachmentUploaded: attachmentUploaded,
                uploadWorkerUUID: uploadWorkerUUID,
                temporaryId: temporaryId,
                localCreatedEpoch: localCreatedEpoch,
                reactions: reactions,
                isAnonymous: isAnonymous,
                allowAddOption: allowAddOption,
                pollType: pollType,
                pollTypeText: pollTypeText,
                submitTypeText: submitTypeText,
                expiryTime: expiryTime,
                multipleSelectNum: multipleSelectNum,
                multipleSelectState: multipleSelectState,
                polls: polls,
                toShowResults: toShowResults,
                pollAnswerText: pollAnswerText,
                replyChatroomId: replyChatroomId,
                deviceId: deviceId,
                hasFiles: hasFiles,
                hasReactions: hasReactions,
                lastUpdated: lastUpdated,
                deletedByMember: deletedByMember,
                conversationStatus: conversationStatus,
                widgetId: widgetId,
                widget: widget,
                attachmentUploadedEpoch: attachmentUploadedEpoch
            )
        }
    }
    
    /// Creates a new Builder instance initialized with this conversation's current values.
    ///
    /// Use this method to create a modified copy of an existing conversation.
    ///
    /// - Returns: A Builder instance pre-populated with this conversation's values
    public func toBuilder() -> Builder {
        return Builder()
            .id(id)
            .chatroomId(chatroomId)
            .communityId(communityId)
            .member(member)
            .answer(answer)
            .createdAt(createdAt)
            .state(state.rawValue)
            .attachments(attachments)
            .lastSeen(lastSeen)
            .ogTags(ogTags)
            .date(date)
            .isEdited(isEdited)
            .memberId(memberId)
            .replyConversation(replyConversation)
            .replyConversationId(replyConversationId)
            .deletedBy(deletedBy)
            .createdEpoch(createdEpoch)
            .attachmentCount(attachmentCount)
            .attachmentUploaded(attachmentUploaded)
            .uploadWorkerUUID(uploadWorkerUUID)
            .temporaryId(temporaryId)
            .localCreatedEpoch(localCreatedEpoch)
            .reactions(reactions)
            .isAnonymous(isAnonymous)
            .allowAddOption(allowAddOption)
            .pollType(pollType)
            .pollTypeText(pollTypeText)
            .submitTypeText(submitTypeText)
            .expiryTime(expiryTime)
            .multipleSelectNum(multipleSelectNum)
            .multipleSelectState(multipleSelectState)
            .polls(polls)
            .toShowResults(toShowResults)
            .pollAnswerText(pollAnswerText)
            .replyChatroomId(replyChatroomId)
            .deviceId(deviceId)
            .hasFiles(hasFiles)
            .hasReactions(hasReactions)
            .lastUpdated(lastUpdated)
            .deletedByMember(deletedByMember)
            .conversationStatus(conversationStatus)
            .widgetId(widgetId)
            .widget(widget)
            .attachmentUploadedEpoch(attachmentUploadedEpoch)
    }
}

