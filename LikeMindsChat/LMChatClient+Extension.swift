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
    public func initiateUser(
        request: InitiateUserRequest,
        response: LMClientResponse<InitiateUserResponse>?
    ) {
        InitiateUserClient.initiateChatService(
            request, withModuleName: moduleName
        ) { result in
            response?(result)
        }
    }

    /// Validates a user's access token and refreshes user information.
    ///
    /// - Parameters:
    ///   - request: A ValidateUserRequest object containing the access and refresh tokens
    ///   - moduleName: A string identifying the module making the request (for logging/tracking)
    ///   - response: An optional closure to handle the server response
    public func validateUser(
        request: ValidateUserRequest,
        response: LMClientResponse<ValidateUserResponse>?
    ) {
        InitiateUserClient.validateUser(
            request: request, withModuleName: moduleName
        ) { result in
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
    public func refreshAccessToken(
        request: RefreshAccessTokenRequest,
        response: LMClientResponse<RefreshAccessTokenResponse>?
    ) {
        InitiateUserClient.refreshAccessToken(
            request: request, withModuleName: moduleName
        ) { result in
            response?(result)
        }
    }

    /// Registers the device with the LikeMinds platform using the provided request parameters.
    /// This method is typically used for associating the user's device with the platform for push notifications or other features.
    ///
    /// - Parameters:
    ///   - request: A `RegisterDeviceRequest` object containing the device registration details, such as `deviceId` and `token`.
    ///   - response: An optional callback to handle the response of type `LMClientResponse<RegisterDeviceResponse>`.
    ///
    /// - Example:
    /// ```swift
    /// let request = RegisterDeviceRequest.builder()
    ///     .deviceId("12345-ABCDE")
    ///     .token("abcd1234efgh5678ijkl")
    ///     .build()
    ///
    /// LMChatClient.shared.registerDevice(request: request) { result in
    ///     switch result {
    ///     case .success(_):
    ///         print("Device registered successfully.")
    ///     case .failure(let error):
    ///         print("Error registering device: \(error.localizedDescription)")
    ///     }
    /// }
    /// ```
    public func registerDevice(
        request: RegisterDeviceRequest,
        response: LMClientResponse<RegisterDeviceResponse>?
    ) {
        InitiateUserClient.registerDevice(
            request: request, withModuleName: moduleName
        ) { result in
            response?(result)
        }
    }

    /// Logs the user out of the LikeMinds platform by invalidating their session and removing device information.
    ///
    /// - Parameters:
    ///   - request: A `LogoutRequest` object containing the refresh token and device ID to log out the user.
    ///   - response: An optional callback to handle the response of type `LMClientResponse<NoData>`.
    ///
    /// - Example:
    /// ```swift
    /// let request = LogoutRequest.builder()
    ///     .refreshToken("example-refresh-token")
    ///     .deviceId("12345-ABCDE")
    ///     .build()
    ///
    /// LMChatClient.shared.logout(request: request) { result in
    ///     switch result {
    ///     case .success(_):
    ///         print("Logout successful.")
    ///     case .failure(let error):
    ///         print("Error during logout: \(error.localizedDescription)")
    ///     }
    /// }
    /// ```
    public func logout(
        request: LogoutRequest,
        response: LMClientResponse<NoData>?
    ) {
        InitiateUserClient.logout(request: request, withModuleName: moduleName)
        { result in
            response?(result)
        }
    }

    public func getConfig(response: LMClientResponse<ConfigResponse>?) {
        InitiateUserClient.getConfig(withModuleName: moduleName) { result in
            response?(result)
        }
    }

    public func getExploreTabCount(
        response: LMClientResponse<GetExploreTabCountResponse>?
    ) {
        HomeFeedClient.shared.getExploreTabCount(withModuleName: moduleName) {
            result in
            response?(result)
        }
    }

    public func getExploreFeed(
        request: GetExploreFeedRequest,
        response: LMClientResponse<GetExploreFeedResponse>?
    ) {
        ExplorerFeedClient.shared.getExploreFeed(
            request: request, response: response)
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

    public func getParticipants(
        request: GetParticipantsRequest,
        response: LMClientResponse<GetParticipantsResponse>?
    ) {
        ChatroomClient.shared.getParticipants(request: request) { result in
            response?(result)
        }
    }

    public func getReportTags(
        request: GetReportTagsRequest,
        response: LMClientResponse<GetReportTagsResponse>?
    ) {
        ReportClient.shared.getReportTags(request: request) { result in
            response?(result)
        }
    }

    public func postReport(
        request: PostReportRequest, response: LMClientResponse<NoData>?
    ) {
        ReportClient.shared.postReport(request: request) { result in
            response?(result)
        }
    }

    public func getContentDownloadSettings(
        _ response: LMClientResponse<GetContentDownloadSettingsResponse>?
    ) {
        CommunityClient.shared.getContentDownloadSettings { result in
            response?(result)
        }
    }

    public func loadConversations(
        withChatroomId chatroomId: String, loadType: LoadConversationType
    ) {
        ConversationClient.shared.loadConversations(
            type: loadType, chatroomId: chatroomId)
    }

    public func loadLatestConversations(
        withConversationId conversationId: String, chatroomId: String
    ) {
        ConversationClient.shared.loadConversation(
            withConversationId: conversationId, chatroomId: chatroomId)
    }

    public func getConversations(withRequest request: GetConversationsRequest)
        -> LMResponse<GetConversationsResponse>?
    {
        return ConversationClient.shared.getConversations(request: request)
    }

    public func saveTemporaryConversation(request: SaveConversationRequest) {
        ConversationClient.shared.saveTemporaryConversation(
            saveConversationRequest: request)
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

    public func getHomeFeed(
        request: GetHomeFeedRequest,
        response: LMClientResponse<GetHomeFeedResponse>?
    ) {

    }

    public func getLoggedInUser() -> User? {
        CommunityClient.shared.getLoggedInUser()
    }

    public func getMember(request: GetMemberRequest) -> LMResponse<
        GetMemberResponse
    >? {
        guard let response = CommunityClient.shared.getMember(request: request)
        else {
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

    public func getMemberState(
        response: LMClientResponse<GetMemberStateResponse>?
    ) {
        CommunityClient.shared.getMemberState(response: response)
    }

    public func getChatroom(request: GetChatroomRequest) -> LMResponse<
        GetChatroomResponse
    >? {
        ChatroomClient.shared.getChatroom(request: request)
    }

    public func getChatroomActions(
        request: GetChatroomActionsRequest,
        response: LMClientResponse<GetChatroomActionsResponse>?
    ) {
        ChatroomClient.shared.getChatroomActions(
            request: request, response: response)
    }

    public func followChatroom(
        request: FollowChatroomRequest, response: LMClientResponse<NoData>?
    ) {
        ChatroomClient.shared.followChatroom(
            request: request, response: response)
    }

    public func leaveSecretChatroom(
        request: LeaveSecretChatroomRequest, response: LMClientResponse<NoData>?
    ) {
        ChatroomClient.shared.leaveSecretChatroom(
            request: request, response: response)
    }

    public func muteChatroom(
        request: MuteChatroomRequest, response: LMClientResponse<NoData>?
    ) {
        ChatroomClient.shared.muteChatroom(request: request, response: response)
    }

    public func markReadChatroom(
        request: MarkReadChatroomRequest, response: LMClientResponse<NoData>?
    ) {
        ConversationClient.shared.markRead(request: request, response: response)
    }

    public func setChatroomTopic(
        request: SetChatroomTopicRequest, response: LMClientResponse<NoData>?
    ) {
        ChatroomClient.shared.setChatroomTopic(
            request: request, response: response)
    }

    public func addPollOption(
        request: AddPollOptionRequest,
        response: LMClientResponse<AddPollOptionResponse>?
    ) {
        PollClient.shared.addPollOption(request: request, response: response)
    }

    public func submitPoll(
        request: SubmitPollRequest, response: LMClientResponse<NoData>?
    ) {
        PollClient.shared.submitPoll(request: request, response: response)
    }

    public func getPollUsers(
        request: GetPollUsersRequest,
        response: LMClientResponse<GetPollUsersResponse>?
    ) {
        PollClient.shared.getPollUsers(request: request, response: response)
    }

    public func postPollConversation(
        request: PostPollConversationRequest,
        response: LMClientResponse<PostPollConversationResponse>?
    ) {
        PollClient.shared.postPollConversation(
            request: request, response: response)
    }

    public func decodeUrl(
        request: DecodeUrlRequest,
        response: LMClientResponse<DecodeUrlResponse>?
    ) {
        ConversationClient.shared.decodeUrl(request: request) { result in
            response?(result)
        }
    }

    public func getTaggingList(
        request: GetTaggingListRequest,
        response: LMClientResponse<GetTaggingListResponse>?
    ) {
        ConversationClient.shared.getTaggingList(request: request) { result in
            response?(result)
        }
    }

    public func getDBEmpty() {

    }

    /// Searches for chatrooms based on the provided request parameters.
    ///
    /// - Parameters:
    ///   - request: A `SearchChatroomRequest` object containing the search parameters.
    ///   - response: An optional callback to handle the response of type `LMClientResponse<SearchChatroomResponse>`.
    ///
    /// - Example:
    /// ```swift
    /// let request = SearchChatroomRequest.builder()
    ///     .search("Sports")
    ///     .followStatus(true)
    ///     .page(1)
    ///     .pageSize(20)
    ///     .build()
    ///
    /// LMChatClient.shared.searchChatroom(request: request) { result in
    ///     switch result {
    ///     case .success(let response):
    ///         print("Found \(response.conversations.count) chatrooms.")
    ///     case .failure(let error):
    ///         print("Error searching chatrooms: \(error.localizedDescription)")
    ///     }
    /// }
    /// ```
    public func searchChatroom(
        request: SearchChatroomRequest,
        response: LMClientResponse<SearchChatroomResponse>?
    ) {
        SearchClient.shared.searchChatroom(with: request, response: response)
    }

    /// Searches for conversations based on the provided request parameters.
    ///
    /// - Parameters:
    ///   - request: A `SearchConversationRequest` object containing the search parameters.
    ///   - response: An optional callback to handle the response of type `LMClientResponse<SearchConversationResponse>`.
    ///
    /// - Example:
    /// ```swift
    /// let request = SearchConversationRequest.builder()
    ///     .search("General Updates")
    ///     .followStatus(false)
    ///     .page(1)
    ///     .pageSize(15)
    ///     .build()
    ///
    /// LMChatClient.shared.searchConversation(request: request) { result in
    ///     switch result {
    ///     case .success(let response):
    ///         print("Found \(response.conversations.count) conversations.")
    ///     case .failure(let error):
    ///         print("Error searching conversations: \(error.localizedDescription)")
    ///     }
    /// }
    /// ```
    public func searchConversation(
        request: SearchConversationRequest,
        response: LMClientResponse<SearchConversationResponse>?
    ) {
        SearchClient.shared.searchConversation(
            with: request, response: response
        )
    }

    public func getConversationsCount() {

    }

    public func deleteConversationPermanatly() {

    }

    public func updateConversationUploadingStatus(
        withId conversationId: String, withStatus status: ConversationStatus
    ) {
        ConversationClient.shared.updateConversationUploadingStatus(
            withConversationId: conversationId, withStatus: status)
    }

    public func updateTemporaryConversation() {

    }

    public func getConversation(request: GetConversationRequest) -> LMResponse<
        GetConversationResponse
    >? {
        guard
            let conversation = ConversationClient.shared.getConversation(
                getConversationRequest: request)
        else {
            return LMResponse.failureResponse("failed to fetch conversation!")
        }
        return LMResponse.successResponse(
            GetConversationResponse(conversation: conversation))
    }

    /// Posts a new conversation to the server and processes the response.
    ///
    /// This method sends a conversation request to the server and processes the response upon success.
    ///
    /// - Parameters:
    ///   - request: A `PostConversationRequest` object containing the conversation details to be posted.
    ///   - response: An optional closure of type `LMClientResponse<PostConversationResponse>` to handle the server's response.
    public func postConversation(
        request: PostConversationRequest,
        response: LMClientResponse<PostConversationResponse>?
    ) {
        // Call the ConversationClient to post the conversation.
        ConversationClient.shared.postConversation(request: request) { result in
            // Check if the result indicates success.
            if result.success {
                // If the result contains a widget ID, process it.
                if let widgetId = result.data?.conversation?.widgetId {
                    // Create a builder for the conversation to modify its attributes.
                    var conversationBuilder = result.data?.conversation?
                        .toBuilder()

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

    public func editConversation(
        request: EditConversationRequest,
        response: LMClientResponse<EditConversationResponse>?
    ) {
        ConversationClient.shared.editConversation(request: request) { result in
            response?(result)
        }
    }

    public func deleteConversations(
        request: DeleteConversationsRequest,
        response: LMClientResponse<DeleteConversationsResponse>?
    ) {
        ConversationClient.shared.deleteConversations(request: request) {
            result in
            response?(result)
        }
    }

    public func deleteTempConversations(conversationId: String) {
        ConversationClient.shared.deleteTempConversation(
            conversationId: conversationId)
    }

    public func putReaction(
        request: PutReactionRequest, response: LMClientResponse<NoData>?
    ) {
        ConversationClient.shared.putReaction(request: request) { result in
            response?(result)
        }
    }

    public func deleteReaction(
        request: DeleteReactionRequest, response: LMClientResponse<NoData>?
    ) {
        ConversationClient.shared.deleteReaction(
            request: request, response: response)
    }

    public func savePostedConversation(request: SavePostedConversationRequest) {
        ConversationClient.shared.savePostedConversation(request: request)
    }

    public func observeLiveConversation(withChatroomId chatroomId: String?) {
        ConversationClient.shared.observeChatRoomLatestConversations(
            forChatRoomID: chatroomId)
    }

    public func observeLiveHomeFeed(withCommunityId communityId: String) {
        HomeFeedClient.shared.observeLiveHomeFeed(forCommunity: communityId)
    }

    public func observeLiveDMFeed(withCommunityId communityId: String) {
        DirectMessageClient.shared.observeLiveHomeFeed(
            forCommunity: communityId)
    }

    public func checkDMTab(_ response: LMClientResponse<CheckDMTabResponse>?) {
        DirectMessageClient.shared.checkDMTab(response)
    }

    public func checkDMStatus(
        request: CheckDMStatusRequest,
        _ response: LMClientResponse<CheckDMStatusResponse>?
    ) {
        DirectMessageClient.shared.checkDMStatus(
            request: request, response: response)
    }

    public func checkDMLimit(
        request: CheckDMLimitRequest,
        response: LMClientResponse<CheckDMLimitResponse>?
    ) {
        DirectMessageClient.shared.checkDMLimit(
            request: request, response: response)
    }

    public func createDMChatroom(
        request: CreateDMChatroomRequest,
        response: LMClientResponse<CheckDMChatroomResponse>?
    ) {
        DirectMessageClient.shared.createDMChatroom(
            request: request, response: response)
    }

    public func sendDMRequest(
        request: SendDMRequest, response: LMClientResponse<SendDMResponse>?
    ) {
        DirectMessageClient.shared.sendDMRequest(
            request: request, response: response)
    }

    public func blockDMMember(
        request: BlockMemberRequest,
        response: LMClientResponse<BlockMemberResponse>?
    ) {
        DirectMessageClient.shared.blockDMMember(
            request: request, response: response)
    }

    /// Retrieves a list of all members from the server based on the specified request parameters.
    ///
    /// This method utilizes the `CommunityClient` to perform the actual network call. The `GetAllMembersRequest` object
    /// defines the criteria for fetching community members (such as page number, page size, and filtering by roles).
    /// The `GetAllMembersResponse` contains the resulting list of members along with any relevant metadata, including
    /// total counts and additional community information.
    ///
    /// - Parameters:
    ///   - request: A `GetAllMembersRequest` object containing parameters such as the page number, page size, optional
    ///              member states, and whether to exclude the current user.
    ///   - response: A closure to handle the server response, which includes either a successful `GetAllMembersResponse`
    ///               object or an error message if the request fails.
    ///
    /// - Example:
    /// ```swift
    /// let request = GetAllMembersRequest.builder()
    ///     .page(1)
    ///     .pageSize(10)
    ///     .filterMemberRoles([.admin, .member])
    ///     .excludeSelfUser(true)
    ///     .build()
    ///
    /// LMChatClient.shared.getAllMembers(request: request) { result in
    ///     switch result {
    ///     case .success(let responseData):
    ///         print("Successfully retrieved \(responseData.members?.count ?? 0) members.")
    ///     case .failure(let error):
    ///         print("Failed to retrieve members: \(error.localizedDescription)")
    ///     }
    /// }
    /// ```
    public func getAllMembers(
        request: GetAllMembersRequest,
        response: LMClientResponse<GetAllMembersResponse>?
    ) {
        CommunityClient.shared.getAllMembers(
            request: request,
            response: response
        )
    }

    /// Searches for members in the community based on the specified request parameters.
    ///
    /// This method calls the `CommunityClient` to send a search query for members. The `SearchMembersRequest` allows you to
    /// specify a search string, page size, search type, and other filters. The `SearchMembersResponse` contains the resulting
    /// list of members that match the criteria, along with relevant metadata.
    ///
    /// - Parameters:
    ///   - request: A `SearchMembersRequest` object containing parameters such as the search query, page number, page size,
    ///              and optional member states.
    ///   - response: A closure to handle the server response, which includes either a successful `SearchMembersResponse`
    ///               object or an error message if the request fails.
    ///
    /// - Example:
    /// ```swift
    /// let request = SearchMembersRequest.builder()
    ///     .search("John")
    ///     .page(1)
    ///     .pageSize(10)
    ///     .searchType("name")
    ///     .build()
    ///
    /// LMChatClient.shared.searchMembers(request: request) { result in
    ///     switch result {
    ///     case .success(let responseData):
    ///         print("Found \(responseData.members?.count ?? 0) members matching the search.")
    ///     case .failure(let error):
    ///         print("Error searching for members: \(error.localizedDescription)")
    ///     }
    /// }
    /// ```
    public func searchMembers(
        request: SearchMembersRequest,
        response: LMClientResponse<SearchMembersResponse>?
    ) {
        CommunityClient.shared.searchMembers(
            request: request,
            response: response
        )
    }

    // MARK: Secret Chatroom Invite

    /// Retrieves a list of channel invites from the server based on the specified request parameters.
    ///
    /// This method utilizes the `ChatroomClient` to perform the actual network call. The `GetChannelInvitesRequest` object
    /// contains the criteria for fetching channel invites (such as channel type, page number, and page size), and
    /// `GetChannelInvitesResponse` models the server’s response, typically including a list of invites and any relevant metadata.
    ///
    /// - Parameters:
    ///   - request: A `GetChannelInvitesRequest` object containing parameters such as channel type, page number, and page size.
    ///   - response: A closure to handle the server response, which includes either the successful `GetChannelInvitesResponse` data
    ///               or an error message in case of failure.
    ///
    /// - Example:
    /// ```swift
    /// let request = GetChannelInvitesRequest.builder()
    ///     .channelType(1)
    ///     .page(1)
    ///     .pageSize(10)
    ///     .build()
    ///
    /// LMChatClient.shared.getChannelInvites(request: request) { result in
    ///     switch result {
    ///     case .success(let responseData):
    ///         print("Fetched \(responseData.channelInvites.count) channel invites.")
    ///     case .failure(let error):
    ///         print("Failed to get channel invites: \(error.localizedDescription)")
    ///     }
    /// }
    /// ```
    public func getChannelInvites(
        request: GetChannelInvitesRequest,
        response: LMClientResponse<GetChannelInvitesResponse>?
    ) {
        ChatroomClient.shared.getChannelInvites(
            request: request,
            response: response
        )
    }

    /// Updates the status of a channel invite (e.g., accept or reject) based on the specified request parameters.
    ///
    /// This method utilizes the `ChatroomClient` to perform the actual network call. The `UpdateChannelInviteRequest` object
    /// contains the necessary details for updating the invite (such as the channel ID and the intended invite status).
    /// Since the server typically returns a success or failure indicator for this operation, the response is modeled as
    /// `NoData` (indicating no detailed data is expected).
    ///
    /// - Parameters:
    ///   - request: An `UpdateChannelInviteRequest` object containing the channel ID and the desired invite status.
    ///   - response: A closure to handle the server response, which includes either a successful `NoData` object or an error
    ///               message in case of failure.
    ///
    /// - Example:
    /// ```swift
    /// let request = UpdateChannelInviteRequest.builder()
    ///     .channelId("12345")
    ///     .inviteStatus(.accepted)
    ///     .build()
    ///
    /// LMChatClient.shared.updateChannelInvite(request: request) { result in
    ///     switch result {
    ///     case .success(_):
    ///         print("Channel invite status updated successfully.")
    ///     case .failure(let error):
    ///         print("Error updating channel invite: \(error.localizedDescription)")
    ///     }
    /// }
    /// ```
    public func updateChannelInvite(
        request: UpdateChannelInviteRequest,
        response: LMClientResponse<NoData>?
    ) {
        ChatroomClient.shared.updateChannelInvite(
            request: request,
            response: response
        )
    }

}
