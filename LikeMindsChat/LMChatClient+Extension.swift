//
//  LMChatClient+Extension.swift
//  LMFeed
//
//  Created by Pushpendra Singh on 24/02/23.
//

import Foundation
import UIKit

//public typealias LMClientResponse<T> = (LMResponse<T>) -> (Void)

extension LMChatClient {
    
    func initialize() {}

    public func initiateUser(request: InitiateUserRequest, response: LMClientResponse<InitiateUserResponse>?) {
        InitiateUserClient.initiateChatService(request, withModuleName: moduleName) { result in
            if result.success {
//                self.syncChatrooms()
            }
            response?(result)
        }
    }

    public func registerDevice(request: RegisterDeviceRequest, response: LMClientResponse<RegisterDeviceResponse>?) {
        InitiateUserClient.registerDevice(request: request, withModuleName: moduleName) { result in
            response?(result)
        }
    }
    
    public func logout(request: LogoutRequest, response: LMClientResponse<NoData>?) {
        InitiateUserClient.logout(request: request, withModuleName: moduleName) { result in
            response?(result)
        }
    }
    
    public func getConfig(response: LMClientResponse<ConfigResponse>?) {
        InitiateUserClient.getConfig(withModuleName: moduleName) { result in
            response?(result)
        }
    }
    
    public func getExploreTabCount(response: LMClientResponse<GetExploreTabCountResponse>?) {
        HomeFeedClient.shared.getExploreTabCount(withModuleName: moduleName) { result in
            response?(result)
        }
    }
    
    public func getExploreFeed(request: GetExploreFeedRequest, response: LMClientResponse<GetExploreFeedResponse>?) {
        ExplorerFeedClient.shared.getExploreFeed(getExploreFeedRequest: request) { result in
            response?(result)
        }
    }
    
    public func syncChatrooms() {
        HomeFeedClient.shared.syncChatrooms()
    }

    public func getChatrooms(withObserver observer: HomeFeedClientObserver) {
        HomeFeedClient.shared.getChatrooms(withObserver: observer)
    }
    
    public func getParticipants(request: GetParticipantsRequest, response: LMClientResponse<GetParticipantsResponse>?) {
        ChatroomClient.shared.getParticipants(request: request) { result in
            response?(result)
        }
    }
    
    public func getReportTags(request: GetReportTagsRequest, response: LMClientResponse<GetReportTagsResponse>?) {
        ReportClient.shared.getReportTags(request: request) { result in
            response?(result)
        }
    }
    
    public func postReport(request: PostReportRequest, response: LMClientResponse<NoData>?) {
        ReportClient.shared.postReport(request: request) { result in
            response?(result)
        }
    }
    
    
    public func getContentDownloadSettings(_ response: LMClientResponse<GetContentDownloadSettingsResponse>?) {
        CommunityClient.shared.getContentDownloadSettings() { result in
            response?(result)
        }
    }
    
    
    public func getHomeFeed(request: GetHomeFeedRequest, response: LMClientResponse<GetHomeFeedResponse>?) {
        
    }
    
    
    public func getUser() {
        
    }
    
    public func getMember() {
        
    }
    
    public func getChatroom(request: GetChatroomRequest, response: LMClientResponse<GetChatroomResponse>?) {
        ChatroomClient.shared.getChatroom(request: request) { result in
            response?(result)
        }
    }
    
    public func getChatroomActions() {
        
    }
    
    public func followChatroom() {
        
    }
    
    public func leaveSecretChatroom() {
        
    }
    
    public func muteChatroom() {
        
    }
    
    func markReadChatroom() {
        
    }
    
    public func setChatroomTopic() {
        
    }
    
    public func addPollOption() {
        
    }
    
    public func submitPoll() {
        
    }
  
    public func getPollUsers() {
        
    }
    
    public func postPollConversation() {
        
    }
    
    public func decodeUrl(request: DecodeUrlRequest, response: LMClientResponse<DecodeUrlResponse>?) {
        ConversationClient.shared.decodeUrl(request: request) { result in
            response?(result)
        }
    }
    
    public func getTaggingList(request: GetTaggingListRequest, response: LMClientResponse<GetTaggingListResponse>?) {
        ConversationClient.shared.getTaggingList(request: request) { result in
            response?(result)
        }
    }
    
    public func getDBEmpty() {
        
    }
    
    public func searchChatroom() {
        
    }
    
    public func searchConversation() {
        
    }
    
    public func loadConversations(withChatroomId chatroomId: String, loadType: LoadConversationType) {
        ConversationClient.shared.loadConversations(type: loadType, chatroomId: chatroomId)
    }
    
    public func getConversations(withRequest request: GetConversationsRequest) {
        ConversationClient.shared.getConversations(request: request) { response in }
    }
    
    public func getConversationsCount() {
        
    }
    
    public func deleteConversationPermanatly() {
        
    }
    
    public func updateConversation() {
        
    }
    
    public func updateTemporaryConversation() {
        
    }
    
    public func getConversation() {
        
    }
    
    public func postConversation(request: PostConversationRequest, response: LMClientResponse<PostConversationResponse>?) {
        ConversationClient.shared.postConversation(request: request) { result in
            response?(result)
        }
    }
    
    public func editConversation(request: EditConversationRequest, response: LMClientResponse<EditConversationResponse>?) {
        ConversationClient.shared.editConversation(request: request) { result in
            response?(result)
        }
    }
    
    public func deleteConversations(request: DeleteConversationsRequest, response: LMClientResponse<DeleteConversationsResponse>?) {
        ConversationClient.shared.deleteConversations(request: request) { result in
            response?(result)
        }
    }
    
    public func putReaction(request: PutReactionRequest, response: LMClientResponse<NoData>?) {
        ConversationClient.shared.putReaction(request: request) { result in
            response?(result)
        }
    }
    
    public func deleteReaction(request: DeleteReactionRequest, response: LMClientResponse<NoData>?) {
        ConversationClient.shared.deleteReaction(request: request) { result in
            response?(result)
        }
    }
    
    public func getUnreadConversationNotification() {
        
    }
    
    public func putMultimedia() {
        
    }
    
    public func updateLastSeenAndDraft() {
        
    }
    
    public func editChatroomTitle() {
        
    }
    
    public func savePostedConversation() {
        
    }
    
}
