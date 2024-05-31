//
//  Chatroom.swift
//  RealmRestSync
//
//  Created by Pushpendra Singh on 19/12/23.
//  Copyright © 2023 LikeMinds. All rights reserved.
//

import Foundation

public class Chatroom: Decodable {
    
    public private(set) var member: Member?
    public private(set) var id: String = ""
    public private(set) var title: String = ""
    public private(set) var createdAt: String?
    public private(set) var answerText: String?
    public private(set) var state: Int = 0
    public private(set) var unseenCount: Int?
    public private(set) var shareUrl: String?
    public private(set) var communityId: String?
    public private(set) var communityName: String?
    public private(set) var type: Int?
    public private(set) var about: String?
    public private(set) var header: String?
    public private(set) var showFollowTelescope: Bool?
    public private(set) var showFollowAutoTag: Bool?
    public private(set) var cardCreationTime: String?
    public private(set) var participantsCount: Int?
    public private(set) var totalResponseCount: Int = 0
    public private(set) var muteStatus: Bool?
    public var followStatus: Bool?
    public private(set) var hasBeenNamed: Bool?
    public private(set) var hasReactions: Bool?
    public private(set) var date: String?
    public private(set) var isTagged: Bool?
    public private(set) var isPending: Bool?
    public private(set) var isPinned: Bool?
    public private(set) var isDeleted: Bool?
    public private(set) var userId: String?
    public private(set) var deletedBy: String?
    public private(set) var deletedByMember: Member?
    public private(set) var updatedAt: Int?
    public private(set) var lastSeenConversationId: String?
    public private(set) var lastConversationId: String?
    public private(set) var dateEpoch: Int?
    public private(set) var isSecret: Bool?
    public private(set) var secretChatroomParticipants: [Int]?
    public private(set) var secretChatroomLeft: Bool?
    public private(set) var reactions: [Reaction]?
    public private(set) var topicId: String?
    public private(set) var topic: Conversation?
    public private(set) var autoFollowDone: Bool?
    public private(set) var isEdited: Bool?
    public private(set) var access: Int?
    public private(set) var memberCanMessage: Bool?
    public private(set) var cohorts: [Cohort]?
    public private(set) var externalSeen: Bool?
    public private(set) var unreadConversationCount: Int?
    public private(set) var chatroomImageUrl: String?
    public private(set) var accessWithoutSubscription: Bool?
    public private(set) var lastConversation: Conversation?
    public private(set) var lastSeenConversation: Conversation?
    public private(set) var draftConversation: String?
    public private(set) var isConversationStored: Bool = false
    public private(set) var isDraft: Bool?
    public private(set) var totalAllResponseCount: Int?
    
    public static func builder() -> Builder { Builder() }
    
    public class Builder {
        
        private(set) var chatroom: Chatroom
        
        init() {
            chatroom = Chatroom()
        }
        
        public func member(_ member: Member?) -> Builder {
            chatroom.member = member
            return self
        }
        
        public func id(_ id: String) -> Builder {
            chatroom.id = id
            return self
        }
        
        public func title(_ title: String) -> Builder {
            chatroom.title = title
            return self
        }
        
        public func createdAt(_ createdAt: String?) -> Builder {
            chatroom.createdAt = createdAt
            return self
        }
        
        public func answerText(_ answerText: String?) -> Builder {
            chatroom.answerText = answerText
            return self
        }
        
        public func state(_ state: Int) -> Builder {
            chatroom.state = state
            return self
        }
        
        public func unseenCount(_ unseenCount: Int?) -> Builder {
            chatroom.unseenCount = unseenCount
            return self
        }
        
        public func shareUrl(_ shareUrl: String?) -> Builder {
            chatroom.shareUrl = shareUrl
            return self
        }
        
        public func communityId(_ communityId: String?) -> Builder {
            chatroom.communityId = communityId
            return self
        }
        
        public func communityName(_ communityName: String?) -> Builder {
            chatroom.communityName = communityName
            return self
        }
        
        public func type(_ type: Int?) -> Builder {
            chatroom.type = type
            return self
        }
        
        public func about(_ about: String?) -> Builder {
            chatroom.about = about
            return self
        }
        
