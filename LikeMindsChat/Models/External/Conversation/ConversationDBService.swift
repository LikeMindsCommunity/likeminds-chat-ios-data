//
//  ConversationDBService.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 06/02/24.
//

import Foundation
import RealmSwift

class ConversationDBService {
    
    static let shared = ConversationDBService()
    
    func getAboveConversation(
        chatroomId: String,
        limit: Int,
        conversation: Conversation?) -> Results<ConversationRO>? {
            guard let conversation else { return nil }
            let realm = RealmManager.realmInstance()
            let conversations = realm.objects(ConversationRO.self)
            return conversations.where { query in
                query.chatroomId == chatroomId && query.createdEpoch >= (conversation.createdEpoch ?? 0) && query.id != (conversation.id ?? "")
            }
            .sorted(byKeyPath: DbKey.CREATED_EPOCH, ascending: true)
        }
    
    func getBottomConversation(
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
    
    
    func getChatroomConversations(chatroomId: String) -> Results<ConversationRO>? {
        let realm = RealmManager.realmInstance()
        let conversations = ChatDBUtil.shared.getChatroomConversations(realm: realm, chatroomId: chatroomId)
        return conversations
    }
    
    func deleteConversationPermanently(conversationId: String, chatroomId: String) {
        let realm = RealmManager.realmInstance()
        guard let chatroom = ChatDBUtil.shared.getChatroom(realm: realm, chatroomId: chatroomId) else { return }
        
        guard let conversation = ChatDBUtil.shared.getConversation(realm: realm, conversationId: conversationId) else { return }
        
        RealmManager.delete(conversation)
        chatroom.totalResponseCount = chatroom.totalResponseCount - 1
        chatroom.totalAllResponseCount = chatroom.totalAllResponseCount - 1
        
        let lastConversation = chatroom.conversations.where { query in
            query.state == ChatroomType.normal.rawValue
        }
            .sorted(byKeyPath: DbKey.CREATED_EPOCH, ascending: false)
            .first
        guard let lastConversation else {
            return
        }
        chatroom.lastConversation = lastConversation
        chatroom.lastSeenConversation = lastConversation
        chatroom.lastSeenConversationId = lastConversation.id
    }
    
    func updateConversation(conversation: _Conversation_) {
        let realm = RealmManager.realmInstance()
        let memberRO = ROConverter.convertMember(member: conversation.member, communityId: SDKPreferences.shared.getCommunityId() ?? conversation.communityId ?? "")
        guard let conversationRO = ROConverter.convertConversation(conversation: conversation, member: memberRO) else { return }
        RealmManager.insertOrUpdate(conversationRO)
    }
    
    func savePostedConversation(savePostedConversationRequest: SavePostedConversationRequest) {
        
    }
    
    func saveNewConversation(
        realm: Realm,
        conversation: _Conversation_
    ) {
    }
    
    func updateTemporaryConversation(conversationId: String, localSavedEpoch: Int) {
        
    }
    
    func getConversation(realm: Realm, conversationId: String) -> ConversationRO? {
        return ChatDBUtil.shared.getConversation(realm: realm, conversationId: conversationId)
    }
    
    func updateEditedConversation(
        conversationId: String,
        conversationText: String,
        linkOgTags: LinkOGTags?
    ) {
        
    }
    
    func updateConversationSubmitPoll(conversationId: String, allPollItems: [Poll]) {
        
    }
}
