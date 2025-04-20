//
//  LMMetaRO.swift
//  LikeMindsChat
//
//  Created by AI on 21/01/25.
//

import Foundation
import RealmSwift

class LMMetaRO: Object {
  @Persisted var sourceChatroomId: String?
  @Persisted var sourceChatroomName: String?
  @Persisted var sourceConversation: ConversationRO?
  @Persisted var type: String?
}
