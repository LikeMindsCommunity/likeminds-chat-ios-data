//
//  ReopenConversationSyncOperation.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 04/01/24.
//

import Foundation

class ReopenConversationSyncOperation: LMAsyncOperation {
    
    var chatroomId: Int = 0
    var page: Int = 1
    
    override private init() {
        
    }
    
    convenience init(chatroomId: Int) {
        self.init()
        self.chatroomId = chatroomId
    }
    
    func syncConversations() {
        let chatroomSyncRequest = ConversationSyncRequest.builder()
            .page(page)
            .chatroomId(chatroomId)
            .pageSize(500)
            .minTimestamp(0)
            .maxTimestamp(0)
            .build()
        ChatClientServiceRequest.syncConversations(request: chatroomSyncRequest, moduleName: "FirstTimeConversationSync") { response in
            
        }
    }
    
    override func main() {
        self.syncConversations()
    }
}
