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
        guard let chatroom = ChatDBUtil.shared.getChatroom(realm: LMDBManager.lmDBInstance(), chatroomId: chatroomId) else { return nil }
        return chatroom
    }
    
    func updateChatroomTopic(chatroomId: String, topicId: String) {
        let realm = LMDBManager.lmDBInstance()
        guard let chatroom = ChatDBUtil.shared.getChatroom(realm: realm, chatroomId: chatroomId) else { return }
        LMDBManager.update(chatroom) { object in
            chatroom.topicId = topicId
            if let topic = ChatDBUtil.shared.getConversation(realm: realm, conversationId: topicId) {
                chatroom.topic = topic
            }
        }
    }
    
    func updateChatroomFollow(chatroomId: String, status: Bool) {
        let realm = LMDBManager.lmDBInstance()
        guard let chatroom = ChatDBUtil.shared.getChatroom(realm: realm, chatroomId: chatroomId) else { return }
        LMDBManager.update(chatroom) { object in
            object.followStatus = status
        }
    }
    
    func updateChatroomMuteUnMute(chatroomId: String, status: Bool) {
        let realm = LMDBManager.lmDBInstance()
        guard let chatroom = ChatDBUtil.shared.getChatroom(realm: realm, chatroomId: chatroomId) else { return }
        LMDBManager.update(chatroom) { object in
            object.muteStatus = status
        }
    }
    
    /// Fetches an existing DM chatroom using a given user UUID
    /// - Parameter userUUID: UUID of the user involved in the DM
    /// - Returns: An optional `ChatroomRO` if found, otherwise `nil`
    func getExistingDMChatroom(userUUID: String) -> ChatroomRO? {
        let realm = LMDBManager.lmDBInstance()
        return ChatDBUtil.shared.getExistingDMChatroom(realm: realm, userUUID: userUUID)
    }
    
    func getUnreadConversationsCount() throws -> GetUnreadConversationsCountResponse {
        let realm = LMDBManager.lmDBInstance()
        return try ChatDBUtil.shared.getUnreadConversationsCount(realm: realm)
    
    }
}
