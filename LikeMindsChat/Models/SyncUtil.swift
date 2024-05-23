//
//  SyncUtil.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 07/01/24.
//

import Foundation
import RealmSwift

class SyncUtil {
    
    //Query letue
    static let CHATROOM_PAGE_SIZE = 50
    static let CONVERSATION_PAGE_SIZE = 500
    let CHATROOM_TYPE_LIST = [0, 7]
    
    //Query Key
    static let PAGE_KEY = "page"
    static let PAGE_SIZE_KEY = "page_size"
    static let MIN_TIMESTAMP_KEY = "min_timestamp"
    static let MAX_TIMESTAMP_KEY = "max_timestamp"
    static let CHATROOM_TYPES_KEY = "chatroom_types"
    static let CHATROOM_ID_KEY = "chatroom_id"
    static let CONVERSATION_ID_KEY = "conversation_id"
    
    static let TAG = "SyncWorker"
    
    
    //Stores App config data to DB
    static func saveAppConfig(communityId: String, isChatroomSynced: Bool? = nil, isConversationSynced: Bool? = nil) {
        if communityId.isEmpty { return }
        RealmManager.write { realm, object in
            let appConfig = ChatDBUtil.shared.getAppConfig(realm: realm)
            if let appConfig {
                let list = List<String>()
                list.append(communityId)
                appConfig.communities = list
                if let isChatroomSynced {
                    appConfig.isChatroomsSynced = isChatroomSynced
                }
                if let isConversationSynced {
                    appConfig.isConversationsSynced = isConversationSynced
                }
            } else {
                let appConfigRO = AppConfigRO()
                let list = List<String>()
                list.append(objectsIn: [communityId])
                appConfigRO.communities = list
                appConfigRO.isCommunitiesSynced = true
                if let isChatroomSynced {
                    appConfigRO.isChatroomsSynced = isChatroomSynced
                }
                if let isConversationSynced {
                    appConfigRO.isConversationsSynced = isConversationSynced
                }
                realm.insertOrUpdate(appConfigRO)
            }
        }
    }
    
