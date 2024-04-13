//
//  ChatroomNetworkModel.swift
//  CollabMates
//
//  Created by Devansh Mohata on 20/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation



struct _Chatroom_: Decodable {
    
    let member: Member?
    let id: String?
    let title: String?
    let createdAt: Int?
    let answerText: String?
    let state: Int?
    let unseenCount: Int?
    let shareUrl: String?
    let communityId: String?
    let communityName: String?
    let type: Int?
    let about: String?
    let header: String?
    let showFollowTelescope: Bool?
    let showFollowAutoTag: Bool?
    let cardCreationTime: String?
    let participantsCount: String?
    let totalResponseCount: String?
    let muteStatus: Bool?
    let followStatus: Bool?
    let hasBeenNamed: Bool?
    let hasReactions: Bool?
    let date: String?
    let isTagged: Bool?
    let isPending: Bool?
    let isPinned: Bool?
    let isDeleted: Bool?
    let userId: String?
    let deletedBy: String?
    let deletedByMember: Member?
    let updatedAt: Int?
    let lastSeenConversationId: String?
    let lastConversationId: String?
    let dateEpoch: Int?
    let isSecret: Bool?
    let secretChatroomParticipants: [Int]?
    let secretChatroomLeft: Bool?
    let reactions: [Reaction]?
    let topicId: String?
    let topic: _Conversation_?
    let autoFollowDone: Bool?
    let isEdited: Bool?
    let access: Int?
    let memberCanMessage: Bool?
    let cohorts: [Cohort]?
    let externalSeen: Bool?
    let unreadConversationCount: Int?
    let chatroomImageUrl: String?
    let accessWithoutSubscription: Bool?
    
    enum CodingKeys: String, CodingKey {
        case member
        case id
        case title
        case createdAt = "created_at"
        case answerText = "answer_text"
        case state
        case unseenCount = "unseen_count"
        case shareUrl = "share_url"
        case communityId = "community_id"
        case communityName = "community_name"
        case type
        case about
        case header
        case showFollowTelescope = "show_follow_telescope"
        case showFollowAutoTag = "show_follow_auto_tag"
        case cardCreationTime = "card_creation_time"
        case participantsCount = "participants_count"
        case totalResponseCount = "total_response_count"
        case muteStatus = "mute_status"
        case followStatus = "follow_status"
        case hasBeenNamed = "has_been_named"
        case hasReactions = "has_reactions"
        case date
        case isTagged = "is_tagged"
        case isPending = "is_pending"
        case isPinned = "is_pinned"
        case isDeleted = "is_deleted"
        case userId = "user_id"
        case deletedBy = "deleted_by_user_id"
        case deletedByMember = "deleted_by_member"
        case updatedAt = "updated_at"
        case lastSeenConversationId = "last_seen_conversation"
        case lastConversationId = "last_conversation_id"
        case dateEpoch = "date_epoch"
        case isSecret = "is_secret"
        case secretChatroomParticipants = "secret_chatroom_participants"
        case secretChatroomLeft = "secret_chatroom_left"
        case reactions
        case topicId = "topic_id"
        case topic
        case autoFollowDone = "auto_follow_done"
        case isEdited = "is_edited"
        case access
        case memberCanMessage = "member_can_message"
        case cohorts
        case externalSeen = "external_seen"
        case unreadConversationCount = "unread_messages"
        case chatroomImageUrl = "chatroom_image_url"
        case accessWithoutSubscription = "access_without_subscription"
    }
}

