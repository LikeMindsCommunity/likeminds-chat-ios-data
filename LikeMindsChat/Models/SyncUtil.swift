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
    static func saveAppConfig(communityId: String) {
        if communityId.isEmpty { return }
        RealmManager.write { realm, object in
            let appConfig = ChatDBUtil.shared.getAppConfig(realm: realm)
            if let appConfig {
                let list = List<String>()
                list.append(communityId)
                appConfig.communities = list
            } else {
                // Add new object
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
                if let creator = data.userMeta?[creatorId],
                   let chatroomCreatorRO = ROConverter.convertMember(member: creator, communityId: communityId){
                    realm.insertOrUpdate(chatroomCreatorRO)
                } else { return }
                //last conversation
                let lastConversationId = chatroom.lastConversationId ?? ""
                if let lastConversation = data.conversationMeta?[lastConversationId] {
                    if let lastConversationDeletedById = lastConversation.deletedBy,
                       let lastConversationDeletedBy =
                        data.userMeta?["\(lastConversationDeletedById)"],
                       let lastConversationDeletedByMemberRO = ROConverter.convertMember(member: lastConversationDeletedBy, communityId: communityId) {
                        
                    }
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
            
        }
        
    }
    
}
