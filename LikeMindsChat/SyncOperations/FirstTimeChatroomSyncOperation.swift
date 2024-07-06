//
//  FirstTimeChatroomSyncOperation.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 04/01/24.
//

import Foundation


class FirstTimeChatroomSyncOperation {

    private var page: Int = 1
    private var pageSize: Int = 500
    private var maxTimestamp: Int = Int(Date().timeIntervalSince1970)
    private var minTimestamp: Int = SyncPreferences.shared.getTimestampForSyncChatroom()
    private var isSyncing: Bool = false
    
    private var chatroomTypes: [Int]
    private static let shared: FirstTimeChatroomSyncOperation = FirstTimeChatroomSyncOperation(chatroomTypes: [0, 7])
    
    static func sharedInstance(chatroomTypes: [Int] = [0, 7]) -> FirstTimeChatroomSyncOperation {
        shared.page = 1
        shared.chatroomTypes = chatroomTypes
        shared.maxTimestamp = Int(Date().timeIntervalSince1970)
        shared.minTimestamp = SyncPreferences.shared.getTimestampForSyncChatroom()
        return shared
    }
    
    init(chatroomTypes: [Int]) {
        self.chatroomTypes = chatroomTypes
    }
    
    func syncChatroomsData() {
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
            .minTimestamp(0)
            .maxTimestamp(maxTimestamp)
            .build()
        
        chatroomSyncRequest.minTimestamp = 0
        chatroomSyncRequest.maxTimestamp = maxTimestamp

        SyncPreferences.shared.setTimestampForSyncChatroom(time: chatroomSyncRequest.maxTimestamp)
        ChatroomClient.syncChatroomsApi(request: chatroomSyncRequest, moduleName: "FirstTimeChatroomSync") { [weak self] response in
            if let _ = response.errorMessage {
                self?.isSyncing = false
                print("Retry first time chatroom sync")
                // retry
            } else if let chatrooms = response.data?.chatrooms, chatrooms.isEmpty {
                self?.isSyncing = false
                return
            } else {
                guard let data = response.data else {
                    self?.isSyncing = false
                    return
                }
                SyncUtil.saveChatroomResponse(communityId: SDKPreferences.shared.getCommunityId() ?? "", loggedInUUID: UserPreferences.shared.getClientUUID() ?? "", data: data)
                SyncUtil.saveAppConfig(communityId: SDKPreferences.shared.getCommunityId() ?? "", isChatroomSynced: true)
                self?.page += 1
                self?.syncChatrooms()
            }
        }
    }
}

class FirstTimeDMChatroomSyncOperation {
    
    private var page: Int = 1
    private var pageSize: Int = 500
    private var maxTimestamp: Int = Int(Date().timeIntervalSince1970)
    private var minTimestamp: Int = SyncPreferences.shared.getTimestampForSyncDMChatroom()
    private var isSyncing: Bool = false
    
    private var chatroomTypes: [Int]
    private static let shared: FirstTimeDMChatroomSyncOperation = FirstTimeDMChatroomSyncOperation(chatroomTypes: [10])
    
    static func sharedInstance(chatroomTypes: [Int] = [10]) -> FirstTimeDMChatroomSyncOperation {
        shared.page = 1
        shared.chatroomTypes = chatroomTypes
        shared.maxTimestamp = Int(Date().timeIntervalSince1970)
        shared.minTimestamp = SyncPreferences.shared.getTimestampForSyncDMChatroom()
        return shared
    }
    
    private init(chatroomTypes: [Int]) {
        self.chatroomTypes = chatroomTypes
    }
    
    func syncChatroomsData() {
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
            .minTimestamp(0)
            .maxTimestamp(maxTimestamp)
            .build()
        
        SyncPreferences.shared.setTimestampForSyncDMChatroom(time: chatroomSyncRequest.maxTimestamp)
        ChatroomClient.syncChatroomsApi(request: chatroomSyncRequest, moduleName: "FirstTimeDMChatroomSync") { [weak self] response in
            if let _ = response.errorMessage {
                self?.isSyncing = false
                print("Retry first time dm chatroom sync")
                // retry
            } else if let chatrooms = response.data?.chatrooms, chatrooms.isEmpty {
                self?.isSyncing = false
                return
            } else {
                guard let data = response.data else {
                    self?.isSyncing = false
                    return
                }
                SyncUtil.saveChatroomResponse(communityId: SDKPreferences.shared.getCommunityId() ?? "", loggedInUUID: UserPreferences.shared.getClientUUID() ?? "", data: data)
                self?.page += 1
                self?.syncChatrooms()
            }
        }
    }
}
