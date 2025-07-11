//
//  ChatDBUtil.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 07/01/24.
//

import Foundation
import RealmSwift
import Combine

class ChatDBUtil {
    
    static let shared = ChatDBUtil()
    
    /**
     * Check whether local db is empty or not
     */
    func isEmpty() -> Bool {
        let realm = LMDBManager.lmDBInstance()
        guard let query = realm.objects(AppConfigRO.self).first else { return true }
        return !query.isConversationsSynced && !query.isChatroomsSynced && !query.isCommunitiesSynced
    }
    
    /**
     * To fetch the [AppConfigRO] object
     * @return [AppConfigRO]
     */
    func getAppConfig(realm: Realm) -> AppConfigRO? {
        return realm.objects(AppConfigRO.self).first
    }
    
    func getLoggedInUser(realm: Realm) -> UserRO? {
        return realm.objects(UserRO.self).first
    }
    
    /**
     * To get the [CommunityRO] object as per [communityId]
     *
     * @param realm: Instance of realm
     * @param communityId: Id of the community to be fetched
     *
     * @return [CommunityRO]
     */
    func getCommunity(realm: Realm, communityId: String?) -> CommunityRO? {
        guard let communityId, !communityId.isEmpty else { return nil }
        return realm.objects(CommunityRO.self)
            .where { query in
                query.id == communityId
            }.first
    }
    
    /**
     * To get the list of all [ChatroomRO] object as per [communityId]
     *
     * @param realm: Instance of realm
     * @param communityId: Id of the community to be fetched
     *
     * @return list of [ChatroomRO]
     */
    func getChatrooms(
        realm: Realm,
        communityId: String
    ) -> Results<ChatroomRO> {
        return realm.objects(ChatroomRO.self)
            .where { query in
//                query.communityId == communityId &&
                query.deletedBy == nil &&
                query.followStatus == true &&
                query.type != ChatroomType.directMessage.rawValue &&
                query.type != ChatroomType.event.rawValue &&
                query.type != ChatroomType.publicEvent.rawValue
            }.sorted(byKeyPath: DbKey.UPDATED_AT, ascending: false)
    }
    
    func getDMChatrooms(
        realm: Realm,
        communityId: String
    ) -> Results<ChatroomRO> {
        return realm.objects(ChatroomRO.self)
            .where { query in
                //                query.communityId == communityId &&
                query.deletedBy == nil &&
                query.followStatus == true &&
                query.chatRequestState != nil &&
                query.type == ChatroomType.directMessage.rawValue
            }.sorted(byKeyPath: DbKey.UPDATED_AT, ascending: false)
    }
    
    /**
     * To get a specific [ChatroomRO] as per [chatroomId]
     *
     * @param realm: Instance of realm
     * @param chatroomId: Id of the chatroom to be fetched
     *
     * @return [ChatroomRO]
     */
    func getChatroom(realm: Realm, chatroomId: String?) -> ChatroomRO? {
        guard let chatroomId, !chatroomId.isEmpty else { return nil }
        
        return realm.objects(ChatroomRO.self)
            .where { query in
                query.id == chatroomId
            }.first
    }
    
    /**
     * To get a specific [ConversationRO] as per [conversationId]
     *
     * @param realm: Instance of realm
     * @param conversationId: Id of the conversation to be fetched
     *
     * @return [ConversationRO]
     */
    func getConversation(realm: Realm, conversationId: String?) -> ConversationRO? {
        guard let conversationId, !conversationId.isEmpty else { return nil }
        
        return realm.objects(ConversationRO.self)
            .where { query in
                query.id == conversationId
            }.first
    }
    
    /**
     * To get a list of the [ConversationRO] of a community
     *
     * @param realm: Instance of realm
     * @param communityId: Id of the community whose conversations are fetched
     *
     * @return [ConversationRO]
     */
    func getCommunityConversations(
        realm: Realm,
        communityId: String,
        filterConversations: [Int] = []
    ) -> Results<ConversationRO> {
        let conversations = realm.objects(ConversationRO.self)
        return conversations.where { query in
            query.communityId == communityId && !query.state.in(filterConversations)
        }
    }
    
    /**
     * To get a list of the [ConversationRO] of a chatroom
     *
     * @param realm: Instance of realm
     * @param chatroomId: Id of the chatroom whose conversations are fetched
     *
     * @return [ConversationRO]
     */
    func getChatroomConversations(
        realm: Realm,
        chatroomId: String,
        filterConversations: [Int] = []
    ) -> Results<ConversationRO> {
        return realm.objects(ConversationRO.self)
            .where { query in
                query.chatroomId == chatroomId && !query.state.in(filterConversations)
            }
    }
    
    func userROUpdate(_ user: User) {
        guard let userRO = ROConverter.convertUser(user: user) else { return }
        LMDBManager.write { realm, object in
            realm.insertOrUpdate(userRO)
        }
    }
    
    func clearData() {
        LMDBManager.write { realm, object in
            realm.deleteAll()
        }
    }
    
