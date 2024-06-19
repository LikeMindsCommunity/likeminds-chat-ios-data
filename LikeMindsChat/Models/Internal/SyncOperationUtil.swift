//
//  SyncOperationUtil.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 24/01/24.
//

import Foundation

class SyncOperationUtil {
        
    static func startFirstHomeFeedSync(response: LMClientResponse<NoData>?, chatroomTypes: [Int]) {
        let firstTimeSyncChatroomOperation = FirstTimeChatroomSyncOperation(chatroomTypes: chatroomTypes)
        firstTimeSyncChatroomOperation.completionBlock = {
            response?(LMResponse.successResponse(NoData()))
        }
        let queue = OperationQueue()
        queue.addOperation(firstTimeSyncChatroomOperation)
    }
    
    static func startReopenSyncForHomeFeed(response: LMClientResponse<NoData>?, chatroomTypes: [Int]) {
        ReopenChatroomSyncOperation.sharedInstance(chatroomTypes: chatroomTypes).resyncChatrooms()
    }
    
    static func startFirstTimeSyncConversations(chatroomId: String, response: LMClientResponse<NoData>?) {
        let firstTimeSyncConversationOperation = FirstTimeConversationSyncOperation(chatroomId: chatroomId)
        firstTimeSyncConversationOperation.completionBlock = {
            response?(LMResponse.successResponse(NoData()))
        }
        let queue = OperationQueue()
        queue.addOperation(firstTimeSyncConversationOperation)
    }
    
    static func reopenSyncConversations(chatroomId: String, response: LMClientResponse<NoData>?) {
        let reopenTimeSyncConversationOperation = ReopenConversationSyncOperation(chatroomId: chatroomId)
        reopenTimeSyncConversationOperation.completionBlock = {
            response?(LMResponse.successResponse(NoData()))
        }
        let queue = OperationQueue()
        queue.addOperation(reopenTimeSyncConversationOperation)
    }
}
