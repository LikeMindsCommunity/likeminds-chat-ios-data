//
//  Conversation.swift
//  RealmRestSync
//
//  Created by Pushpendra Singh on 19/12/23.
//  Copyright © 2023 LikeMinds. All rights reserved.
//

import Foundation

public class Conversation: Decodable {
    
    public private(set) var id: String?
    public private(set) var chatroomId: String?
    public private(set) var communityId: String?
    public private(set) var member: Member?
    public private(set) var answer: String
    public private(set) var createdAt: String?
    public private(set) var state: ConversationState
    public private(set) var attachments: [Attachment]?
    public private(set) var lastSeen: Bool?
    public private(set) var ogTags: LinkOGTags?
    public private(set) var date: String?
    public private(set) var isEdited: Bool?
    public private(set) var memberId: String?
    public private(set) var replyConversationId: String?
    public private(set) var deletedBy: String?
    public private(set) var createdEpoch: Int?
    public private(set) var attachmentCount: Int?
    public private(set) var attachmentUploaded: Bool?
    public private(set) var uploadWorkerUUID: String?
    public private(set) var temporaryId: String?
    public private(set) var localCreatedEpoch: Int?
    public private(set) var reactions: [Reaction]?
    public private(set) var isAnonymous: Bool?
    public private(set) var allowAddOption: Bool?
    public private(set) var pollType: Int?
    public private(set) var pollTypeText: String?
    public private(set) var submitTypeText: String?
    public private(set) var expiryTime: Int?
    public private(set) var multipleSelectNum: Int?
    public private(set) var multipleSelectState: Int?
    public private(set) var polls: [Poll]?
    public private(set) var toShowResults: Bool?
    public private(set) var pollAnswerText: String?
    public private(set) var replyChatroomId: String?
    public private(set) var deviceId: String?
    public private(set) var hasFiles: Bool?
    public private(set) var hasReactions: Bool?
    public private(set) var lastUpdated: Int?
    public private(set) var deletedByMember: Member?
    public private(set) var replyConversation: Conversation?
    public private(set) var conversationStatus: ConversationStatus?
    
    enum CodingKeys: String, CodingKey {
        case id
        case chatroomId = "chatroom_id"
        case communityId = "community_id"
        case member
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
        conversationStatus: ConversationStatus?
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
    }
    
    public static func builder() -> Builder {
        Builder()
    }
    
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
                conversationStatus: conversationStatus
            )
        }
    }
    
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
    }
}

