//
//  SyncOperationUtil.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 24/01/24.
//

import Foundation

class SyncOperationUtil {
    
    static func startFirstHomeFeedSync(response: LMClientResponse<_SyncChatroomResponse_>) {
        let firstTimeSyncChatroomOperation = FirstTimeChatroomSyncOperation(chatroomTypes: [])
        let queue = OperationQueue()
        queue.addOperation(firstTimeSyncChatroomOperation)
    }
    
    static func startReopenSyncForHomeFeed(response: LMClientResponse<_SyncChatroomResponse_>) {
        let reopenTimeSyncChatroomOperation = ReopenChatroomSyncOperation(chatroomTypes: [])
        let queue = OperationQueue()
        queue.addOperation(reopenTimeSyncChatroomOperation)
    }
    
    static func startFirstTimeSyncConversations(chatroomId: String, response: LMClientResponse<_SyncConversationResponse_>) {
        let firstTimeSyncConversationOperation = FirstTimeConversationSyncOperation(chatroomId: chatroomId)
        let queue = OperationQueue()
        queue.addOperation(firstTimeSyncConversationOperation)
    }
    
    static func reopenSyncConversations(chatroomId: String, response: LMClientResponse<_SyncConversationResponse_>) {
        let reopenTimeSyncConversationOperation = ReopenConversationSyncOperation(chatroomId: chatroomId)
        let queue = OperationQueue()
        queue.addOperation(reopenTimeSyncConversationOperation)
    }
}
