//
//  CommunityROModel.swift
//  RealmRestSync
//
//  Created by Pushpendra Singh on 19/12/23.
//  Copyright © 2023 LikeMinds Chat. All rights reserved.
//

import Foundation
import RealmSwift

class CommunityRO: Object {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var name: String?
    @Persisted var imageUrl: String? = nil
    @Persisted var membersCount: Int? = nil
    @Persisted var updatedAt: Int32? = nil
    @Persisted var relationshipNeeded: Bool = true
    @Persisted var conversations: List<ConversationRO> = List()
    @Persisted var downloadableContentTypes: List<String> = List()
    @Persisted var chatrooms: List<ChatroomRO> = List()
}
