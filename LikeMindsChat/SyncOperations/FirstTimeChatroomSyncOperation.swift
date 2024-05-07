//
//  FirstTimeChatroomSyncOperation.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 04/01/24.
//

import Foundation


class FirstTimeChatroomSyncOperation: LMAsyncOperation {
    
    private var page: Int = 1
    private var maxTimestamp: Int = Int(Date().timeIntervalSince1970)
    private var chatroomTypes: [Int]
    private var pageSize = 500
    
    init(chatroomTypes: [Int]) {
        self.chatroomTypes = chatroomTypes
    }
    
    func syncChatrooms() {
        let chatroomSyncRequest = ChatroomSyncRequest.builder()
            .page(page)
            .pageSize(pageSize)
            .chatroomTypes(chatroomTypes)
            .minTimestamp(0)
            .maxTimestamp(maxTimestamp)
            .build()
        
        chatroomSyncRequest.minTimestamp = 0
        chatroomSyncRequest.maxTimestamp = maxTimestamp

        SyncPreferences.shared.setTimestampForSyncChatroom(time: chatroomSyncRequest.maxTimestamp)
        ChatroomClient.syncChatroomsApi(request: chatroomSyncRequest, moduleName: "FirstTimeChatroomSync") { [weak self] response in
            if let _ = response.errorMessage {
                print("Retry first time chatroom sync")
              // retry
            } else if let chatrooms = response.data?.chatrooms, chatrooms.isEmpty {
              // No data but success
                return
            } else {
                guard let data = response.data else {
                    // retry flow
                    return
                }
                SyncUtil.saveChatroomResponse(communityId: SDKPreferences.shared.getCommunityId() ?? "", loggedInUUID: UserPreferences.shared.getClientUUID() ?? "", data: data)
                SyncUtil.saveAppConfig(communityId: SDKPreferences.shared.getCommunityId() ?? "", isChatroomSynced: true)
                self?.page += 1
                self?.syncChatrooms()
            }
        }
    }
    
    override func main() {
        self.syncChatrooms()
    }
    
}
