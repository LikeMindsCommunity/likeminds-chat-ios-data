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
    
    func initialize() {
        
    }

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
    
    public func getHomeFeed(request: GetHomeFeedRequest, response: LMClientResponse<GetHomeFeedResponse>?) {
        
    }
    
    public func getExploreTabCount(response: LMClientResponse<GetExploreTabCountResponse>?) {
        HomeFeedClient.shared.getExploreTabCount(withModuleName: moduleName) { response in
            
        }
    }
    
    public func getExploreFeed(request: GetExploreFeedRequest, response: LMClientResponse<GetExploreFeedResponse>?) {
        
    }
    
    public func syncChatrooms() {
        HomeFeedClient.shared.syncChatrooms()
    }
    
    func getChatrooms(withObserver observer: HomeFeedClientObserver) {
        HomeFeedClient.shared.getChatrooms(withObserver: observer)
    }
    
    func getUser() {
        
    }
    
    func getMember() {
        
    }
    
    func getChatroom() {
        
    }
    
    func getChatroomActions() {
        
    }
    
    func followChatroom() {
        
    }
    
    func leaveSecretChatroom() {
        
    }
    
    func muteChatroom() {
        
    }
    
    func markReadChatroom() {
        
    }
    
    func setChatroomTopic() {
        
    }
    
    func getParticipants() {
        
    }
    
    func getReportTags() {
        
    }
    
    func postReport() {
        
    }
    
    func addPollOption() {
        
    }
    
    func submitPoll() {
        
    }
  
    func getPollUsers() {
        
    }
    
    func postPollConversation() {
        
    }
    
    func decodeUrl() {
        
    }
    
    func getTaggingList() {
        
    }
    
    func getDBEmpty() {
        
    }
    
    func searchChatroom() {
        
    }
    
    func searchConversation() {
        
    }
    
    func loadConversations() {
        
    }
    
    func getConversations() {
        
    }
    
    func getConversationsCount() {
        
    }
    
    func deleteConversationPermanatly() {
        
    }
    
    func updateConversation() {
        
    }
    
    func updateTemporaryConversation() {
        
    }
    
    func getConversation() {
        
    }
    
    func postConversation() {
        
    }
    
    func editConversation() {
        
    }
    
    func deleteConversations() {
        
    }
    
    func putReaction() {
        
    }
    
    func deleteReaction() {
        
    }
    
    func getUnreadConversationNotification() {
        
    }
    
    func putMultimedia() {
        
    }
    
    func updateLastSeenAndDraft() {
        
    }
    
    func editChatroomTitle() {
        
    }
    
    func savePostedConversation() {
        
    }
    
    func getContentDownloadSettings(_ response: LMClientResponse<GetContentDownloadSettingsResponse>?) {
        CommunityClient.shared.getContentDownloadSettings() { result in
            response?(result)
        }
    }
    
}