        public func header(_ header: String?) -> Builder {
            chatroom.header = header
            return self
        }
        
        public func showFollowTelescope(_ showFollowTelescope: Bool?) -> Builder {
            chatroom.showFollowTelescope = showFollowTelescope
            return self
        }
        
        public func showFollowAutoTag(_ showFollowAutoTag: Bool?) -> Builder {
            chatroom.showFollowAutoTag = showFollowAutoTag
            return self
        }
        
        public func cardCreationTime(_ cardCreationTime: String?) -> Builder {
            chatroom.cardCreationTime = cardCreationTime
            return self
        }
        
        public func participantsCount(_ participantsCount: Int?) -> Builder {
            chatroom.participantsCount = participantsCount
            return self
        }
        
        public func totalResponseCount(_ totalResponseCount: Int) -> Builder {
            chatroom.totalResponseCount = totalResponseCount
            return self
        }
        
        public func muteStatus(_ muteStatus: Bool?) -> Builder {
            chatroom.muteStatus = muteStatus
            return self
        }
        
        public func followStatus(_ followStatus: Bool?) -> Builder {
            chatroom.followStatus = followStatus
            return self
        }
        
        public func hasBeenNamed(_ hasBeenNamed: Bool?) -> Builder {
            chatroom.hasBeenNamed = hasBeenNamed
            return self
        }
        
        public func hasReactions(_ hasReactions: Bool?) -> Builder {
            chatroom.hasReactions = hasReactions
            return self
        }
        
        public func date(_ date: String?) -> Builder {
            chatroom.date = date
            return self
        }
        
        public func isTagged(_ isTagged: Bool?) -> Builder {
            chatroom.isTagged = isTagged
            return self
        }
        
        public func isPending(_ isPending: Bool?) -> Builder {
            chatroom.isPending = isPending
            return self
        }
        
        public func isPinned(_ isPinned: Bool?) -> Builder {
            chatroom.isPinned = isPinned
            return self
        }
        
        public func isDeleted(_ isDeleted: Bool?) -> Builder {
            chatroom.isDeleted = isDeleted
            return self
        }
        
        public func userId(_ userId: String?) -> Builder {
            chatroom.userId = userId
            return self
        }
        
        public func deletedBy(_ deletedBy: String?) -> Builder {
            chatroom.deletedBy = deletedBy
            return self
        }
        
        public func deletedByMember(_ deletedByMember: Member?) -> Builder {
            chatroom.deletedByMember = deletedByMember
            return self
        }
        
        public func updatedAt(_ updatedAt: Int?) -> Builder {
            chatroom.updatedAt = updatedAt
            return self
        }
        
        public func lastSeenConversationId(_ lastSeenConversationId: String?) -> Builder {
            chatroom.lastSeenConversationId = lastSeenConversationId
            return self
        }
        
        public func lastConversationId(_ lastConversationId: String?) -> Builder {
            chatroom.lastConversationId = lastConversationId
            return self
        }
        
        public func dateEpoch(_ dateEpoch: Int?) -> Builder {
            chatroom.dateEpoch = dateEpoch
            return self
        }
        
        public func isSecret(_ isSecret: Bool?) -> Builder {
            chatroom.isSecret = isSecret
            return self
        }
        
        public func secretChatroomParticipants(_ secretChatroomParticipants: [Int]?) -> Builder {
            chatroom.secretChatroomParticipants = secretChatroomParticipants
            return self
        }
        
        public func secretChatroomLeft(_ secretChatroomLeft: Bool?) -> Builder {
            chatroom.secretChatroomLeft = secretChatroomLeft
            return self
        }
        
        public func reactions(_ reactions: [Reaction]?) -> Builder {
            chatroom.reactions = reactions
            return self
        }
        
        public func topicId(_ topicId: String?) -> Builder {
            chatroom.topicId = topicId
            return self
        }
        
        public func topic(_ topic: Conversation?) -> Builder {
            chatroom.topic = topic
            return self
        }
        
        public func autoFollowDone(_ autoFollowDone: Bool?) -> Builder {
            chatroom.autoFollowDone = autoFollowDone
            return self
        }
        
