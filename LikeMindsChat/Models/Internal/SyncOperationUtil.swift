//
//  SyncOperationUtil.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 24/01/24.
//

import Foundation

class SyncOperationUtil {
    
    static func startFirstHomeFeedSync(response: _LMClientResponse_<_SyncChatroomResponse_>) {
        let firstTimeSyncChatroomOperation = FirstTimeChatroomSyncOperation(chatroomTypes: [])
        let queue = OperationQueue()
        queue.addOperation(firstTimeSyncChatroomOperation)
    }
    
    static func startReopenSyncForHomeFeed(response: _LMClientResponse_<_SyncChatroomResponse_>) {
        let reopenTimeSyncChatroomOperation = ReopenChatroomSyncOperation(chatroomTypes: [])
        let queue = OperationQueue()
        queue.addOperation(reopenTimeSyncChatroomOperation)
    }
    
    static func startFirstTimeSyncForChatroom(chatroomId: String, response: _LMClientResponse_<_SyncConversationResponse_>) {
        let firstTimeSyncConversationOperation = FirstTimeConversationSyncOperation(chatroomId: chatroomId)
        let queue = OperationQueue()
        queue.addOperation(firstTimeSyncConversationOperation)
    }
    
    static func startReopenSyncForChatroom(chatroomId: String, response: _LMClientResponse_<_SyncConversationResponse_>) {
        let reopenTimeSyncConversationOperation = ReopenConversationSyncOperation(chatroomId: chatroomId)
        let queue = OperationQueue()
        queue.addOperation(reopenTimeSyncConversationOperation)
    }
}