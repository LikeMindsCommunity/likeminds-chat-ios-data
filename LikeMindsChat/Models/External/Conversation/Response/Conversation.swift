//
//  Conversation.swift
//  RealmRestSync
//
//  Created by Pushpendra Singh on 19/12/23.
//  Copyright © 2023 LikeMinds. All rights reserved.
//

import Foundation

class Conversation {
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
    let replyConversation: Conversation?
    let deletedBy: String?
    let createdEpoch: Int64?
    let attachmentCount: Int?
    let attachmentUploaded: Bool?
    let uploadWorkerUUID: String?
    let temporaryId: String?
    let localCreatedEpoch: Int64?
    let reactions: [Reaction]?
    let isAnonymous: Bool?
    let allowAddOption: Bool?
    let pollType: Int?
    let pollTypeText: String?
    let submitTypeText: String?
    let expiryTime: Int64?
    let multipleSelectNum: Int?
    let multipleSelectState: Int?
    let polls: [Poll]?
    let toShowResults: Bool?
    let pollAnswerText: String?
    let replyChatroomId: String?
    let deviceId: String?
    let hasFiles: Bool?
    let hasReactions: Bool?
    let lastUpdated: Int64?
    let deletedByMember: Member?
    
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
        createdEpoch: Int64?,
        attachmentCount: Int?,
        attachmentUploaded: Bool?,
        uploadWorkerUUID: String?,
        temporaryId: String?,
        localCreatedEpoch: Int64?,
        reactions: [Reaction]?,
        isAnonymous: Bool?,
        allowAddOption: Bool?,
        pollType: Int?,
        pollTypeText: String?,
        submitTypeText: String?,
        expiryTime: Int64?,
        multipleSelectNum: Int?,
        multipleSelectState: Int?,
        polls: [Poll]?,
        toShowResults: Bool?,
        pollAnswerText: String?,
        replyChatroomId: String?,
        deviceId: String?,
        hasFiles: Bool?,
        hasReactions: Bool?,
        lastUpdated: Int64?,
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
        private var createdEpoch: Int64? = nil
        private var attachmentCount: Int? = nil
        private var attachmentUploaded: Bool? = nil
        private var uploadWorkerUUID: String? = nil
        private var temporaryId: String? = nil
        private var localCreatedEpoch: Int64? = nil
        private var reactions: [Reaction]? = nil
        private var isAnonymous: Bool? = nil
        private var allowAddOption: Bool? = nil
        private var pollType: Int? = nil
        private var pollTypeText: String? = nil
        private var submitTypeText: String? = nil
        private var expiryTime: Int64? = nil
        private var multipleSelectNum: Int? = nil
        private var multipleSelectState: Int? = nil
        private var polls: [Poll]? = nil
        private var toShowResults: Bool? = nil
        private var pollAnswerText: String? = nil
        private var replyChatroomId: String? = nil
        private var deviceId: String? = nil
        private var hasFiles: Bool? = false
        private var hasReactions: Bool? = false
        private var lastUpdated: Int64? = nil
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
        
        func createdEpoch(_ createdEpoch: Int64?) -> Builder {
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
        
        func localCreatedEpoch(_ localCreatedEpoch: Int64?) -> Builder {
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
        
        func expiryTime(_ expiryTime: Int64?) -> Builder {
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
        
        func lastUpdated(_ lastUpdated: Int64?) -> Builder {
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

