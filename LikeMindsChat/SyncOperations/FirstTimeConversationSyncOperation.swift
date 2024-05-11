//
//  FirstTimeConversationSyncOperation.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 04/01/24.
//

import Foundation

class FirstTimeConversationSyncOperation: LMAsyncOperation {
    
    var chatroomId: String = ""
    private var maxTimestamp: Int = Int(Date().millisecondsSince1970)
    var page: Int = 1
    var syncConversationsData: [_SyncConversationResponse_] = []
    
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
            .pageSize(100)
            .minTimestamp(0)
            .maxTimestamp(maxTimestamp)
            .build()
        
        conversationSyncRequest.minTimestamp = 0
        conversationSyncRequest.maxTimestamp = maxTimestamp
        
        SyncPreferences.shared.setTimestampForSyncConversation(time: conversationSyncRequest.maxTimestamp ?? 0)
        ConversationClient.syncConversationsApi(request: conversationSyncRequest, moduleName: "FirstTimeConversationSync") { response in
            
            if let _ = response.errorMessage {
                // retry
            } else if let chatrooms = response.data?.conversations, chatrooms.isEmpty {
                SyncUtil.saveConversationResponses(chatroomId: self.chatroomId, communityId: SDKPreferences.shared.getCommunityId() ?? "", loggedInUUID: UserPreferences.shared.getClientUUID() ?? "", dataList: self.syncConversationsData)
                SyncUtil.saveAppConfig(communityId: SDKPreferences.shared.getCommunityId() ?? "", isConversationSynced: true)
                return
            } else {
                guard let data = response.data else {
                    // retry flow
                    return
                }
                if self.page == 1 {
                    SyncUtil.saveConversationResponses(chatroomId: self.chatroomId, communityId: SDKPreferences.shared.getCommunityId() ?? "", loggedInUUID: UserPreferences.shared.getClientUUID() ?? "", dataList: [data])
                    SyncUtil.saveAppConfig(communityId: SDKPreferences.shared.getCommunityId() ?? "", isConversationSynced: true)
                } else {
                    self.syncConversationsData.append(data)
                }
                self.page += 1
                self.syncConversations()
            }
        }
    }
    
    override func main() {
        self.syncConversations()
    }
    
}
