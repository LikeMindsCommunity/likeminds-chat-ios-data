//
//  ConversationDBService.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 06/02/24.
//

import Foundation
import RealmSwift

class ConversationDBService {
    
    func getAboveConversation(
        chatroomId: String,
        limit: Int,
        conversation: Conversation?) -> Results<ConversationRO>? {
            guard let conversation else { return nil }
            let realm = RealmManager.realmInstance()
            let conversations = realm.objects(ConversationRO.self)
            return conversations.where { query in
                query.chatroomId == chatroomId && query.createdEpoch <= (conversation.createdEpoch ?? 0) && query.id != (conversation.id ?? "")
            }
            .sorted(byKeyPath: DbKey.CREATED_EPOCH, ascending: true)
        }
    
    
    
}
