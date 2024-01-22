//
//  ReopenChatroomSyncOperation.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 04/01/24.
//

import Foundation

class ReopenChatroomSyncOperation: LMAsyncOperation {
    
    var page: Int = 1
    var maxTimestamp: Int = Int(Date().millisecondsSince1970)
    var minTimestamp: Int = 0
    
    func syncChatrooms() {
        let chatroomSyncRequest = ChatroomSyncRequest.builder()
            .page(page)
            .pageSize(50)
            .chatroomTypes([])
            .minTimestamp(minTimestamp)
            .maxTimestamp(maxTimestamp)
            .build()
        ChatroomClient.syncChatrooms(request: chatroomSyncRequest, moduleName: "FirstTimeChatroomSync") { response in
            if let error = response.errorMessage {
                // retry
            } else if let chatrooms = response.data?.chatrooms, chatrooms.isEmpty {
                // No data but success
            } else {
                
            }
        }
    }
    
    override func main() {
        self.syncChatrooms()
    }
    
}
