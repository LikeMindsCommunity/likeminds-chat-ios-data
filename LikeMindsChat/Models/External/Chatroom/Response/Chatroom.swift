//
//  Chatroom.swift
//  RealmRestSync
//
//  Created by Pushpendra Singh on 19/12/23.
//  Copyright © 2023 LikeMinds. All rights reserved.
//

import Foundation

class Chatroom {
    private var member: Member?
    private var id: String = ""
    private var title: String = ""
    private var createdAt: Int?
    private var answerText: String?
    private var state: Int = 0
    private var unseenCount: Int?
    private var shareUrl: String?
    private var communityId: String?
    private var communityName: String?
    private var type: Int?
    private var about: String?
    private var header: String?
    private var showFollowTelescope: Bool?
    private var showFollowAutoTag: Bool?
    private var cardCreationTime: String?
    private var participantsCount: String?
    private var totalResponseCount: Int = 0
    private var muteStatus: Bool?
    private var followStatus: Bool?
    private var hasBeenNamed: Bool?
    private var hasReactions: Bool?
    private var date: String?
    private var isTagged: Bool?
    private var isPending: Bool?
    private var isPinned: Bool?
    private var isDeleted: Bool?
    private var userId: String?
    private var deletedBy: String?
    private var deletedByMember: Member?
    private var updatedAt: Int?
    private var lastSeenConversationId: String?
    private var lastConversationId: String?
    private var dateEpoch: Int?
    private var isSecret: Bool?
    private var secretChatroomParticipants: [Int]?
    private var secretChatroomLeft: Bool?
    private var reactions: [Reaction]?
    private var topicId: String?
    private var topic: Conversation?
    private var autoFollowDone: Bool?
    private var isEdited: Bool?
    private var access: Int?
    private var memberCanMessage: Bool?
    private var cohorts: [Cohort]?
    private var externalSeen: Bool?
    private var unreadConversationCount: Int?
    private var chatroomImageUrl: String?
    private var accessWithoutSubscription: Bool?
    private var lastConversation: Conversation?
    private var lastSeenConversation: Conversation?
    private var draftConversation: String?
    private var isConversationStored: Bool = false
    private var isDraft: Bool?
    private var totalAllResponseCount: Int?
    
    private init() {}
    
    class Builder {
        private var chatroom: Chatroom
        
        init() {
            chatroom = Chatroom()
        }
        
        func member(_ member: Member?) -> Builder {
            chatroom.member = member
            return self
        }
        
        func id(_ id: String) -> Builder {
            chatroom.id = id
            return self
        }
        
        func title(_ title: String) -> Builder {
            chatroom.title = title
            return self
        }
        
        func createdAt(_ createdAt: Int?) -> Builder {
            chatroom.createdAt = createdAt
            return self
        }
        
        func answerText(_ answerText: String?) -> Builder {
            chatroom.answerText = answerText
            return self
        }
        
        func state(_ state: Int) -> Builder {
            chatroom.state = state
            return self
        }
        
        func unseenCount(_ unseenCount: Int?) -> Builder {
            chatroom.unseenCount = unseenCount
            return self
        }
        
        func shareUrl(_ shareUrl: String?) -> Builder {
            chatroom.shareUrl = shareUrl
            return self
        }
        
        func communityId(_ communityId: String?) -> Builder {
            chatroom.communityId = communityId
            return self
        }
        
        func communityName(_ communityName: String?) -> Builder {
            chatroom.communityName = communityName
            return self
        }
        
        func type(_ type: Int?) -> Builder {
            chatroom.type = type
            return self
        }
        
        func about(_ about: String?) -> Builder {
            chatroom.about = about
            return self
        }
        
        func header(_ header: String?) -> Builder {
            chatroom.header = header
            return self
        }
        
        func showFollowTelescope(_ showFollowTelescope: Bool?) -> Builder {
            chatroom.showFollowTelescope = showFollowTelescope
            return self
        }
        
        func showFollowAutoTag(_ showFollowAutoTag: Bool?) -> Builder {
            chatroom.showFollowAutoTag = showFollowAutoTag
            return self
        }
        
        func cardCreationTime(_ cardCreationTime: String?) -> Builder {
            chatroom.cardCreationTime = cardCreationTime
            return self
        }
        
        func participantsCount(_ participantsCount: String?) -> Builder {
            chatroom.participantsCount = participantsCount
            return self
        }
        
        func totalResponseCount(_ totalResponseCount: Int) -> Builder {
            chatroom.totalResponseCount = totalResponseCount
            return self
        }
        
        func muteStatus(_ muteStatus: Bool?) -> Builder {
            chatroom.muteStatus = muteStatus
            return self
        }
        
        func followStatus(_ followStatus: Bool?) -> Builder {
            chatroom.followStatus = followStatus
            return self
        }
        
        func hasBeenNamed(_ hasBeenNamed: Bool?) -> Builder {
            chatroom.hasBeenNamed = hasBeenNamed
            return self
        }
        