    // Stores chatroom data to DB
    static func saveChatroomResponse(communityId: String,
                              loggedInUUID: String,
                              data: _SyncChatroomResponse_
    ) {
        let chatrooms = data.chatrooms
        RealmManager.write { realm, object in
            let community = data.communityMeta?[communityId]
            if let communityRO = ROConverter.convertCommunity(community) {
                communityRO.relationshipNeeded = true
                //Save community
                realm.insertOrUpdate(communityRO)
            }
            
            chatrooms?.forEach({ chatroom in
                //chatroom creator
                let creatorId = "\(chatroom.userId ?? "")"
                var chatroomCreatorRO: MemberRO?
                if let creator = data.userMeta?[creatorId],
                   let chatroomCreatorRo = ROConverter.convertMember(member: creator, communityId: communityId){
                    chatroomCreatorRO = chatroomCreatorRo
                    realm.insertOrUpdate(chatroomCreatorRo)
                } else { return }
                //isConversation Deleted
                let lastConversationId = chatroom.lastConversationId ?? ""
                if let lastConversation = data.conversationMeta?[lastConversationId] {
                    // Delete conversation
                    var lastConversationDeletedByMemberRO:MemberRO?
                    if let lastConversationDeletedById = lastConversation.deletedBy,
                       let lastConversationDeletedBy =
                        data.userMeta?["\(lastConversationDeletedById)"],
                       let lastConversationDeletedByMemRO = ROConverter.convertMember(member: lastConversationDeletedBy, communityId: communityId) {
                        lastConversationDeletedByMemberRO = lastConversationDeletedByMemRO
                    }
                    // Poll check
                    if ConversationState.isPoll(stateValue: lastConversation.state) {
                        var polls = data.conversationPollMeta?[lastConversationId] ?? []
                        polls.sort(by: { ($0.id ?? "0") < ($1.id ?? "0")})
                    }
                    //attachments
                    var lastConversationAttachment: [Attachment]?
                    if lastConversation.attachmentUploaded == true && (lastConversation.attachmentCount ?? 0) > 0 {
                        lastConversationAttachment = data.conversationAttachementMeta?[lastConversationId]
                    }
                    
                    //last conversation creator
                    var lastConversationCreatorRO:MemberRO?
                    if let lastConversationCreatorId = lastConversation.memberId {
                        let lastConversationCreator =
                        data.userMeta?[lastConversationCreatorId]
                        lastConversationCreatorRO =
                        ROConverter.convertMember(member: lastConversationCreator, communityId: communityId)
                    }
                    guard let lastConversationRO = ROConverter.convertLastConversation(
                        realm: realm,
                        conversation: lastConversation,
                        creator: lastConversationCreatorRO,
                        attachments: lastConversationAttachment,
                        deletedByMember: lastConversationDeletedByMemberRO
                    ), let lastConversationCreatorRO else { return }
                    
                    realm.insertOrUpdate(lastConversationRO)
                    realm.insertOrUpdate(lastConversationCreatorRO)
                    
                    //chatroom topic
                    if let topicId = chatroom.topicId,
                       let topic = data.conversationMeta?[topicId] {
                        let topicCreator = data.userMeta?[topic.memberId ?? ""]
                        let topicCreatorRO =
                        ROConverter.convertMember(member: topicCreator, communityId: communityId)
                        
                        //isConversation Deleted
                        var topicConversationDeletedByMemberRO: MemberRO?
                        if let deletedBy = topic.deletedBy,
                           let topicConversationDeletedBy =
                            data.userMeta?[deletedBy] {
                            topicConversationDeletedByMemberRO = ROConverter.convertMember(member: topicConversationDeletedBy, communityId: communityId)
                        }
                        
                        //topic poll check
                        var topicConversationPolls: [Poll] = []
                        if ConversationState.isPoll(stateValue: topic.state) {
                            let list = data.conversationPollMeta?[topicId] ?? []
                            // TODO: member object assignment
//                            list.compactMap { poll in
//                                    let userId = poll.userId
//                                    let user = data.userMeta?[userId]
//                                    poll.toBuilder().member(user).build()
//                                }
                            topicConversationPolls = list
                        }
                        
                        //topic attachments
                        var topicConversationAttachments: [Attachment] = []
                        if (topic.attachmentUploaded == true && (topic.attachmentCount ?? 0) > 0),
                           let attatchmentsData = data.conversationAttachementMeta?[topicId] {
                            topicConversationAttachments = attatchmentsData
                        }
                        
                        let topicRO = ROConverter.convertConversation(
                            realm: realm,
                            conversation: topic,
                            creator: topicCreatorRO,
                            polls: topicConversationPolls,
                            attachments: topicConversationAttachments,
                            reactions: nil,
                            loggedInUUID: loggedInUUID,
                            deletedByMemberRO: topicConversationDeletedByMemberRO
                        )
                        if let topicCreatorRO {
                            realm.insertOrUpdate(topicCreatorRO)
                        }
                        if let topicRO {
                            realm.insertOrUpdate(topicRO)
                        }
                    }
                    
                    //last seen conversation
                    if let lastSeenConversationId = chatroom.lastSeenConversationId,
                       let lastSeenConversation =
                        data.conversationMeta?[lastSeenConversationId] {
                        
                        let lastSeenConversationCreator =
                        data.userMeta?[lastSeenConversation.memberId ?? ""]
                        let lastSeenConversationCreatorRO = ROConverter.convertMember(
                            member: lastSeenConversationCreator,
                            communityId: communityId
                        )
                        var lastSeenConversationDeletedByMemberRO: MemberRO?
                        if let lastSeenConversationDeletedById = lastSeenConversation.deletedBy,
                           let lastSeenConversationDeletedBy =
                            data.userMeta?[lastSeenConversationDeletedById] {
                            lastSeenConversationDeletedByMemberRO = ROConverter.convertMember(member: lastSeenConversationDeletedBy, communityId: communityId)
                        }
                        
                        //last seen poll check
                        var lastSeenConversationPolls: [Poll] = []
                        if (ConversationState.isPoll(stateValue: lastSeenConversation.state)) {
                            let list =
                            data.conversationPollMeta?[lastSeenConversationId] ?? []
                            // TODO: member object assignment
//                            list.compactMap { poll in
//                                    let userId = poll.userId
//                                    let user = data.userMeta?[userId]
//                                    poll.toBuilder().member(user).build()
//                                }
                            lastSeenConversationPolls = list
                        }
                        
                        //last seen attachments
                        var lastSeenConversationAttachments: [Attachment] = []
                        if (lastSeenConversation.attachmentUploaded == true
                            && (lastSeenConversation.attachmentCount ?? 0) > 0
                        ) {
                            lastSeenConversationAttachments = data.conversationAttachementMeta?[lastSeenConversationId] ?? []
                        }
                        let lastSeenConversationRO = ROConverter.convertConversation(
                            realm: realm,
                            conversation: lastSeenConversation,
                            creator: lastSeenConversationCreatorRO,
                            polls: lastSeenConversationPolls,
                            attachments: lastSeenConversationAttachments,
                            reactions: nil,
                            loggedInUUID: loggedInUUID,
                            deletedByMemberRO: lastSeenConversationDeletedByMemberRO
                        )
                        if let lastSeenConversationRO {
                            realm.insertOrUpdate(lastSeenConversationRO)
                        }
                        if let lastSeenConversationCreatorRO {
                            realm.insertOrUpdate(lastSeenConversationCreatorRO)
                        }
                    }
                    
                    //convert chatroom
                    guard let chatroomCreatorRO,
                        let chatroomRO = ROConverter.convertChatroom(
                        fromChatroomJsonModel: chatroom,
                        chatroomCreatorRO: chatroomCreatorRO,
                        lastConversationRO: lastConversationRO
                    ) else { return }
                    chatroomRO.relationshipNeeded = true
                    realm.insertOrUpdate(chatroomRO)
                }
            })
        }
    }
    
