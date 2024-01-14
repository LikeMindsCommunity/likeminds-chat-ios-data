//
//  FirstTimeChatroomSyncOperation.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 04/01/24.
//

import Foundation


class FirstTimeChatroomSyncOperation: LMAsyncOperation {
    
    private var page: Int = 1
    private var maxTimestamp: Int = Int(Date().millisecondsSince1970)
    private var chatroomTypes: [Int]
    
    init(chatroomTypes: [Int]) {
        self.chatroomTypes = chatroomTypes
    }
    
    func syncChatrooms() {
        
        let chatroomSyncRequest = ChatroomSyncRequest.builder()
            .page(page)
            .pageSize(50)
            .chatroomTypes(chatroomTypes)
            .minTimestamp(0)
            .maxTimestamp(maxTimestamp)
            .build()
        
        if page == 1 {
            chatroomSyncRequest.minTimestamp = 0
            chatroomSyncRequest.maxTimestamp = maxTimestamp
        } else {
            chatroomSyncRequest.minTimestamp = SyncPreferences.shared.getTimestampForSyncChatroom()
            chatroomSyncRequest.maxTimestamp = Int(Date().millisecondsSince1970)
        }
        SyncPreferences.shared.setTimestampForSyncChatroom(time: chatroomSyncRequest.maxTimestamp)
        ChatClientServiceRequest.syncChatrooms(request: chatroomSyncRequest, moduleName: "FirstTimeChatroomSync") { response in
            if let _ = response.errorMessage {
              // retry
            } else if let chatrooms = response.data?.chatrooms, chatrooms.isEmpty {
              // No data but success
                return
            } else {
                guard let data = response.data else {
                    // retry flow
                    return
                }
                SyncUtil.saveAppConfig(communityId: SDKPreferences.shared.getCommunityId() ?? "")
                SyncUtil.saveChatroomResponse(communityId: SDKPreferences.shared.getCommunityId() ?? "", loggedInUUID: "", data: data)
                self.page += 1
                self.syncChatrooms()
            }
        }
    }
    
    override func main() {
        self.syncChatrooms()
    }
    
}