        public func isEdited(_ isEdited: Bool?) -> Builder {
            chatroom.isEdited = isEdited
            return self
        }
        
        public func access(_ access: Int?) -> Builder {
            chatroom.access = access
            return self
        }
        
        public func memberCanMessage(_ memberCanMessage: Bool?) -> Builder {
            chatroom.memberCanMessage = memberCanMessage
            return self
        }
        
        public func cohorts(_ cohorts: [Cohort]?) -> Builder {
            chatroom.cohorts = cohorts
            return self
        }
        
        public func externalSeen(_ externalSeen: Bool?) -> Builder {
            chatroom.externalSeen = externalSeen
            return self
        }
        
        public func unreadConversationCount(_ unreadConversationCount: Int?) -> Builder {
            chatroom.unreadConversationCount = unreadConversationCount
            return self
        }
        
        public func chatroomImageUrl(_ chatroomImageUrl: String?) -> Builder {
            chatroom.chatroomImageUrl = chatroomImageUrl
            return self
        }
        
        public func accessWithoutSubscription(_ accessWithoutSubscription: Bool?) -> Builder {
            chatroom.accessWithoutSubscription = accessWithoutSubscription
            return self
        }
        
        public func lastConversation(_ lastConversation: Conversation?) -> Builder {
            chatroom.lastConversation = lastConversation
            return self
        }
        
        public func lastSeenConversation(_ lastSeenConversation: Conversation?) -> Builder {
            chatroom.lastSeenConversation = lastSeenConversation
            return self
        }
        
        public func draftConversation(_ draftConversation: String?) -> Builder {
            chatroom.draftConversation = draftConversation
            return self
        }
        
        public func isConversationStored(_ isConversationStored: Bool) -> Builder {
            chatroom.isConversationStored = isConversationStored
            return self
        }
        
        public func isDraft(_ isDraft: Bool?) -> Builder {
            chatroom.isDraft = isDraft
            return self
        }
        
        public func totalAllResponseCount(_ totalAllResponseCount: Int?) -> Builder {
            chatroom.totalAllResponseCount = totalAllResponseCount
            return self
        }
        
        public func build() -> Chatroom {
            return chatroom
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder()
            .member(member)
            .id(id)
            .title(title)
            .createdAt(createdAt)
            .answerText(answerText)
            .state(state)
            .unseenCount(unseenCount)
            .shareUrl(shareUrl)
            .communityId(communityId)
            .communityName(communityName)
            .type(type)
            .about(about)
            .header(header)
            .showFollowTelescope(showFollowTelescope)
            .showFollowAutoTag(showFollowAutoTag)
            .cardCreationTime(cardCreationTime)
            .participantsCount(participantsCount)
            .totalResponseCount(totalResponseCount)
            .muteStatus(muteStatus)
            .followStatus(followStatus)
            .hasBeenNamed(hasBeenNamed)
            .hasReactions(hasReactions)
            .date(date)
            .isTagged(isTagged)
            .isPending(isPending)
            .isPinned(isPinned)
            .isDeleted(isDeleted)
            .userId(userId)
            .deletedBy(deletedBy)
            .deletedByMember(deletedByMember)
            .updatedAt(updatedAt)
            .lastSeenConversationId(lastSeenConversationId)
            .lastConversationId(lastConversationId)
            .dateEpoch(dateEpoch)
            .isSecret(isSecret)
            .secretChatroomParticipants(secretChatroomParticipants)
            .secretChatroomLeft(secretChatroomLeft)
            .reactions(reactions)
            .topicId(topicId)
            .topic(topic)
            .autoFollowDone(autoFollowDone)
            .isEdited(isEdited)
            .access(access)
            .memberCanMessage(memberCanMessage)
            .cohorts(cohorts)
            .externalSeen(externalSeen)
            .unreadConversationCount(unreadConversationCount)
            .chatroomImageUrl(chatroomImageUrl)
            .accessWithoutSubscription(accessWithoutSubscription)
            .lastConversation(lastConversation)
            .lastSeenConversation(lastSeenConversation)
            .draftConversation(draftConversation)
            .isConversationStored(isConversationStored)
            .isDraft(isDraft)
            .totalAllResponseCount(totalAllResponseCount)
    }
}
