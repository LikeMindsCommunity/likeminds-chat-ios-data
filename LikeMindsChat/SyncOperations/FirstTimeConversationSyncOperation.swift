//
//  FirstTimeConversationSyncOperation.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 04/01/24.
//

import Foundation

class FirstTimeConversationSyncOperation: LMAsyncOperation {
    
    var chatroomId: Int = 0
    private var maxTimestamp: Int = Int(Date().millisecondsSince1970)
    var page: Int = 1
    
    override private init() {
    }
    
    convenience init(chatroomId: Int) {
        self.init()
        self.chatroomId = chatroomId
    }
    
    func syncConversations() {
        
        let conversationSyncRequest = ConversationSyncRequest.builder()
            .page(page)
            .chatroomId(chatroomId)
            .pageSize(500)
            .minTimestamp(0)
            .maxTimestamp(maxTimestamp)
            .build()
        
        if page == 1 {
            conversationSyncRequest.minTimestamp = 0
            conversationSyncRequest.maxTimestamp = maxTimestamp
        } else {
            conversationSyncRequest.minTimestamp = SyncPreferences.shared.getTimestampForSyncConversation()
            conversationSyncRequest.maxTimestamp = Int(Date().millisecondsSince1970)
        }
        SyncPreferences.shared.setTimestampForSyncConversation(time: conversationSyncRequest.maxTimestamp ?? 0)
        ChatClientServiceRequest.syncConversations(request: conversationSyncRequest, moduleName: "FirstTimeConversationSync") { response in
            
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
                self.page += 1
                self.syncConversations()
            }
            
            
        }
    }
    
    override func main() {
        self.syncConversations()
    }
    
}
