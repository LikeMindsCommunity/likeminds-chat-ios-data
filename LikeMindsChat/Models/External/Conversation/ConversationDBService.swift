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
    
    func getAboveConversations(
        chatroomId: String,
        limit: Int,
        timestmap: Int) -> Slice<Results<ConversationRO>>? {
            let realm = RealmManager.realmInstance()
            let conversations = realm.objects(ConversationRO.self)
            return conversations.where { query in
                query.chatroomId == chatroomId && query.createdEpoch < timestmap
            }
            .sorted(byKeyPath: DbKey.CREATED_EPOCH, ascending: true)
            .suffix(limit)
        }
    
    func getBelowConversations(
        chatroomId: String,
        limit: Int,
        timestmap: Int) -> Slice<Results<ConversationRO>>? {
            let realm = RealmManager.realmInstance()
            let conversations = realm.objects(ConversationRO.self)
            return conversations.where { query in
                query.chatroomId == chatroomId && query.createdEpoch > timestmap
            }
            .sorted(byKeyPath: DbKey.CREATED_EPOCH, ascending: true)
            .prefix(limit)
        }
    
    func getTopConversations(
        chatroomId: String,
        limit: Int) -> Slice<Results<ConversationRO>>? {
            let realm = RealmManager.realmInstance()
            let conversations = realm.objects(ConversationRO.self)
            return conversations.where { query in
                query.chatroomId == chatroomId
            }
            .sorted(byKeyPath: DbKey.CREATED_EPOCH, ascending: true)
            .prefix(limit)
        }
    
    func getBottomConversations(
        chatroomId: String,
        limit: Int) -> Slice<Results<ConversationRO>>? {
            let realm = RealmManager.realmInstance()
            let conversations = realm.objects(ConversationRO.self)
            return conversations.where { query in
                query.chatroomId == chatroomId
            }
            .sorted(byKeyPath: DbKey.CREATED_EPOCH, ascending: true)
            .suffix(limit)
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
        let memberRO = ROConverter.convertMember(member: conversation.member, communityId: SDKPreferences.shared.getCommunityId() ?? conversation.communityId ?? "")
        guard let conversationRO = ROConverter.convertConversation(conversation: conversation, member: memberRO) else { return }
        RealmManager.insertOrUpdate(conversationRO)
    }
    
    func savePostedConversation(savePostedConversationRequest: SavePostedConversationRequest) {
        let conversation = savePostedConversationRequest.conversation
        let realm = RealmManager.realmInstance()
        realm.writeAsync {
            guard let chatroomRO = ChatDBUtil.shared.getChatroom(realm: realm, chatroomId: conversation.id),
                  let conversationRO = ROConverter.convertConversation(conversation: conversation) else { return }
            if chatroomRO.conversations.isEmpty == true {
                chatroomRO.conversations.realm?.add(conversationRO)
            } else {
                if (!savePostedConversationRequest.isFromNotification) {
                    chatroomRO.conversations.where({ query in
                        query.id == (conversation.temporaryId ?? "")
                    }).realm?.deleteAll()
                    chatroomRO.conversations.realm?.add(conversationRO)
                }
            }
            //Save this conversation as the last conversation
            if ((conversationRO.createdEpoch) > (chatroomRO.lastConversationRO?.createdEpoch
                                                 ?? 0)) {
                chatroomRO.lastConversation = conversationRO
                chatroomRO.lastConversationId = conversationRO.id
                chatroomRO.lastSeenConversation = conversationRO
                chatroomRO.lastSeenConversationId = conversationRO.id
            }
            chatroomRO.updatedAt = conversationRO.createdEpoch
        }
    }
    
    func saveNewConversation(
        realm: Realm,
        conversation: Conversation
    ) {
    }
    
    func saveTemporaryConversation(request: SaveConversationRequest) {
        guard let conversation = request.conversation, let conversationRO = ROConverter.convertConversation(conversation: conversation) else { return }
        let realm = RealmManager.realmInstance()
        guard let chatroomRO = ChatDBUtil.shared.getChatroom(realm: realm, chatroomId: conversationRO.chatroomId),
        let creatorRO = ChatDBUtil.shared.getMember(realm: realm, communityId: SDKPreferences.shared.getCommunityId(), uuid: conversation.member?.sdkClientInfo?.uuid) else { return }
        
        RealmManager.write(chatroomRO) { realm, object in
            guard let object else { return }
            //add the conversation to db
            object.conversations.append(conversationRO)
            //Make the chatroom followed, if it is not already followed
            if (object.followStatus != true) {
                object.followStatus = true
            }
            
            //Save this conversation as the last conversation
            if (conversationRO.createdEpoch > (chatroomRO.lastConversationRO?.createdEpoch
                                               ?? 0)) {
                let lastConversation = chatroomRO.conversations.last
                let lastConversationRO =
                ROConverter.convertLastConversation(realm: realm, conversation: conversation, creator: creatorRO, attachments: conversation.attachments, deletedByMember: nil)
                
                chatroomRO.lastConversationRO = lastConversationRO
            }
            if (conversationRO.createdEpoch > (chatroomRO.lastSeenConversation?.createdEpoch
                                               ?? 0)
            ) {
                chatroomRO.lastSeenConversation = chatroomRO.conversations.last
            }
            //Update the chatroom timestamp for sorting of chatrooms
            if (conversationRO.createdEpoch > (chatroomRO.updatedAt ?? 0)) {
                chatroomRO.updatedAt = conversationRO.createdEpoch
            }
            //Update the total response count of this chatroom
            chatroomRO.totalResponseCount = chatroomRO.totalResponseCount + 1
            chatroomRO.totalAllResponseCount = chatroomRO.totalAllResponseCount + 1
        }
    }
    
    func updateTemporaryConversation(conversationId: String, localSavedEpoch: Int) {
        
    }
    
    func getConversation(conversationId: String) -> ConversationRO? {
        return ChatDBUtil.shared.getConversation(realm: RealmManager.realmInstance(), conversationId: conversationId)
    }
    
    func updateDeletedConversations(conversations: [Conversation]) {
        let conversationsROs = conversations.compactMap({ROConverter.convertConversation(conversation:$0)})
        let realm = RealmManager.realmInstance()
        conversations.forEach { conversation in
            if let convId = conversation.id,
                  let deletedBy = conversation.deletedBy,
                  let ro = ChatDBUtil.shared.getConversation(realm: realm, conversationId: convId),
                  let memberRo = ChatDBUtil.shared.getMember(realm: realm, communityId: SDKPreferences.shared.getCommunityId(), uuid: deletedBy) {
                RealmManager.update(ro) { object in
                    object.deletedBy = deletedBy
                    object.deletedByMember = memberRo
                }
            }
        }
    }
    
    func updateEditedConversation(conversation: Conversation) {
        let realm = RealmManager.realmInstance()
        guard let conversationRO = ChatDBUtil.shared.getConversation(realm: realm, conversationId: conversation.id) else { return }
        RealmManager.update(conversationRO) { object in
            object.answer = conversation.answer
            object.isEdited = true
            object.link = ROConverter.convertLink(chatroomId: conversation.chatroomId ?? "", communityId: conversation.communityId ?? "", link: conversation.ogTags)
        }
    }
    
    func updateConversationReaction(reaction: String, conversationId: String) {
        let realm = RealmManager.realmInstance()
        guard let conversationRO = ChatDBUtil.shared.getConversation(realm: realm, conversationId: conversationId) else { return }
        RealmManager.update(conversationRO) { object in
            guard let userUUID =  realm.objects(UserRO.self).first?.sdkClientInfoRO?.uuid else { return }
            let existingReactions = object.reactions.filter({$0.member?.sdkClientInfoRO?.uuid == userUUID})
            realm.delete(existingReactions)
            let member = ChatDBUtil.shared.getMember(realm: realm, communityId: object.communityId, uuid: userUUID)
            let reactionRO = ReactionRO()
            reactionRO.reaction = reaction
            reactionRO.member = member
            object.reactions.append(reactionRO)
        }
    }
    
    func updateConversationSubmitPoll(conversationId: String, allPollItems: [Poll]) {
        
    }
    
    func deleteReaction(conversationId: String) {
        let realm = RealmManager.realmInstance()
        guard let conversationRO = ChatDBUtil.shared.getConversation(realm: realm, conversationId: conversationId) else { return }
        
        RealmManager.update(conversationRO) { object in
            guard let userUUID =  realm.objects(UserRO.self).first?.sdkClientInfoRO?.uuid else { return }
            let existingReactions = object.reactions.filter({$0.member?.sdkClientInfoRO?.uuid == userUUID})
            RealmManager.delete(existingReactions)
        }
    }
    
}
