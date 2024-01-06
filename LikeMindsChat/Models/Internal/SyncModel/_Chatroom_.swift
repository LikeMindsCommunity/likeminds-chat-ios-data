//
//  ChatroomNetworkModel.swift
//  CollabMates
//
//  Created by Devansh Mohata on 20/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

struct _Chatroom_: Decodable {
    let about: String?
    let access: Int?
    let accessWithoutSubscription: Bool?
    let attachmentCount: Int?
    let attachmentsUploaded: Bool?
    let attendingStatus: Bool?
    let autoFollowDone: Bool?
    let cardID: Int?
    let chatroomImageURL: String?
    let coHosts: String?
    let communityID: Int?
    let createdAt: Int?
    let customTag: String?
    let date: String?
    let dateEpoch: Int?
    let dateTime: Int?
    let deviceID: String?
    let externalSeen: Bool?
    let followStatus: Bool?
    let hasBeenNamed: Bool?
    let hasFiles: Bool?
    let hasReactions: Bool?
    let header: String?
    let id: Int?
    let internalLink: String?
    let isEdited: Bool?
    let isPaid: Bool?
    let isPending: Bool?
    let isPrivate: Bool?
    let isPrivateMember: Bool?
    let isSecret: Bool?
    let isTagged: Bool?
    let lastConversationID: Int?
    let lastSeenConversationID: Int?
    let memberCanMessage: Bool?
    let muteStatus: Bool?
    let onlineLink: String?
    let onlineLinkType: Int?
    let secretChatroomLeft: Bool?
    let secretChatroomParticipants: [Int]?
    let shareLink: String?
    let state: Int?
    let title: String?
    let topicID: Int?
    let type: _ChatroomType_?
    let unseenCount: Int?
    let updatedAt: Int?
    let userID: Int?
    let ogTags: _LinkOGTags_?
    let chatRequestCreatedAt: Int?
    let chatRequestState: Int?
    let chatRequestedByID: Int?
    let chatroomWithUserID: Int?
    let deletedByUserID: Int?
    let expiryTime: Int?
    
    enum CodingKeys: String, CodingKey {
        case about, access
        case accessWithoutSubscription = "access_without_subscription"
        case attachmentCount = "attachment_count"
        case attachmentsUploaded = "attachments_uploaded"
        case attendingStatus = "attending_status"
        case autoFollowDone = "auto_follow_done"
        case cardID = "card_id"
        case chatRequestCreatedAt = "chat_request_created_at"
        case chatRequestState = "chat_request_state"
        case chatRequestedByID = "chat_requested_by_id"
        case chatroomImageURL = "chatroom_image_url"
        case chatroomWithUserID = "chatroom_with_user_id"
        case coHosts = "co_hosts"
        case communityID = "community_id"
        case createdAt = "created_at"
        case customTag = "custom_tag"
        case date
        case dateEpoch = "date_epoch"
        case dateTime = "date_time"
        case deletedByUserID = "deleted_by_user_id"
        case deviceID = "device_id"
        case expiryTime = "expiry_time"
        case externalSeen = "external_seen"
        case followStatus = "follow_status"
        case hasBeenNamed = "has_been_named"
        case hasFiles = "has_files"
        case hasReactions = "has_reactions"
        case header, id
        case internalLink = "internal_link"
        case isEdited = "is_edited"
        case isPaid = "is_paid"
        case isPending = "is_pending"
        case isPrivate = "is_private"
        case isPrivateMember = "is_private_member"
        case isSecret = "is_secret"
        case isTagged = "is_tagged"
        case lastConversationID = "last_conversation_id"
        case lastSeenConversationID = "last_seen_conversation_id"
        case memberCanMessage = "member_can_message"
        case muteStatus = "mute_status"
        case ogTags = "og_tags"
        case onlineLink = "online_link"
        case onlineLinkType = "online_link_type"
        case secretChatroomLeft = "secret_chatroom_left"
        case secretChatroomParticipants = "secret_chatroom_participants"
        case shareLink = "share_link"
        case state, title
        case topicID = "topic_id"
        case type
        case unseenCount = "unseen_count"
        case updatedAt = "updated_at"
        case userID = "user_id"
    }
}
