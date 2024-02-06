//
//  Conversation.swift
//  RealmRestSync
//
//  Created by Pushpendra Singh on 19/12/23.
//  Copyright © 2023 LikeMinds. All rights reserved.
//

import Foundation

class Conversation: Decodable {
    
    let id: String?
    let chatroomId: String?
    let communityId: String?
    let member: Member?
    let answer: String
    let createdAt: String?
    let state: Int
    let attachments: [Attachment]?
    let lastSeen: Bool?
    let ogTags: LinkOGTags?
    let date: String?
    let isEdited: Bool?
    let memberId: String?
    let replyConversationId: String?
    let deletedBy: String?
    let createdEpoch: Int?
    let attachmentCount: Int?
    let attachmentUploaded: Bool?
    let uploadWorkerUUID: String?
    let temporaryId: String?
    let localCreatedEpoch: Int?
    let reactions: [Reaction]?
    let isAnonymous: Bool?
    let allowAddOption: Bool?
    let pollType: Int?
    let pollTypeText: String?
    let submitTypeText: String?
    let expiryTime: Int?
    let multipleSelectNum: Int?
    let multipleSelectState: Int?
    let polls: [Poll]?
    let toShowResults: Bool?
    let pollAnswerText: String?
    let replyChatroomId: String?
    let deviceId: String?
    let hasFiles: Bool?
    let hasReactions: Bool?
    let lastUpdated: Int?
    let deletedByMember: Member?
    let replyConversation: Conversation?
    
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
        case deletedBy = "delete_by"
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
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        chatroomId = try container.decodeIfPresent(String.self, forKey: .chatroomId)
        communityId = try container.decodeIfPresent(String.self, forKey: .communityId)
        member = try container.decodeIfPresent(Member.self, forKey: .member)
        answer = try container.decode(String.self, forKey: .answer)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        state = try container.decode(Int.self, forKey: .state)
        attachments = try container.decodeIfPresent([Attachment].self, forKey: .attachments)
        lastSeen = try container.decodeIfPresent(Bool.self, forKey: .lastSeen)
        ogTags = try container.decodeIfPresent(LinkOGTags.self, forKey: .ogTags)
        date = try container.decodeIfPresent(String.self, forKey: .date)
        isEdited = try container.decodeIfPresent(Bool.self, forKey: .isEdited)
        memberId = try container.decodeIfPresent(String.self, forKey: .memberId)
        replyConversationId = try container.decodeIfPresent(String.self, forKey: .replyConversationId)
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
        replyChatroomId = try container.decodeIfPresent(String.self, forKey: .replyChatroomId)
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
        deletedByMember: Member?
    ) {
        self.id = id
        self.chatroomId = chatroomId
        self.communityId = communityId
        self.member = member
        self.answer = answer
        self.createdAt = createdAt
        self.state = state
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
    }
    
    class Builder {
        private var id: String? = ""
        private var chatroomId: String? = nil
        private var communityId: String? = nil
        private var member: Member? = nil
        private var answer: String = ""
        private var createdAt: String? = nil
        private var state: Int = 0
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
        
        func id(_ id: String?) -> Builder {
            self.id = id
            return self
        }
        
        func chatroomId(_ chatroomId: String?) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func communityId(_ communityId: String?) -> Builder {
            self.communityId = communityId
            return self
        }
        
        func member(_ member: Member?) -> Builder {
            self.member = member
            return self
        }
        
        func answer(_ answer: String) -> Builder {
            self.answer = answer
            return self
        }
        
        func createdAt(_ createdAt: String?) -> Builder {
            self.createdAt = createdAt
            return self
        }
        
        func state(_ state: Int) -> Builder {
            self.state = state
            return self
        }
        
        func attachments(_ attachments: [Attachment]?) -> Builder {
            self.attachments = attachments
            return self
        }
        
        func lastSeen(_ lastSeen: Bool?) -> Builder {
            self.lastSeen = lastSeen
            return self
        }
        
        func ogTags(_ ogTags: LinkOGTags?) -> Builder {
            self.ogTags = ogTags
            return self
        }
        
        func date(_ date: String?) -> Builder {
            self.date = date
            return self
        }
        
        func isEdited(_ isEdited: Bool?) -> Builder {
            self.isEdited = isEdited
            return self
        }
        
        func memberId(_ memberId: String?) -> Builder {
            self.memberId = memberId
            return self
        }
        
        func replyConversationId(_ replyConversationId: String?) -> Builder {
            self.replyConversationId = replyConversationId
            return self
        }
        
        func replyConversation(_ replyConversation: Conversation?) -> Builder {
            self.replyConversation = replyConversation
            return self
        }
        
        func deletedBy(_ deletedBy: String?) -> Builder {
            self.deletedBy = deletedBy
            return self
        }
        
        func createdEpoch(_ createdEpoch: Int?) -> Builder {
            self.createdEpoch = createdEpoch
            return self
        }
        
        func attachmentCount(_ attachmentCount: Int?) -> Builder {
            self.attachmentCount = attachmentCount
            return self
        }
        
        func attachmentUploaded(_ attachmentUploaded: Bool?) -> Builder {
            self.attachmentUploaded = attachmentUploaded
            return self
        }
        
        func uploadWorkerUUID(_ uploadWorkerUUID: String?) -> Builder {
            self.uploadWorkerUUID = uploadWorkerUUID
            return self
        }
        
        func temporaryId(_ temporaryId: String?) -> Builder {
            self.temporaryId = temporaryId
            return self
        }
        
        func localCreatedEpoch(_ localCreatedEpoch: Int?) -> Builder {
            self.localCreatedEpoch = localCreatedEpoch
            return self
        }
        
        func reactions(_ reactions: [Reaction]?) -> Builder {
            self.reactions = reactions
            return self
        }
        
        func isAnonymous(_ isAnonymous: Bool?) -> Builder {
            self.isAnonymous = isAnonymous
            return self
        }
        
        func allowAddOption(_ allowAddOption: Bool?) -> Builder {
            self.allowAddOption = allowAddOption
            return self
        }
        
        func pollType(_ pollType: Int?) -> Builder {
            self.pollType = pollType
            return self
        }
        
        func pollTypeText(_ pollTypeText: String?) -> Builder {
            self.pollTypeText = pollTypeText
            return self
        }
        
        func submitTypeText(_ submitTypeText: String?) -> Builder {
            self.submitTypeText = submitTypeText
            return self
        }
        
        func expiryTime(_ expiryTime: Int?) -> Builder {
            self.expiryTime = expiryTime
            return self
        }
        
        func multipleSelectNum(_ multipleSelectNum: Int?) -> Builder {
            self.multipleSelectNum = multipleSelectNum
            return self
        }
        
        func multipleSelectState(_ multipleSelectState: Int?) -> Builder {
            self.multipleSelectState = multipleSelectState
            return self
        }
        
        func polls(_ polls: [Poll]?) -> Builder {
            self.polls = polls
            return self
        }
        
        func toShowResults(_ toShowResults: Bool?) -> Builder {
            self.toShowResults = toShowResults
            return self
        }
        
        func pollAnswerText(_ pollAnswerText: String?) -> Builder {
            self.pollAnswerText = pollAnswerText
            return self
        }
        
        func replyChatroomId(_ replyChatroomId: String?) -> Builder {
            self.replyChatroomId = replyChatroomId
            return self
        }
        
        func deviceId(_ deviceId: String?) -> Builder {
            self.deviceId = deviceId
            return self
        }
        
        func hasFiles(_ hasFiles: Bool?) -> Builder {
            self.hasFiles = hasFiles
            return self
        }
        
        func hasReactions(_ hasReactions: Bool?) -> Builder {
            self.hasReactions = hasReactions
            return self
        }
        
        func lastUpdated(_ lastUpdated: Int?) -> Builder {
            self.lastUpdated = lastUpdated
            return self
        }
        
        func deletedByMember(_ deletedByMember: Member?) -> Builder {
            self.deletedByMember = deletedByMember
            return self
        }
        
        func build() -> Conversation {
            return Conversation(
                id: id,
                chatroomId: chatroomId,
                communityId: communityId,
                member: member,
                answer: answer,
                createdAt: createdAt,
                state: state,
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
                deletedByMember: deletedByMember
            )
        }
    }
    
    func toBuilder() -> Builder {
        return Builder()
            .id(id)
            .chatroomId(chatroomId)
            .communityId(communityId)
            .member(member)
            .answer(answer)
            .createdAt(createdAt)
            .state(state)
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
    }
}

