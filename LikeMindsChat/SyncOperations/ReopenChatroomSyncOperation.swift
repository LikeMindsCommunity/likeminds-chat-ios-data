//
//  ReopenChatroomSyncOperation.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 04/01/24.
//

import Foundation

class ReopenChatroomSyncOperation {
    
    var page: Int = 1
    var pageSize: Int = 50
    var maxTimestamp: Int = Int(Date().timeIntervalSince1970)
    var minTimestamp: Int = SyncPreferences.shared.getTimestampForSyncChatroom()
    var isSyncing: Bool = false
    
    private var chatroomTypes: [Int]
    private static let shared: ReopenChatroomSyncOperation = ReopenChatroomSyncOperation(chatroomTypes: [0, 7])
    
    static func sharedInstance(chatroomTypes: [Int] = [0, 7]) -> ReopenChatroomSyncOperation {
        shared.page = 1
        shared.chatroomTypes = chatroomTypes
        shared.maxTimestamp = Int(Date().timeIntervalSince1970)
        shared.minTimestamp = SyncPreferences.shared.getTimestampForSyncChatroom()
        return shared
    }
    
    private init(chatroomTypes: [Int]) {
        self.chatroomTypes = chatroomTypes
    }
    
    func resyncChatrooms() {
        if !isSyncing {
            isSyncing = true
            syncChatrooms()
        }
    }
    
    private func syncChatrooms() {
        let chatroomSyncRequest = ChatroomSyncRequest.builder()
            .page(page)
            .pageSize(pageSize)
            .chatroomTypes(chatroomTypes)
            .minTimestamp(minTimestamp)
            .maxTimestamp(maxTimestamp)
            .build()
        
        SyncPreferences.shared.setTimestampForSyncChatroom(time: chatroomSyncRequest.maxTimestamp)
        ChatroomClient.syncChatroomsApi(request: chatroomSyncRequest, moduleName: "ReopenChatroomSync") { [weak self] response in
            if let _ = response.errorMessage {
                self?.isSyncing = false
                print("Retry reopen chatroom sync")
                // retry
            } else if let chatrooms = response.data?.chatrooms, chatrooms.isEmpty {
                self?.isSyncing = false
                return
            } else {
                guard let data = response.data else {
                    self?.isSyncing = false
                    return
                }
                SyncUtil.saveChatroomResponse(communityId: SDKPreferences.shared.getCommunityId() ?? "", loggedInUUID: "", data: data)
                self?.page += 1
                self?.syncChatrooms()
            }
        }
    }
}
