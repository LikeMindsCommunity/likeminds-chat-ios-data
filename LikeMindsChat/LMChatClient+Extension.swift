//
//  LMChatClient+Extension.swift
//  LMChat
//
//  Created by Pushpendra Singh on 24/02/23.
//

import Foundation
import UIKit

//public typealias LMClientResponse<T> = (LMResponse<T>) -> (Void)

extension LMChatClient {
    
    func initialize() {}
    
    /// Initiates the chat service for a user by sending a request to the server.
    ///
    /// - Parameters:
    ///   - request: An InitiateUserRequest object containing the necessary information to initiate the chat service
    ///   - moduleName: A string identifying the module making the request (for logging/tracking)
    ///   - response: An optional closure to handle the server response
    public func initiateUser(request: InitiateUserRequest, response: LMClientResponse<InitiateUserResponse>?) {
        InitiateUserClient.initiateChatService(request, withModuleName: moduleName) { result in
            response?(result)
        }
    }
    
    /// Validates a user's access token and refreshes user information.
    ///
    /// - Parameters:
    ///   - request: A ValidateUserRequest object containing the access and refresh tokens
    ///   - moduleName: A string identifying the module making the request (for logging/tracking)
    ///   - response: An optional closure to handle the server response
    public func validateUser(request: ValidateUserRequest, response: LMClientResponse<ValidateUserResponse>?){
        InitiateUserClient.validateUser(request: request, withModuleName: moduleName){ result in
            response?(result)
        }
    }
    
