//
//  ConversationMetaNetworkModel.swift
//  CollabMates
//
//  Created by Devansh Mohata on 20/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation


struct _Conversation_: Decodable {

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
    let widgetId: String?
    var widget: Widget?

    enum CodingKeys: String, CodingKey {
        case id
        case chatroomId = "card_id"
        case communityId = "community_id"
        case member, widget
        case widgetId = "widget_id"
        case answer
        case createdAt = "created_at"
        case state
        case attachments
        case lastSeen = "last_seen"
        case ogTags = "og_tags"
        case date
        case isEdited = "is_edited"
        case memberId = "user_id"
        case replyConversationId = "reply_id"
        case deletedBy = "deleted_by_user_id"
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
    }
}

extension _Conversation_ {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIntToStringIfPresent(forKey: .id)
        chatroomId = try container.decodeIntToStringIfPresent(forKey: .chatroomId)
        communityId = try container.decodeIntToStringIfPresent(forKey: .communityId)
        member = try container.decodeIfPresent(Member.self, forKey: .member)
        answer = try container.decode(String.self, forKey: .answer)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        state = try container.decode(Int.self, forKey: .state)
        attachments = try container.decodeIfPresent([Attachment].self, forKey: .attachments)
        lastSeen = try container.decodeIfPresent(Bool.self, forKey: .lastSeen)
        ogTags = try container.decodeIfPresent(LinkOGTags.self, forKey: .ogTags)
        date = try container.decodeIfPresent(String.self, forKey: .date)
        isEdited = try container.decodeIfPresent(Bool.self, forKey: .isEdited)
        memberId = try container.decodeIntToStringIfPresent(forKey: .memberId)
        replyConversationId = try container.decodeIntToStringIfPresent(forKey: .replyConversationId)
        deletedBy = try container.decodeIntToStringIfPresent(forKey: .deletedBy)
        createdEpoch = try container.decodeIfPresent(Int.self, forKey: .createdEpoch)
        attachmentCount = try container.decodeIfPresent(Int.self, forKey: .attachmentCount)
        attachmentUploaded = try container.decodeIfPresent(Bool.self, forKey: .attachmentUploaded)
        uploadWorkerUUID = try container.decodeIfPresent(String.self, forKey: .uploadWorkerUUID)
        temporaryId = try container.decodeIntToStringIfPresent(forKey: .temporaryId)
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
        widgetId = try container.decodeIfPresent(String.self, forKey: .widgetId) ?? ""
        widget = try container.decodeIfPresent(Widget.self, forKey: .widget)
    }
}
