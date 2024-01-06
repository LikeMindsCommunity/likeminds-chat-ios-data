//
//  ChatroomROModel.swift
//  RealmRestSync
//
//  Created by Pushpendra Singh on 19/12/23.
//  Copyright © 2023 LikeMinds Chat. All rights reserved.
//

import Foundation
import RealmSwift

class ChatroomRO: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    @Persisted var communityId: String
    @Persisted var state: Int = 0
    @Persisted var member: MemberRO?
    @Persisted var createdAt: Int32?
    @Persisted var type: Int?
    @Persisted var chatroomImageUrl: String?
    @Persisted var header: String?
    @Persisted var cardCreationTime: String?
    @Persisted var totalResponseCount: Int = 0
    @Persisted var totalAllResponseCount: Int = 0
    @Persisted var muteStatus: Bool?
    @Persisted var followStatus: Bool?
    @Persisted var hasBeenNamed: Bool?
    @Persisted var date: String?
    @Persisted var isTagged: Bool?
    @Persisted var isPending: Bool?
    @Persisted var deletedBy: String?
    @Persisted var updatedAt: Int32? //in millis, to sort chatrooms in home feed
    @Persisted var lastConversation: ConversationRO? //last conversation with state 0
    @Persisted var lastConversationRO: LastConversationRO?
    @Persisted var lastSeenConversationId: String?
    @Persisted var lastSeenConversation: ConversationRO? //last seen conversation
    @Persisted var dateEpoch: Int32?
    @Persisted var unseenCount: Int = 0
    @Persisted  var relationshipNeeded: Bool = true
    @Persisted var draftConversation: String?
    @Persisted var isSecret: Bool?
    @Persisted var secretChatRoomParticipants: List<Int> = List()
    @Persisted var secretChatRoomLeft: Bool?
    @Persisted var conversations: List<ConversationRO> = List()
    @Persisted var topicId: String?
    @Persisted var topic: ConversationRO?
    @Persisted var autoFollowDone: Bool?
    @Persisted var memberCanMessage: Bool?
    @Persisted var isEdited: Bool?
    @Persisted var reactions: List<ReactionRO> = List()
    @Persisted var unreadConversationsCount: Int?
    @Persisted var accessWithoutSubscription: Bool = false
    @Persisted var externalSeen: Bool?
    @Persisted var isConversationStored: Bool = false
    @Persisted var isDraft: Bool?
    @Persisted var lastConversationId: String?
    
}