    /// Refreshes the user's access token using the provided refresh token.
    ///
    /// This function sends a request to the server to obtain a new access token using the current refresh token.
    /// It's typically called when the current access token has expired.
    ///
    /// - Parameters:
    ///   - request: A RefreshAccessTokenRequest object containing the refresh token
    ///   - moduleName: A string identifying the module making the request (for logging/tracking)
    ///   - response: An optional closure to handle the server response
    public func refreshAccessToken(request: RefreshAccessTokenRequest, response: LMClientResponse<RefreshAccessTokenResponse>?){
        InitiateUserClient.refreshAccessToken(request: request, withModuleName: moduleName){ result in
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
        ExplorerFeedClient.shared.getExploreFeed(request: request, response: response) 
    }
    
    public func syncChatrooms() {
        HomeFeedClient.shared.syncChatrooms()
    }

    public func getChatrooms(withObserver observer: HomeFeedClientObserver) {
        HomeFeedClient.shared.getChatrooms(withObserver: observer)
    }
    
    public func syncDMChatrooms() {
        DirectMessageClient.shared.syncDMChatrooms()
    }
    
    public func getDMChatrooms(withObserver observer: HomeFeedClientObserver) {
        DirectMessageClient.shared.getChatrooms(withObserver: observer)
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
    
    public func loadConversations(withChatroomId chatroomId: String, loadType: LoadConversationType) {
        ConversationClient.shared.loadConversations(type: loadType, chatroomId: chatroomId)
    }
    
    public func loadLatestConversations(withConversationId conversationId: String, chatroomId: String) {
        ConversationClient.shared.loadConversation(withConversationId: conversationId, chatroomId: chatroomId)
    }
    
    public func getConversations(withRequest request: GetConversationsRequest) -> LMResponse<GetConversationsResponse>? {
        return ConversationClient.shared.getConversations(request: request)
    }
    
    public func saveTemporaryConversation(request: SaveConversationRequest) {
        ConversationClient.shared.saveTemporaryConversation(saveConversationRequest: request)
    }
    
    public func observeConversations(request: ObserveConversationsRequest) {
        ConversationClient.shared.observeConversations(request: request)
    }
    
    public func addObserverConversation(
        _ ob: ConversationChangeDelegate
    ) {
        ConversationClient.shared.addObserver(ob)
    }
    
    public func removeObserverConversation(
        _ ob: ConversationChangeDelegate
    ) {
        ConversationClient.shared.removeObserverConversation(ob)
    }
    
    
    public func getHomeFeed(request: GetHomeFeedRequest, response: LMClientResponse<GetHomeFeedResponse>?) {
        
    }
    
    
    public func getLoggedInUser() -> User? {
        CommunityClient.shared.getLoggedInUser()
    }
    
    public func getMember(request: GetMemberRequest) -> LMResponse<GetMemberResponse>? {
        guard let response = CommunityClient.shared.getMember(request: request) else {
            return LMResponse.failureResponse("failed to fetch member!")
        }
        return LMResponse.successResponse(response)
    }
    
    public func getCurrentMember() -> LMResponse<GetMemberResponse>? {
        guard let member = CommunityClient.shared.getCurrentMember() else {
            return LMResponse.failureResponse("failed to fetch member!")
        }
        return LMResponse.successResponse(GetMemberResponse(member: member))
    }
    
    public func getMemberState(response: LMClientResponse<GetMemberStateResponse>?) {
        CommunityClient.shared.getMemberState(response: response)
    }
    
    public func getChatroom(request: GetChatroomRequest) -> LMResponse<GetChatroomResponse>? {
        ChatroomClient.shared.getChatroom(request: request)
    }
    
    public func getChatroomActions(request: GetChatroomActionsRequest, response: LMClientResponse<GetChatroomActionsResponse>?) {
        ChatroomClient.shared.getChatroomActions(request: request, response: response)
    }
    
    public func followChatroom(request: FollowChatroomRequest, response: LMClientResponse<NoData>?) {
        ChatroomClient.shared.followChatroom(request: request, response: response)
    }
    
    public func leaveSecretChatroom(request: LeaveSecretChatroomRequest, response: LMClientResponse<NoData>?) {
        ChatroomClient.shared.leaveSecretChatroom(request: request, response: response)
    }
    
    public func muteChatroom(request: MuteChatroomRequest, response: LMClientResponse<NoData>?) {
        ChatroomClient.shared.muteChatroom(request: request, response: response)
    }
    
    public func markReadChatroom(request: MarkReadChatroomRequest, response: LMClientResponse<NoData>?) {
        ConversationClient.shared.markRead(request: request, response: response)
    }
    
    public func setChatroomTopic(request: SetChatroomTopicRequest, response: LMClientResponse<NoData>?) {
        ChatroomClient.shared.setChatroomTopic(request: request, response: response)
    }
    
    public func addPollOption(request: AddPollOptionRequest, response: LMClientResponse<AddPollOptionResponse>?) {
        PollClient.shared.addPollOption(request: request, response: response)
    }
    
    public func submitPoll(request: SubmitPollRequest, response: LMClientResponse<NoData>?) {
        PollClient.shared.submitPoll(request: request, response: response)
    }
  
    public func getPollUsers(request: GetPollUsersRequest, response: LMClientResponse<GetPollUsersResponse>?) {
        PollClient.shared.getPollUsers(request: request, response: response)
    }
    
    public func postPollConversation(request: PostPollConversationRequest, response: LMClientResponse<PostPollConversationResponse>?) {
        PollClient.shared.postPollConversation(request: request, response: response)
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
    
    public func searchChatroom(request: SearchChatroomRequest, response: LMClientResponse<SearchChatroomResponse>?) {
        SearchClient.shared.searchChatroom(with: request, response: response)
    }
    
    public func searchConversation(request: SearchConversationRequest, response: LMClientResponse<SearchConversationResponse>?) {
        SearchClient.shared.searchConversation(with: request, response: response)
    }
    
    public func getConversationsCount() {
        
    }
    
    public func deleteConversationPermanatly() {
        
    }
    
    public func updateConversationUploadingStatus(withId conversationId: String, withStatus status: ConversationStatus) {
        ConversationClient.shared.updateConversationUploadingStatus(withConversationId: conversationId, withStatus: status)
    }
    
    public func updateTemporaryConversation() {
        
    }
    
    public func getConversation(request: GetConversationRequest) -> LMResponse<GetConversationResponse>? {
        guard let conversation = ConversationClient.shared.getConversation(getConversationRequest: request) else {
            return LMResponse.failureResponse("failed to fetch conversation!")
        }
        return LMResponse.successResponse(GetConversationResponse(conversation: conversation))
    }
    
    /// Posts a new conversation to the server and processes the response.
    ///
    /// This method sends a conversation request to the server and processes the response upon success.
    ///
    /// - Parameters:
    ///   - request: A `PostConversationRequest` object containing the conversation details to be posted.
    ///   - response: An optional closure of type `LMClientResponse<PostConversationResponse>` to handle the server's response.
    public func postConversation(request: PostConversationRequest, response: LMClientResponse<PostConversationResponse>?) {
        // Call the ConversationClient to post the conversation.
        ConversationClient.shared.postConversation(request: request) { result in
            // Check if the result indicates success.
            if result.success {
                // If the result contains a widget ID, process it.
                if let widgetId = result.data?.conversation?.widgetId {
                    // Create a builder for the conversation to modify its attributes.
                    var conversationBuilder = result.data?.conversation?.toBuilder()
                    
                    // Retrieve the widget from the response data using the widget ID.
                    let widget = result.data?.widgets?[widgetId]
                    
                    // Assign the widget to the conversation builder.
                    conversationBuilder = conversationBuilder?.widget(widget)
                    
                    // Build the updated conversation object and assign it back to the result.
                    result.data?.conversation = conversationBuilder?.build()
                }
            }
            // Pass the result to the response closure.
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
    
    public func deleteTempConversations(conversationId: String) {
        ConversationClient.shared.deleteTempConversation(conversationId: conversationId)
    }
    
    public func putReaction(request: PutReactionRequest, response: LMClientResponse<NoData>?) {
        ConversationClient.shared.putReaction(request: request) { result in
            response?(result)
        }
    }
    
    public func deleteReaction(request: DeleteReactionRequest, response: LMClientResponse<NoData>?) {
        ConversationClient.shared.deleteReaction(request: request, response: response)
    }
    
    public func getUnreadConversationNotification() {
        
    }
    
    public func updateLastSeenAndDraft() {
        
    }
    
    public func editChatroomTitle() {
        
    }
    
    public func savePostedConversation(request: SavePostedConversationRequest) {
        ConversationClient.shared.savePostedConversation(request: request)
    }
    
    public func observeLiveConversation(withChatroomId chatroomId: String?) {
        ConversationClient.shared.observeChatRoomLatestConversations(forChatRoomID: chatroomId)
    }
    
    public func observeLiveHomeFeed(withCommunityId communityId: String) {
        HomeFeedClient.shared.observeLiveHomeFeed(forCommunity: communityId)
    }
    
    public func observeLiveDMFeed(withCommunityId communityId: String) {
        DirectMessageClient.shared.observeLiveHomeFeed(forCommunity: communityId)
    }
    
    public func checkDMTab(_ response: LMClientResponse<CheckDMTabResponse>?) {
        DirectMessageClient.shared.checkDMTab(response)
    }
    
    public func checkDMStatus(request: CheckDMStatusRequest, _ response: LMClientResponse<CheckDMStatusResponse>?) {
        DirectMessageClient.shared.checkDMStatus(request: request, response: response)
    }
    
    public func checkDMLimit(request: CheckDMLimitRequest, response: LMClientResponse<CheckDMLimitResponse>?) {
        DirectMessageClient.shared.checkDMLimit(request: request, response: response)
    }
    
    public func createDMChatroom(request: CreateDMChatroomRequest, response: LMClientResponse<CheckDMChatroomResponse>?) {
        DirectMessageClient.shared.createDMChatroom(request: request, response: response)
    }
    
    public func sendDMRequest(request: SendDMRequest,  response: LMClientResponse<SendDMResponse>?) {
        DirectMessageClient.shared.sendDMRequest(request: request, response: response)
    }
    
    public func blockDMMember(request: BlockMemberRequest, response: LMClientResponse<BlockMemberResponse>?) {
        DirectMessageClient.shared.blockDMMember(request: request, response: response)
    }
    
    public func getAllMembers(request: GetAllMembersRequest, response: LMClientResponse<GetAllMembersResponse>?) {
        CommunityClient.shared.getAllMembers(request: request, response: response)
    }
    
    public func searchMembers(request: SearchMembersRequest, response: LMClientResponse<SearchMembersResponse>?) {
        CommunityClient.shared.searchMembers(request: request, response: response)
    }
}