    // Stores conversation data to DB
    static func saveConversationResponses(chatroomId: String,
                                   communityId: String,
                                   loggedInUUID: String,
                                   dataList: [_SyncConversationResponse_]
    ) {
        RealmManager.write { realm, object in
            
            dataList.forEach { data in
                //fetch community
                guard let community = data.communityMeta?[communityId],
                      let communityRO = ROConverter.convertCommunity(community) else { return }
                communityRO.relationshipNeeded = true
                realm.insertOrUpdate(communityRO)
                
                //fetch chatroom & creator
                guard let chatroom = data.chatRoomMeta?[chatroomId],
                      let chatroomCreatorId = chatroom.userId,
                      let chatroomCreator = data.userMeta?[chatroomCreatorId],
                let chatroomCreatorRO =
                ROConverter.convertMember(member: chatroomCreator, communityId: communityId) else { return }
                realm.insertOrUpdate(chatroomCreatorRO)
                
                //reactions
                var chatroomReactions: [ReactionMeta] = []
                if (chatroom.hasReactions == true) {
                    let list = data.chatroomReactionsMeta?[chatroomId] ?? []
                    chatroomReactions = list.compactMap { reaction in
                        var reactionMeta = reaction
                        let userId = reaction.userId ?? 0
                        let user = data.userMeta?["\(userId)"]
                        reactionMeta.member = user
                        return reactionMeta
                    }
                }
                
                guard let chatroomRO = ROConverter.convertChatroom(
                    fromChatroomJsonModel: chatroom,
                    chatroomCreatorRO: chatroomCreatorRO,
                    reactions: chatroomReactions
                ) else { return }
                chatroomRO.relationshipNeeded = true
                chatroomRO.isConversationStored
                realm.insertOrUpdate(chatroomRO)
                
                data.conversations?.forEach({ conversation in
                    //conversation creator
                    guard let id = conversation.id,
                    let creatorId = conversation.memberId,
                        let creator = data.userMeta?[creatorId],
                        let creatorRO = ROConverter.convertMember(member: creator, communityId: communityId) else { return }
                    realm.insertOrUpdate(creatorRO)
                    var deletedByMemberRO: MemberRO?
                    if let deletedById = conversation.deletedBy,
                       let deletedByMember =
                        data.userMeta?[deletedById] {
                        deletedByMemberRO = ROConverter.convertMember(member: deletedByMember, communityId: communityId)
                    }
                    
                    //reactions
                    var reactions: [ReactionMeta] = []
                    if (conversation.hasReactions == true) {
                        let list = data.conversationReactionsMeta?[id] ?? []
                        reactions = list.compactMap { reaction in
                            var reactionMeta = reaction
                            let userId = "\(reaction.userId ?? 0)"
                            let user = data.userMeta?[userId]
                            reactionMeta.member = user
                            return reactionMeta
                        }
                    }
                    
                    //polls
                    var conversationPolls: [Poll] = []
                    if (ConversationState.isPoll(stateValue: conversation.state)) {
                        let list = data.conversationPollMeta?[id] ?? []
                        // TODO: conversation poll users
//                        list.sortedBy { it.id }
//                            .map { poll ->
//                                val userId = poll.userId
//                                val user = data.userMeta[userId]
//                                poll.toBuilder().member(user).build()
//                            }
                        conversationPolls = list
                    }
                    
                    //attachment
                    var conversationAttachment: [Attachment] = []
                    if (conversation.attachmentUploaded == true &&
                        (conversation.attachmentCount ?? 0) > 0
                    ) {
                        conversationAttachment = data.conversationAttachmentsMeta?[id] ?? []
                    }
                    
                    guard let conversationRO =
                    ROConverter.convertConversation(
                        realm: realm,
                        conversation: conversation,
                        creator: creatorRO,
                        polls: conversationPolls,
                        attachments: conversationAttachment,
                        reactions: reactions,
                        loggedInUUID: loggedInUUID,
                        deletedByMemberRO: deletedByMemberRO
                    ) else { return }
                    
                    realm.insertOrUpdate(
                        conversationRO
                    )
                })
            }
        }
        
    }
}