    /**
     * Make sure to pass this inside a write transaction and all the parameters have to be managed object
     *  @param chatroomRO: chatroom object
     *  @param conversations: list of conversations
     *  @param loggedInUUID: uuid of loggedInMember
     */
    func updateRelationshipsOfChatroom(
        chatroomRO: ChatroomRO,
        conversations: Results<ConversationRO>,
        loggedInUUID: String
    ) {
       
        //Add inverse relationships for conversations
        chatroomRO.conversations = conversations.list
        
        //last seen conversation
        if (chatroomRO.lastSeenConversationId != nil) {
            let lastSeenConversation = conversations.where({ query in
                query.id == (chatroomRO.lastSeenConversationId ?? "")
            }).first
            if (lastSeenConversation != nil) {
                chatroomRO.lastSeenConversation = lastSeenConversation
               let result =  conversations.where({ query in
                    query.lastSeen == false
                }).where({ query in
                    query.createdEpoch <= (lastSeenConversation?.createdEpoch ?? -1)
                })
                result.setValue(true, forKey: DbKey.LAST_SEEN)
                //.setBoolean(DbKey.LAST_SEEN, true)
            }
        }
        
        //chatroom topic
        if let topicId = chatroomRO.topicId {
            let chatroomTopic = conversations.where({ query in
                query.id == topicId
            }).first
            chatroomRO.topic = chatroomTopic
        }
        
        //chatroom updated at for sorting
        var lastConversationCreatedEpoch: Int?
        if (chatroomRO.type == ChatroomType.directMessage.rawValue) {
            lastConversationCreatedEpoch = chatroomRO.lastConversation?.createdEpoch
        } else {
            //if last conversation is present in chatroom
            if chatroomRO.lastConversationRO != nil {
                lastConversationCreatedEpoch = chatroomRO.lastConversationRO?.createdEpoch
            } else {
                //else find last conversation from db
                let conversation = conversations.where { query in
                    (query.state == ChatroomType.normal.rawValue || query.state == ChatroomType.poll.rawValue) && query.member.uuid == loggedInUUID
                }.first
                lastConversationCreatedEpoch = conversation?.createdEpoch
            }
        }
        
        let chatroomUpdatedAt: Int = lastConversationCreatedEpoch != nil ? lastConversationCreatedEpoch! : (chatroomRO.dateEpoch ?? 0) * 1000 //Multiplying by 1000 as dateEpoch is in seconds
        if chatroomUpdatedAt > 0 {
            chatroomRO.updatedAt = chatroomUpdatedAt
        }
        
        //total response count
        if (chatroomRO.type == ChatroomType.directMessage.rawValue) {
            chatroomRO.totalResponseCount = conversations.count
        } else {
            chatroomRO.totalResponseCount = conversations.where({ query in
                query.state == ChatroomType.normal.rawValue || query.state == ChatroomType.poll.rawValue
            }).count
        }
        
        //if last conversation is present in chatroom add 1 in count
        if (chatroomRO.lastConversationRO != nil) {
            chatroomRO.totalAllResponseCount =  conversations.count + 1
        } else {
            chatroomRO.totalAllResponseCount =  conversations.count
        }
        chatroomRO.relationshipNeeded = false
    }
    
    
    /**
     * to get conversation creator
     *
     * @param realm: Instance of realm
     * @param conversation: object of conversation
     *
     * @return [MemberRO]: creator of conversation
     */
    func getConversationMember(
        realm: Realm,
        conversation: _Conversation_
    ) -> MemberRO? {
        guard let communityId = conversation.communityId, let uuid = conversation.member?.sdkClientInfo?.uuid ?? conversation.memberId else { return nil }
        return getMember(
            realm: realm,
            communityId: communityId, uuid:uuid
        )
    }
    
    /**
     * To get a specific [MemberRO] of a community
     *
     * @param realm: Instance of realm
     * @param communityId: Id of the community
     * @param uuid: uuid of the member
     *
     * @return [MemberRO]
     */
    func getMember(
        realm: Realm,
        communityId: String?,
        uuid: String?
    ) -> MemberRO? {
        guard let communityId, let uuid else { return nil }
        let uid = "\(uuid)#\(communityId)"
        let member = getMemberByUid(realm: realm, uid: uid)
        return member
    }
    
    private func getMemberByUid(realm: Realm, uid: String) -> MemberRO? {
        return realm.objects(MemberRO.self)
            .where({ query in
                query.uid == uid
            })
            .first
    }
    
    /**
     * to update chatroom's [isConversationStored]
     *
     * @param chatroomId: id of chatroom to be updated
     * @param isConversationStored: value of [isConversationStored] -> true or false
     */
    func updateIsConversationStoreForChatroom(
        chatroomId: String,
        isConversationStored: Bool
    ) {
        let realm = LMDBManager.lmDBInstance()
        realm.writeAsync {
            let chatroomRO = self.getChatroom(realm: realm, chatroomId: chatroomId)
            chatroomRO?.isConversationStored = isConversationStored
        }
    }
    
