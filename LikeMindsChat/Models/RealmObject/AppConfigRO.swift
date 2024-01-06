//
//  AppConfigRO.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 02/01/24.
//

import Foundation
import RealmSwift

class AppConfigRO: Object {
    @Persisted var id: Int = 0
    @Persisted var communities: List<String> = List()
    @Persisted var isConversationsSynced: Bool = false
    @Persisted var isChatroomsSynced: Bool = false
    @Persisted var isCommunitiesSynced: Bool = false
}
