//
//  FirstTimeChatroomSyncOperation.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 04/01/24.
//

import Foundation


class FirstTimeChatroomSyncOperation: LMAsyncOperation {
    
    var page: Int = 1
    
    func syncChatrooms() {
        let chatroomSyncRequest = ChatroomSyncRequest.builder()
            .page(page)
            .pageSize(50)
            .chatroomTypes([])
            .minTimestamp(0)
            .maxTimestamp(0)
            .build()
        ChatClientServiceRequest.syncChatrooms(request: chatroomSyncRequest, moduleName: "FirstTimeChatroomSync") { response in
            
        }
    }
    
    override func main() {
        self.syncChatrooms()
    }
    
}
