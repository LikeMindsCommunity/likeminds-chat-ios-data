//
//  ChatroomDBService.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 10/04/24.
//

import Foundation
import RealmSwift

class ChatroomDBService {
    
    static let shared = ChatroomDBService()
    
    
    func getChatroom(chatroomId: String) -> ChatroomRO? {
        guard let chatroom = ChatDBUtil.shared.getChatroom(realm: RealmManager.realmInstance(), chatroomId: chatroomId) else { return nil }
        return chatroom
    }
    
    func updateChatroomTopic(chatroomId: String, topicId: String) {
        let realm = RealmManager.realmInstance()
        realm.beginAsyncWrite {
            guard let chatroom = ChatDBUtil.shared.getChatroom(realm: realm, chatroomId: chatroomId) else { return }
            chatroom.topicId = topicId
            if let topic = ChatDBUtil.shared.getConversation(realm: realm, conversationId: topicId) {
                chatroom.topic = topic
            }
        }
    }
}