        func hasReactions(_ hasReactions: Bool?) -> Builder {
            chatroom.hasReactions = hasReactions
            return self
        }
        
        func date(_ date: String?) -> Builder {
            chatroom.date = date
            return self
        }
        
        func isTagged(_ isTagged: Bool?) -> Builder {
            chatroom.isTagged = isTagged
            return self
        }
        
        func isPending(_ isPending: Bool?) -> Builder {
            chatroom.isPending = isPending
            return self
        }
        
        func isPinned(_ isPinned: Bool?) -> Builder {
            chatroom.isPinned = isPinned
            return self
        }
        
        func isDeleted(_ isDeleted: Bool?) -> Builder {
            chatroom.isDeleted = isDeleted
            return self
        }
        
        func userId(_ userId: String?) -> Builder {
            chatroom.userId = userId
            return self
        }
        
        func deletedBy(_ deletedBy: String?) -> Builder {
            chatroom.deletedBy = deletedBy
            return self
        }
        
        func deletedByMember(_ deletedByMember: Member?) -> Builder {
            chatroom.deletedByMember = deletedByMember
            return self
        }
        
        func updatedAt(_ updatedAt: Int?) -> Builder {
            chatroom.updatedAt = updatedAt
            return self
        }
        
        func lastSeenConversationId(_ lastSeenConversationId: String?) -> Builder {
            chatroom.lastSeenConversationId = lastSeenConversationId
            return self
        }
        
        func lastConversationId(_ lastConversationId: String?) -> Builder {
            chatroom.lastConversationId = lastConversationId
            return self
        }
        
        func dateEpoch(_ dateEpoch: Int?) -> Builder {
            chatroom.dateEpoch = dateEpoch
            return self
        }
        
        func isSecret(_ isSecret: Bool?) -> Builder {
            chatroom.isSecret = isSecret
            return self
        }
        
        func secretChatroomParticipants(_ secretChatroomParticipants: [Int]?) -> Builder {
            chatroom.secretChatroomParticipants = secretChatroomParticipants
            return self
        }
        
        func secretChatroomLeft(_ secretChatroomLeft: Bool?) -> Builder {
            chatroom.secretChatroomLeft = secretChatroomLeft
            return self
        }
        
        func reactions(_ reactions: [Reaction]?) -> Builder {
            chatroom.reactions = reactions
            return self
        }
        
        func topicId(_ topicId: String?) -> Builder {
            chatroom.topicId = topicId
            return self
        }
        
        func topic(_ topic: Conversation?) -> Builder {
            chatroom.topic = topic
            return self
        }
        
        func autoFollowDone(_ autoFollowDone: Bool?) -> Builder {
            chatroom.autoFollowDone = autoFollowDone
            return self
        }
        
        func isEdited(_ isEdited: Bool?) -> Builder {
            chatroom.isEdited = isEdited
            return self
        }
        
        func access(_ access: Int?) -> Builder {
            chatroom.access = access
            return self
        }
        
        func memberCanMessage(_ memberCanMessage: Bool?) -> Builder {
            chatroom.memberCanMessage = memberCanMessage
            return self
        }
        
        func cohorts(_ cohorts: [Cohort]?) -> Builder {
            chatroom.cohorts = cohorts
            return self
        }
        
        func externalSeen(_ externalSeen: Bool?) -> Builder {
            chatroom.externalSeen = externalSeen
            return self
        }
        
        func unreadConversationCount(_ unreadConversationCount: Int?) -> Builder {
            chatroom.unreadConversationCount = unreadConversationCount
            return self
        }
        
        func chatroomImageUrl(_ chatroomImageUrl: String?) -> Builder {
            chatroom.chatroomImageUrl = chatroomImageUrl
            return self
        }
        
        func accessWithoutSubscription(_ accessWithoutSubscription: Bool?) -> Builder {
            chatroom.accessWithoutSubscription = accessWithoutSubscription
            return self
        }
        
        func lastConversation(_ lastConversation: Conversation?) -> Builder {
            chatroom.lastConversation = lastConversation
            return self
        }
        
        func lastSeenConversation(_ lastSeenConversation: Conversation?) -> Builder {
            chatroom.lastSeenConversation = lastSeenConversation
            return self
        }
        
        func draftConversation(_ draftConversation: String?) -> Builder {
            chatroom.draftConversation = draftConversation
            return self
        }
        
        func isConversationStored(_ isConversationStored: Bool) -> Builder {
            chatroom.isConversationStored = isConversationStored
            return self
        }
        
        func isDraft(_ isDraft: Bool?) -> Builder {
            chatroom.isDraft = isDraft
            return self
        }
        
        func totalAllResponseCount(_ totalAllResponseCount: Int?) -> Builder {
            chatroom.totalAllResponseCount = totalAllResponseCount
            return self
        }
        
        func build() -> Chatroom {
            return chatroom
        }
    }
    
    func toBuilder() -> Builder {
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