    /// Updates an existing attachment in the local Realm database.
    /// 
    /// This method asynchronously updates the provided attachment in the local database using Realm.
    /// The operation is performed in a background thread to avoid blocking the main thread.
    /// 
    /// - Parameter attachment: The `Attachment` object containing the updated data to be stored
    /// 
    /// - Returns: A `LMResponse<NoData>` object indicating the success or failure of the operation
    ///   - On success: Returns `LMResponse.successResponse` with `NoData`
    ///   - On failure: Returns `LMResponse.failureResponse` with an error message
    /// 
    /// - Note: This method uses Combine's Future and async/await pattern for handling asynchronous operations
    func updateAttachment(attachment: Attachment) async -> LMResponse<NoData> {
        // Wrap the writeAsync call in a Combine Future.
        let updatePublisher = Future<LMResponse<NoData>, Never> { promise in
            let realm = LMDBManager.lmDBInstance()
            realm.writeAsync({
                // Update the attachment in the local DB.
                let _ = ROConverter.convertAttachment(attachment: attachment)
            }, onComplete: { error in
                if let _ = error {
                    // If an error occurs, complete with a failure response.
                    promise(.success(LMResponse.failureResponse("Update operation failed.")))
                } else {
                    // Otherwise, complete with a successful response.
                    promise(.success(LMResponse.successResponse(NoData())))
                }
            })
        }
        
        // Convert the Combine publisher to an async value.
        return await withCheckedContinuation { continuation in
            let _ = updatePublisher.sink { response in
                continuation.resume(returning: response)
            }
        }
    }

    /// Updates an existing conversation in the local Realm database.
    /// 
    /// This method asynchronously updates the provided conversation in the local database using Realm.
    /// The operation is performed in a background thread to avoid blocking the main thread.
    /// 
    /// - Parameter conversation: The `Conversation` object containing the updated data to be stored
    /// 
    /// - Returns: A `LMResponse<NoData>` object indicating the success or failure of the operation
    ///   - On success: Returns `LMResponse.successResponse` with `NoData`
    ///   - On failure: Returns `LMResponse.failureResponse` with an error message
    /// 
    /// - Note: This method uses Combine's Future and async/await pattern for handling asynchronous operations
    func updateConversation(conversation: Conversation) async -> LMResponse<NoData> {
        // Wrap the writeAsync call in a Combine Future.
        let updatePublisher = Future<LMResponse<NoData>, Never> { promise in
            let realm = LMDBManager.lmDBInstance()
            realm.writeAsync({
                // Update the conversation in the local DB.
                let _ = ROConverter.convertConversation(conversation: conversation)
            }, onComplete: { error in
                if let _ = error {
                    // If an error occurs, complete with a failure response.
                    promise(.success(LMResponse.failureResponse("Update operation failed.")))
                } else {
                    // Otherwise, complete with a successful response.
                    promise(.success(LMResponse.successResponse(NoData())))
                }
            })
        }
        
        // Convert the Combine publisher to an async value.
        return await withCheckedContinuation { continuation in
            let _ = updatePublisher.sink { response in
                continuation.resume(returning: response)
            }
        }
    }
    
    func getExistingDMChatroom(realm: Realm, userUUID: String) -> ChatroomRO? {
        let chatrooms = realm.objects(ChatroomRO.self).where { query in
            query.type == ChatroomType.directMessage.rawValue
        }

        let filteredChatroom = chatrooms.first { chatroom in
            chatroom.member?.uuid == userUUID ||
            (chatroom.chatroomWithUser?.uuid == userUUID)
        }

        return filteredChatroom
    }
    
    func getUnreadConversationsCount(realm: Realm) throws -> GetUnreadConversationsCountResponse {
        // Get unread count for group chatrooms (normal and purpose types)
        let groupChatrooms = realm.objects(ChatroomRO.self)
            .where { query in
                query.followStatus == true
            }
            .where { query in
                query.type == ChatroomType.normal.rawValue ||
                query.type == ChatroomType.purpose.rawValue
            }
        
        let unreadGroupCount = groupChatrooms.sum(of: \.unseenCount) as Int? ?? 0
        
        // Get unread count for DM chatrooms
        let loggedInUUID = UserPreferences.shared.getClientUUID()
        let loggedInMemberId = UserPreferences.shared.getLMMemberId()
      
        
        let unreadDMCount = realm.objects(ChatroomRO.self)
            .where { $0.type == ChatroomType.directMessage.rawValue }
            .where {
                $0.member.uuid == loggedInUUID ||
                $0.chatroomWithUserId == loggedInMemberId
            }
            .sum(of: \.unseenCount) as Int? ?? 0
        
        
        return GetUnreadConversationsCountResponse(
            unreadGroupChatroomConversations: unreadGroupCount,
            unreadDMChatroomConversations: unreadDMCount
        )
    }

}
