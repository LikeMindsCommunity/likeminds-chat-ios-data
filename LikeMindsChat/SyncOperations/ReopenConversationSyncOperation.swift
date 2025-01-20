//
//  ReopenConversationSyncOperation.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 04/01/24.
//

import Foundation

class ReopenConversationSyncOperation: LMAsyncOperation {
    var chatroomId: String = ""
    var maxTimestamp: Int = Int(Date().millisecondsSince1970)
    var minTimestamp: Int = SyncPreferences.shared
        .getTimestampForSyncConversation()
    var page: Int = 1
    var syncConversationsData:[_SyncConversationResponse_] = []
    override private init() {

    }

    convenience init(chatroomId: String) {
        self.init()
        self.chatroomId = chatroomId
    }

    func syncConversations() {

        let conversationSyncRequest = ConversationSyncRequest.builder()
            .page(page)
            .chatroomId(chatroomId)
            .pageSize(500)
            .minTimestamp(minTimestamp)
            .maxTimestamp(maxTimestamp)
            .build()

        SyncPreferences.shared.setTimestampForSyncConversation(
            time: conversationSyncRequest.maxTimestamp ?? 0)
        ConversationClient.syncConversationsApi(
            request: conversationSyncRequest,
            moduleName: "ReopenConversationSync"
        ) { response in

            if response.errorMessage != nil {
                // retry
            } else if let chatrooms = response.data?.conversations,
                chatrooms.isEmpty
            {
                SyncUtil.saveConversationResponses(
                    chatroomId: self.chatroomId,
                    communityId: SDKPreferences.shared.getCommunityId() ?? "",
                    loggedInUUID: UserPreferences.shared.getClientUUID() ?? "",
                    dataList: self.syncConversationsData)
                NotificationCenter.default.post(
                    name: .conversationSyncCompleted, object: nil)
                return
            } else {
                guard let data = response.data else {
                    // retry flow
                    return
                }
                if self.page == 1 {
                    SyncUtil.saveConversationResponses(
                        chatroomId: self.chatroomId,
                        communityId: SDKPreferences.shared.getCommunityId()
                            ?? "",
                        loggedInUUID: UserPreferences.shared.getClientUUID()
                            ?? "", dataList: [data])
                } else {
                    self.syncConversationsData.append(data)
                }
                self.page += 1
                self.syncConversations()
            }
        }
    }

    override func main() {
        self.syncConversations()
    }
}
