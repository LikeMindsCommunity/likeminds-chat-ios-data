//
//  Conversation.swift
//  RealmRestSync
//
//  Created by Pushpendra Singh on 19/12/23.
//  Copyright © 2023 LikeMinds. All rights reserved.
//

import Foundation

class Conversation {
    var id: String?
    var chatroomId: String?
    var communityId: String?
    var member: Member?
    var answer: String?
    var createdAt: String?
    var state: Int?
    var attachments: [Attachment]?
    var lastSeen: Bool?
    var ogTags: LinkOGTags?
    var date: String?
    var isEdited: Bool?
    var memberId: String?
    var replyConversationId: String?
    var replyConversation: Conversation?
    var deletedBy: String?
    var createdEpoch: Int64?
    var attachmentCount: Int?
    var attachmentUploaded: Bool?
    var uploadWorkerUUID: String?
    var temporaryId: String?
    var localCreatedEpoch: Int64?
    var reactions: [Reaction]?
    var isAnonymous: Bool?
    var allowAddOption: Bool?
    var pollType: Int?
    var pollTypeText: String?
    var submitTypeText: String?
    var expiryTime: Int64?
    var multipleSelectNum: Int?
    var multipleSelectState: Int?
    var polls: [Poll]?
    var toShowResults: Bool?
    var pollAnswerText: String?
    var replyChatroomId: String?
    var deviceId: String?
    var hasFiles: Bool?
    var hasReactions: Bool?
    var lastUpdated: Int64?
    var deletedByMember: Member?
}
