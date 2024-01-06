//
//  ConversationMetaNetworkModel.swift
//  CollabMates
//
//  Created by Devansh Mohata on 20/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

struct _Conversation_: Decodable {
    
    let allowAddOption: Bool?
    let answer: String?
    let apiVersion: Int?
    let attachmentCount: Int?
    let attachmentsUploaded: Bool?
    let cardID: Int?
    let expiryTime: Int?
    let pollType: Int?
    let header: String?
    let communityID: Int?
    let createdAt: String?
    let createdEpoch: Int?
    let date: String?
    let deletedByUserID: Int?
    let deviceID: String?
    let endTime: Int?
    let hasFiles: Bool?
    let hasReactions: Bool?
    let id: Int?
    let chatroomId:Int?
    let internalLink: String?
    let isAnonymous: Bool?
    let isEdited: Bool?
    let lastUpdated: Int?
    let ogTags: _LinkOGTags_?
    let onlineLinkEnableBefore: Int?
    let pollAnswerText: String?
    let startTime: Int?
    let state: _ConversationState_?
    let temporaryID: String?
    let toShowResults: Bool?
    let userID: Int?
    let member: _Member_?
    let attachments: [_Attachment_]?
    let lastSeen: Bool?

    enum CodingKeys: String, CodingKey {
        case allowAddOption = "allow_add_option"
        case answer, attachments
        case apiVersion = "api_version"
        case attachmentCount = "attachment_count"
        case attachmentsUploaded = "attachments_uploaded"
        case cardID = "card_id"
        case communityID = "community_id"
        case createdAt = "created_at"
        case createdEpoch = "created_epoch"
        case date
        case deletedByUserID = "deleted_by_user_id"
        case deviceID = "device_id"
        case endTime = "end_time"
        case expiryTime = "expiry_time"
        case hasFiles = "has_files"
        case hasReactions = "has_reactions"
        case header, id, member
        case chatroomId = "chatroom_id"
        case internalLink = "internal_link"
        case isAnonymous = "is_anonymous"
        case isEdited = "is_edited"
        case lastUpdated = "last_updated"
        case ogTags = "og_tags"
        case onlineLinkEnableBefore = "online_link_enable_before"
        case pollAnswerText = "poll_answer_text"
        case pollType = "poll_type"
        case startTime = "start_time"
        case state
        case temporaryID = "temporary_id"
        case toShowResults = "to_show_results"
        case userID = "user_id"
        case lastSeen = "last_seen"
    }
}
