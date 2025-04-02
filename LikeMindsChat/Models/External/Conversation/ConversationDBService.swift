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
        timestmap: Int,
        filterConversations: [Int] = []) -> Slice<Results<ConversationRO>>? {
            let realm = LMDBManager.lmDBInstance()
            let conversations = realm.objects(ConversationRO.self)
            return conversations.where { query in
                query.chatroomId == chatroomId && !query.state.in(filterConversations) && query.createdEpoch < timestmap
            }
            .sorted(byKeyPath: DbKey.CREATED_EPOCH, ascending: true)
            .suffix(limit)
        }
    
    func getBelowConversations(
        chatroomId: String,
        limit: Int,
        timestmap: Int,
        filterConversations: [Int] = []) -> Slice<Results<ConversationRO>>? {
            let realm = LMDBManager.lmDBInstance()
            let conversations = realm.objects(ConversationRO.self)
            return conversations.where { query in
                query.chatroomId == chatroomId && !query.state.in(filterConversations) && query.createdEpoch > timestmap
            }
            .sorted(byKeyPath: DbKey.CREATED_EPOCH, ascending: true)
            .prefix(limit)
        }
    
    func getTopConversations(
        chatroomId: String,
        limit: Int,
        filterConversations: [Int] = []) -> Slice<Results<ConversationRO>>? {
            let realm = LMDBManager.lmDBInstance()
            let conversations = realm.objects(ConversationRO.self)
            return conversations.where { query in
                query.chatroomId == chatroomId && !query.state.in(filterConversations)
            }
            .sorted(byKeyPath: DbKey.CREATED_EPOCH, ascending: true)
            .prefix(limit)
        }
    
    func getBottomConversations(
        chatroomId: String,
        limit: Int,
        filterConversations: [Int] = []) -> Slice<Results<ConversationRO>>? {
            let realm = LMDBManager.lmDBInstance()
            let conversations = realm.objects(ConversationRO.self)
            return conversations.where { query in
                query.chatroomId == chatroomId && !query.state.in(filterConversations)
            }
            .sorted(byKeyPath: DbKey.CREATED_EPOCH, ascending: true)
            .suffix(limit)
        }
    
    
    func getChatroomConversations(chatroomId: String, filterConversations: [Int] = []) -> Results<ConversationRO>? {
        let realm = LMDBManager.lmDBInstance()
        let conversations = ChatDBUtil.shared.getChatroomConversations(realm: realm, chatroomId: chatroomId, filterConversations: filterConversations)
        return conversations
    }
    
    func deleteConversationPermanently(conversationId: String, chatroomId: String) {
        let realm = LMDBManager.lmDBInstance()
        guard let chatroom = ChatDBUtil.shared.getChatroom(realm: realm, chatroomId: chatroomId) else { return }
        
        guard let conversation = ChatDBUtil.shared.getConversation(realm: realm, conversationId: conversationId) else { return }
        
        LMDBManager.delete(conversation)
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
        LMDBManager.write { realm, object in
            realm.insertOrUpdate(conversationRO)
        }
    }
    
    /// Updates the last conversation in the database for a given conversation.
    /// This function converts the provided conversation to a LastConversationRO and updates it in the database.
    ///
    /// - Parameter conversation: The conversation to be converted and stored as the last conversation
    func updateLastConversation(conversation: Conversation) {
        let memberRO = ROConverter.convertMember(member: conversation.member, communityId: SDKPreferences.shared.getCommunityId() ?? conversation.communityId ?? "")

        guard let lastConversationRO = ROConverter.convertLastConversation(
            realm: LMDBManager.lmDBInstance(),
            conversation: conversation,
            creator: memberRO,
            attachments: conversation.attachments,
            deletedByMember: nil
        ) else { return }
        
        LMDBManager.write { realm, object in
            realm.insertOrUpdate(lastConversationRO)
        }
    }

    
    
    func updateConversationUploadingStatus(conversationId: String, withStatus status: ConversationStatus) {
        let realm = LMDBManager.lmDBInstance()
        guard let conversationRO = ChatDBUtil.shared.getConversation(realm: realm, conversationId: conversationId) else { return }
        LMDBManager.update(conversationRO) { object in
            object.conversationStatus = status
        }
    }
    
    func savePostedConversation(savePostedConversationRequest: SavePostedConversationRequest) {
        let conversation = savePostedConversationRequest.conversation
        let realm = LMDBManager.lmDBInstance()
        realm.writeAsync {
            guard let chatroomRO = ChatDBUtil.shared.getChatroom(realm: realm, chatroomId: conversation.chatroomId),
                  let conversationRO = ROConverter.convertConversation(conversation: conversation) else { return }
            if chatroomRO.conversations.isEmpty == true {
                chatroomRO.conversations.append(conversationRO)
            } else {
                let tempConversationsRo = chatroomRO.conversations.where({ query in
                    query.id == (conversation.temporaryId ?? "")
                })
                if let attachmentsRO = tempConversationsRo.first?.attachments {
                    realm.delete(attachmentsRO)
                }
                if let pollsRO = tempConversationsRo.first?.polls {
                    realm.delete(pollsRO)
                }
                if let linkRO = tempConversationsRo.first?.link {
                    realm.delete(linkRO)
                }
                realm.delete(tempConversationsRo)
                chatroomRO.conversations.append(conversationRO)
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
    
    func saveTemporaryConversation(request: SaveConversationRequest) {
        guard let conversation = request.conversation, let conversationRO = ROConverter.convertConversation(conversation: conversation) else { return }
        let realm = LMDBManager.lmDBInstance()
        guard let chatroomRO = ChatDBUtil.shared.getChatroom(realm: realm, chatroomId: conversationRO.chatroomId),
              let creatorRO = ROConverter.convertMember(member: conversation.member, communityId: SDKPreferences.shared.getCommunityId() ?? "") else { return }
        
        LMDBManager.write(chatroomRO) { realm, object in
            guard let object else { return }
            if let tempConversation = ChatDBUtil.shared.getConversation(realm: realm, conversationId: conversation.id) {
                realm.delete(tempConversation)
            }
            //add the conversation to db
            object.conversations.append(conversationRO)
            //Make the chatroom followed, if it is not already followed
            if (object.followStatus != true) {
                object.followStatus = true
            }
            
            //Save this conversation as the last conversation
            if (conversationRO.createdEpoch > (chatroomRO.lastConversationRO?.createdEpoch
                                               ?? 0)) {
                let lastConversationRO =
                ROConverter.convertLastConversation(realm: realm, conversation: conversation, creator: creatorRO, attachments: conversation.attachments, deletedByMember: nil)
                LMDBManager.update(chatroomRO) { object in
                    chatroomRO.lastConversationRO = lastConversationRO
                }
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
        return ChatDBUtil.shared.getConversation(realm: LMDBManager.lmDBInstance(), conversationId: conversationId)
    }
    
    func updateDeletedConversations(conversations: [Conversation]) {
        let realm = LMDBManager.lmDBInstance()
        conversations.forEach { conversation in
            if let convId = conversation.id,
               let deletedBy = (conversation.deletedBy ?? conversation.deletedByMember?.sdkClientInfo?.uuid),
                  let ro = ChatDBUtil.shared.getConversation(realm: realm, conversationId: convId),
                  let memberRo = ChatDBUtil.shared.getMember(realm: realm, communityId: SDKPreferences.shared.getCommunityId(), uuid: deletedBy) {
                LMDBManager.update(ro) { object in
                    object.deletedBy = deletedBy
                    object.deletedByMember = memberRo
                }
            }
        }
    }
    
    func deletedTempConversations(conversationId: String) {
        let realm = LMDBManager.lmDBInstance()
        guard let conversationRO = ChatDBUtil.shared.getConversation(realm: realm, conversationId: conversationId) else { return }
        LMDBManager.delete(conversationRO)
    }
    
    func updateEditedConversation(conversation: Conversation) {
        let realm = LMDBManager.lmDBInstance()
        guard let conversationRO = ChatDBUtil.shared.getConversation(realm: realm, conversationId: conversation.id) else { return }
        LMDBManager.update(conversationRO) { object in
            object.answer = conversation.answer
            object.isEdited = true
            object.link = ROConverter.convertLink(chatroomId: conversation.chatroomId ?? "", communityId: conversation.communityId ?? "", link: conversation.ogTags)
        }
    }
    
    func updateConversationReaction(reaction: String, conversationId: String) {
        let realm = LMDBManager.lmDBInstance()
        guard let conversationRO = ChatDBUtil.shared.getConversation(realm: realm, conversationId: conversationId) else { return }
        LMDBManager.update(conversationRO) { object in
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
        let realm = LMDBManager.lmDBInstance()
        guard let conversationRO = ChatDBUtil.shared.getConversation(realm: realm, conversationId: conversationId) else { return }
        
        LMDBManager.update(conversationRO) { object in
            guard let userUUID =  realm.objects(UserRO.self).first?.sdkClientInfoRO?.uuid else { return }
            let existingReactions = object.reactions.filter({$0.member?.sdkClientInfoRO?.uuid == userUUID})
            realm.delete(existingReactions)
        }
    }
    
    func getMemberBy(_ uuid: String) -> MemberRO? {
        let realm = LMDBManager.lmDBInstance()
        guard let memberRO = ChatDBUtil.shared.getMember(realm: realm, communityId: SDKPreferences.shared.getCommunityId(), uuid: uuid)
        else { return nil }
        return memberRO
    }
    
    /// Updates an existing attachment in the local database.
    /// 
    /// This asynchronous method updates the provided attachment in the local Realm database.
    /// 
    /// - Parameter attachment: The `Attachment` object containing the updated data to be stored
    /// 
    /// - Returns: A `LMResponse<NoData>` object indicating the operation result
    ///   - Success: Returns `LMResponse.successResponse` with `NoData`
    ///   - Failure: Returns `LMResponse.failureResponse` with error message "Update operation failed"
    /// 
    /// - Note: This operation is performed asynchronously and does not block the calling thread
    func updateAttachment(attachment: Attachment) async -> LMResponse<NoData> {
        await ChatDBUtil.shared.updateAttachment(attachment: attachment)
    }
    
    /// Updates an existing conversation in the local database.
    /// 
    /// This asynchronous method updates the provided conversation in the local Realm database.
    /// 
    /// - Parameter conversation: The `Conversation` object containing the updated data to be stored
    /// 
    /// - Returns: A `LMResponse<NoData>` object indicating the operation result
    ///   - Success: Returns `LMResponse.successResponse` with `NoData`
    ///   - Failure: Returns `LMResponse.failureResponse` with error message "Update operation failed"
    /// 
    /// - Note: This operation is performed asynchronously and does not block the calling thread
    func updateConversation(conversation: Conversation) async -> LMResponse<NoData> {
        await ChatDBUtil.shared.updateConversation(conversation: conversation)
    }
    
    /// Updates the last conversation model in the chatroom with the provided conversation.
    /// This method updates the chatroom's last conversation references and stores the conversation in the database.
    ///
    /// - Parameters:
    ///   - chatroomId: The ID of the chatroom whose last conversation needs to be updated
    ///   - conversation: The conversation to be set as the last conversation
    func updateLastConversationModel(chatroomId: String, conversation: Conversation) {
        let realm = LMDBManager.lmDBInstance()
        guard let chatroom = ChatDBUtil.shared.getChatroom(realm: realm, chatroomId: chatroomId) else { return }
        
        // Convert the conversation to ConversationRO
        let memberRO = ROConverter.convertMember(member: conversation.member, communityId: SDKPreferences.shared.getCommunityId() ?? conversation.communityId ?? "")
        let conversationModel = ModelConverter.shared.convertToInternalConversation(conversation)
        guard let conversationRO = ROConverter.convertConversation(conversation: conversationModel, member: memberRO) else { return }   
        
        // Update chatroom's last conversation references and write to Realm
        LMDBManager.write { realm, object in
            chatroom.lastConversation = conversationRO
        }
    }
}
