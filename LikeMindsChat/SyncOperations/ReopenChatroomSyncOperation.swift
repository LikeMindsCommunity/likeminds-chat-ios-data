//
//  ReopenChatroomSyncOperation.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 04/01/24.
//

import Foundation

class ReopenChatroomSyncOperation: LMAsyncOperation {
    
    var page: Int = 1
    var maxTimestamp: Int = Int(Date().timeIntervalSince1970)
    var minTimestamp: Int = SyncPreferences.shared.getTimestampForSyncChatroom()
    private var chatroomTypes: [Int]
    
    init(chatroomTypes: [Int]) {
        self.chatroomTypes = chatroomTypes
    }
    
    func syncChatrooms() {
        let chatroomSyncRequest = ChatroomSyncRequest.builder()
            .page(page)
            .pageSize(50)
            .chatroomTypes(chatroomTypes)
            .minTimestamp(minTimestamp)
            .maxTimestamp(maxTimestamp)
            .build()
        
        SyncPreferences.shared.setTimestampForSyncChatroom(time: chatroomSyncRequest.maxTimestamp)
        ChatroomClient.syncChatroomsApi(request: chatroomSyncRequest, moduleName: "ReopenChatroomSync") { [weak self] response in
            if let _ = response.errorMessage {
                print("Retry reopen chatroom sync")
                // retry
            } else if let chatrooms = response.data?.chatrooms, chatrooms.isEmpty {
                // No data but success
                return
            } else {
                guard let data = response.data else {
                    // retry flow
                    return
                }
                SyncUtil.saveChatroomResponse(communityId: SDKPreferences.shared.getCommunityId() ?? "", loggedInUUID: "", data: data)
                self?.page += 1
                self?.syncChatrooms()
            }
        }
    }
    
    override func main() {
        self.syncChatrooms()
    }
    
}
