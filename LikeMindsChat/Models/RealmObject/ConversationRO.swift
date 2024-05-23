//
//  ConversationROModel.swift
//  RealmRestSync
//
//  Created by Pushpendra Singh on 19/12/23.
//  Copyright © 2023 LikeMinds Chat. All rights reserved.
//

import Foundation
import RealmSwift

class ConversationRO: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var answer: String
    @Persisted var state: Int
    @Persisted var createdEpoch: Int
    @Persisted var chatroomId: String = ""
    @Persisted var communityId: String = ""
    @Persisted var member: MemberRO?
    @Persisted var createdAt: String?
    @Persisted var attachments = List<AttachmentRO>()
    @Persisted var link: LinkRO?
    @Persisted var date: String?
    @Persisted var isEdited: Bool?
    @Persisted var lastSeen: Bool = false
    @Persisted var replyConversationId: String?
    @Persisted var replyConversation: ConversationRO?
    @Persisted var deletedBy: String?
    @Persisted var attachmentCount: Int?
    @Persisted var attachmentsUploaded: Bool?
    @Persisted var uploadWorkerUUID: String?
    @Persisted var localSavedEpoch: Int?
    @Persisted var temporaryId: String?
    @Persisted var reactions = List<ReactionRO>()
    @Persisted var isAnonymous: Bool?
    @Persisted var allowAddOption: Bool?
    @Persisted var pollType: Int?
    @Persisted var pollTypeText: String?
    @Persisted var submitTypeText: String?
    @Persisted var expiryTime: Int?
    @Persisted var multipleSelectNum: Int?
    @Persisted var multipleSelectState: Int?
    @Persisted var polls = List<PollRO>()
    @Persisted var pollAnswerText: String?
    @Persisted var toShowResults: Bool?
    @Persisted var replyChatRoomId: String?
    @Persisted var lastUpdatedAt: Int?
    @Persisted var deletedByMember: MemberRO?
    @Persisted var isSent: Bool?
}
