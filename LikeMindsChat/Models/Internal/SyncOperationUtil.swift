//
//  SyncOperationUtil.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 24/01/24.
//

import Foundation

class SyncOperationUtil {
    
    static let chatroomTypes = [0, 7]
    
    static func startFirstHomeFeedSync(response: LMClientResponse<NoData>?) {
        let firstTimeSyncChatroomOperation = FirstTimeChatroomSyncOperation(chatroomTypes: chatroomTypes)
        firstTimeSyncChatroomOperation.completionBlock = {
            response?(LMResponse.successResponse(NoData()))
        }
        let queue = OperationQueue()
        queue.addOperation(firstTimeSyncChatroomOperation)
    }
    
    static func startReopenSyncForHomeFeed(response: LMClientResponse<NoData>?) {
        let reopenTimeSyncChatroomOperation = ReopenChatroomSyncOperation(chatroomTypes: chatroomTypes)
        reopenTimeSyncChatroomOperation.completionBlock = {
            response?(LMResponse.successResponse(NoData()))
        }
        let queue = OperationQueue()
        queue.addOperation(reopenTimeSyncChatroomOperation)
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
