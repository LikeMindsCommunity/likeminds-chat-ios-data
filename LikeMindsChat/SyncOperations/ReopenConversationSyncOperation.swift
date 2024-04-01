//
//  ReopenConversationSyncOperation.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 04/01/24.
//

import Foundation

class ReopenConversationSyncOperation: LMAsyncOperation {
    
    var chatroomId: String = ""
    
    var maxTimestamp: Int = Int(Date().millisecondsSince1970)
    var minTimestamp: Int = SyncPreferences.shared.getTimestampForSyncChatroom()
    var page: Int = 1
    
    override private init() {
        
    }
    
    convenience init(chatroomId: String) {
        self.init()
        self.chatroomId = chatroomId
    }
    
    func syncConversations() {
        
        let conversationSyncRequest = ConversationSyncRequest.builder()
            .page(page)
            .chatroomId(chatroomId)
            .pageSize(500)
            .minTimestamp(minTimestamp)
            .maxTimestamp(maxTimestamp)
            .build()
        
        SyncPreferences.shared.setTimestampForSyncConversation(time: conversationSyncRequest.maxTimestamp ?? 0)
        ConversationClient.syncConversationsApi(request: conversationSyncRequest, moduleName: "ReopenConversationSync") { response in
            
            if let _ = response.errorMessage {
                // retry
            } else if let chatrooms = response.data?.conversations, chatrooms.isEmpty {
                // No data but success
                return
            } else {
                guard let data = response.data else {
                    // retry flow
                    return
                }
                SyncUtil.saveConversationResponses(chatroomId: self.chatroomId, communityId: SDKPreferences.shared.getCommunityId() ?? "", loggedInUUID: UserPreferences.shared.getClientUUID() ?? "", dataList: [data])
                self.page += 1
                self.syncConversations()
            }
        }
    }
    
    override func main() {
        self.syncConversations()
    }
}