extension _Chatroom_ {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        member = try container.decodeIfPresent(Member.self, forKey: .member)
        id = try container.decodeIntToStringIfPresent(forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        createdAt = try container.decodeIfPresent(Int.self, forKey: .createdAt)
        answerText = try container.decodeIfPresent(String.self, forKey: .answerText)
        state = try container.decodeIfPresent(Int.self, forKey: .state)
        unseenCount = try container.decodeIfPresent(Int.self, forKey: .unseenCount)
        shareUrl = try container.decodeIfPresent(String.self, forKey: .shareUrl)
        communityId = try container.decodeIntToStringIfPresent(forKey: .communityId)
        communityName = try container.decodeIfPresent(String.self, forKey: .communityName)
        type = try container.decodeIfPresent(Int.self, forKey: .type)
        about = try container.decodeIfPresent(String.self, forKey: .about)
        header = try container.decodeIfPresent(String.self, forKey: .header)
        showFollowTelescope = try container.decodeIfPresent(Bool.self, forKey: .showFollowTelescope)
        showFollowAutoTag = try container.decodeIfPresent(Bool.self, forKey: .showFollowAutoTag)
        cardCreationTime = try container.decodeIfPresent(String.self, forKey: .cardCreationTime)
        participantsCount = try container.decodeIfPresent(String.self, forKey: .participantsCount)
        totalResponseCount = try container.decodeIfPresent(String.self, forKey: .totalResponseCount)
        muteStatus = try container.decodeIfPresent(Bool.self, forKey: .muteStatus)
        followStatus = try container.decodeIfPresent(Bool.self, forKey: .followStatus)
        hasBeenNamed = try container.decodeIfPresent(Bool.self, forKey: .hasBeenNamed)
        hasReactions = try container.decodeIfPresent(Bool.self, forKey: .hasReactions)
        date = try container.decodeIfPresent(String.self, forKey: .date)
        isTagged = try container.decodeIfPresent(Bool.self, forKey: .isTagged)
        isPending = try container.decodeIfPresent(Bool.self, forKey: .isPending)
        isPinned = try container.decodeIfPresent(Bool.self, forKey: .isPinned)
        isDeleted = try container.decodeIfPresent(Bool.self, forKey: .isDeleted)
        userId = try container.decodeIntToStringIfPresent(forKey: .userId)
        deletedBy = try container.decodeIfPresent(String.self, forKey: .deletedBy)
        deletedByMember = try container.decodeIfPresent(Member.self, forKey: .deletedByMember)
        updatedAt = try container.decodeIfPresent(Int.self, forKey: .updatedAt)
        lastSeenConversationId = try container.decodeIfPresent(String.self, forKey: .lastSeenConversationId)
        lastConversationId = try container.decodeIntToStringIfPresent(forKey: .lastConversationId)
        dateEpoch = try container.decodeIfPresent(Int.self, forKey: .dateEpoch)
        isSecret = try container.decodeIfPresent(Bool.self, forKey: .isSecret)
        secretChatroomParticipants = try container.decodeIfPresent([Int].self, forKey: .secretChatroomParticipants)
        secretChatroomLeft = try container.decodeIfPresent(Bool.self, forKey: .secretChatroomLeft)
        reactions = try container.decodeIfPresent([Reaction].self, forKey: .reactions)
        topicId = try container.decodeIntToStringIfPresent(forKey: .topicId)
        topic = try container.decodeIfPresent(_Conversation_.self, forKey: .topic)
        autoFollowDone = try container.decodeIfPresent(Bool.self, forKey: .autoFollowDone)
        isEdited = try container.decodeIfPresent(Bool.self, forKey: .isEdited)
        access = try container.decodeIfPresent(Int.self, forKey: .access)
        memberCanMessage = try container.decodeIfPresent(Bool.self, forKey: .memberCanMessage)
        cohorts = try container.decodeIfPresent([Cohort].self, forKey: .cohorts)
        externalSeen = try container.decodeIfPresent(Bool.self, forKey: .externalSeen)
        unreadConversationCount = try container.decodeIfPresent(Int.self, forKey: .unreadConversationCount)
        chatroomImageUrl = try container.decodeIfPresent(String.self, forKey: .chatroomImageUrl)
        accessWithoutSubscription = try container.decodeIfPresent(Bool.self, forKey: .accessWithoutSubscription)
    }
}

extension KeyedDecodingContainer {
    
    public func decodeIntToStringIfPresent(forKey key: KeyedDecodingContainer<K>.Key) throws -> String? {
        if let decodedValue = try? self.decodeIfPresent(String.self, forKey: key) {
            return decodedValue
        } else if let decodedValue = try? self.decodeIfPresent(Int.self, forKey: key) {
            return String(decodedValue)
        }
        return nil
    }
}
