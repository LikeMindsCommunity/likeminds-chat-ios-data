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
  ///   - request: A `LogoutUserRequest` object containing the refresh token and device ID to log out the user.
  ///   - response: An optional callback to handle the response of type `LMClientResponse<NoData>`.
  ///
  /// - Example:
  /// ```swift
  /// let request = LogoutUserRequest.builder()
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
  public func logoutUser(
    request: LogoutUserRequest,
    response: LMClientResponse<NoData>?
  ) {
    InitiateUserClient.logoutUser(request: request, withModuleName: moduleName) { result in
      response?(result)
    }
  }

  /// Retrieves the current configuration settings from the server.
  ///
  /// - Parameter response: An optional closure to handle the server response of type `LMClientResponse<ConfigResponse>`.
  public func getConfig(response: LMClientResponse<ConfigResponse>?) {
    InitiateUserClient.getConfig(withModuleName: moduleName) { result in
      response?(result)
    }
  }

  /// Retrieves the count of items in the explore tab.
  ///
  /// - Parameter response: An optional closure to handle the server response of type `LMClientResponse<GetExploreTabCountResponse>`.
  public func getExploreTabCount(
    response: LMClientResponse<GetExploreTabCountResponse>?
  ) {
    HomeFeedClient.shared.getExploreTabCount(withModuleName: moduleName) {
      result in
      response?(result)
    }
  }

  /// Retrieves the explore feed content based on the specified request parameters.
  ///
  /// - Parameters:
  ///   - request: A `GetExploreFeedRequest` object containing the parameters for fetching the explore feed.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<GetExploreFeedResponse>`.
  public func getExploreFeed(
    request: GetExploreFeedRequest,
    response: LMClientResponse<GetExploreFeedResponse>?
  ) {
    ExplorerFeedClient.shared.getExploreFeed(
      request: request, response: response)
  }

  /// Synchronizes chatrooms with the server.
  public func syncChatrooms() {
    HomeFeedClient.shared.syncChatrooms()
  }

  /// Retrieves chatrooms with the specified observer.
  ///
  /// - Parameter observer: A `HomeFeedClientObserver` object to receive updates about chatroom changes.
  public func getChatrooms(withObserver observer: HomeFeedClientObserver) {
    HomeFeedClient.shared.getChatrooms(withObserver: observer)
  }

  /// Synchronizes direct message chatrooms with the server.
  public func syncDMChatrooms() {
    DirectMessageClient.shared.syncDMChatrooms()
  }

  /// Retrieves direct message chatrooms with the specified observer.
  ///
  /// - Parameter observer: A `HomeFeedClientObserver` object to receive updates about DM chatroom changes.
  public func getDMChatrooms(withObserver observer: HomeFeedClientObserver) {
    DirectMessageClient.shared.getChatrooms(withObserver: observer)
  }

  /// Retrieves participants of a chatroom based on the specified request parameters.
  ///
  /// - Parameters:
  ///   - request: A `GetParticipantsRequest` object containing the parameters for fetching participants.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<GetParticipantsResponse>`.
  public func getParticipants(
    request: GetParticipantsRequest,
    response: LMClientResponse<GetParticipantsResponse>?
  ) {
    ChatroomClient.shared.getParticipants(request: request) { result in
      response?(result)
    }
  }

  /// Retrieves available report tags based on the specified request parameters.
  ///
  /// - Parameters:
  ///   - request: A `GetReportTagsRequest` object containing the parameters for fetching report tags.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<GetReportTagsResponse>`.
  public func getReportTags(
    request: GetReportTagsRequest,
    response: LMClientResponse<GetReportTagsResponse>?
  ) {
    ReportClient.shared.getReportTags(request: request) { result in
      response?(result)
    }
  }

  /// Submits a report based on the specified request parameters.
  ///
  /// - Parameters:
  ///   - request: A `PostReportRequest` object containing the report details.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<NoData>`.
  public func postReport(
    request: PostReportRequest, response: LMClientResponse<NoData>?
  ) {
    ReportClient.shared.postReport(request: request) { result in
      response?(result)
    }
  }

  /// Retrieves content download settings from the server.
  ///
  /// - Parameter response: An optional closure to handle the server response of type `LMClientResponse<GetContentDownloadSettingsResponse>`.
  public func getContentDownloadSettings(
    _ response: LMClientResponse<GetContentDownloadSettingsResponse>?
  ) {
    CommunityClient.shared.getContentDownloadSettings { result in
      response?(result)
    }
  }

  /// Loads conversations for a specific chatroom.
  ///
  /// - Parameters:
  ///   - chatroomId: The ID of the chatroom to load conversations from.
  ///   - loadType: The type of loading operation to perform.
  public func loadConversations(
    withChatroomId chatroomId: String, loadType: LoadConversationType
  ) {
    ConversationClient.shared.loadConversations(
      type: loadType, chatroomId: chatroomId)
  }

  /// Loads the latest conversations for a specific conversation and chatroom.
  ///
  /// - Parameters:
  ///   - conversationId: The ID of the conversation to load.
  ///   - chatroomId: The ID of the chatroom containing the conversation.
  public func loadLatestConversations(
    withConversationId conversationId: String, chatroomId: String
  ) {
    ConversationClient.shared.loadConversation(
      withConversationId: conversationId, chatroomId: chatroomId)
  }

  /// Retrieves conversations based on the specified request parameters.
  ///
  /// - Parameter request: A `GetConversationsRequest` object containing the parameters for fetching conversations.
  /// - Returns: An optional `LMResponse<GetConversationsResponse>` containing the conversations if successful.
  public func getConversations(withRequest request: GetConversationsRequest)
    -> LMResponse<GetConversationsResponse>?
  {
    return ConversationClient.shared.getConversations(request: request)
  }

  /// Saves a temporary conversation.
  ///
  /// - Parameter request: A `SaveConversationRequest` object containing the conversation to save.
  public func saveTemporaryConversation(request: SaveConversationRequest) {
    ConversationClient.shared.saveTemporaryConversation(
      saveConversationRequest: request)
  }

  /// Starts observing conversations based on the specified request parameters.
  ///
  /// - Parameter request: An `ObserveConversationsRequest` object containing the parameters for observation.
  public func observeConversations(request: ObserveConversationsRequest) {
    ConversationClient.shared.observeConversations(request: request)
  }

  /// Adds an observer for conversation changes.
  ///
  /// - Parameter ob: A `ConversationChangeDelegate` object to receive updates about conversation changes.
  public func addObserverConversation(
    _ ob: ConversationChangeDelegate
  ) {
    ConversationClient.shared.addObserver(ob)
  }

  /// Removes an observer for conversation changes.
  ///
  /// - Parameter ob: The `ConversationChangeDelegate` object to remove from observers.
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

  /// Retrieves the currently logged-in user.
  ///
  /// - Returns: An optional `User` object representing the logged-in user.
  public func getLoggedInUser() -> User? {
    CommunityClient.shared.getLoggedInUser()
  }

  /// Retrieves a member based on the specified request parameters.
  ///
  /// - Parameter request: A `GetMemberRequest` object containing the parameters for fetching the member.
  /// - Returns: An optional `LMResponse<GetMemberResponse>` containing the member information if successful.
  public func getMember(request: GetMemberRequest) -> LMResponse<
    GetMemberResponse
  >? {
    guard let response = CommunityClient.shared.getMember(request: request)
    else {
      return LMResponse.failureResponse("failed to fetch member!")
    }
    return LMResponse.successResponse(response)
  }

  /// Retrieves the current member's information.
  ///
  /// - Returns: An optional `LMResponse<GetMemberResponse>` containing the current member's information if successful.
  public func getCurrentMember() -> LMResponse<GetMemberResponse>? {
    guard let member = CommunityClient.shared.getCurrentMember() else {
      return LMResponse.failureResponse("failed to fetch member!")
    }
    return LMResponse.successResponse(GetMemberResponse(member: member))
  }

  /// Retrieves the current member's state.
  ///
  /// - Parameter response: An optional closure to handle the server response of type `LMClientResponse<GetMemberStateResponse>`.
  public func getMemberState(
    response: LMClientResponse<GetMemberStateResponse>?
  ) {
    CommunityClient.shared.getMemberState(response: response)
  }

  /// Retrieves a chatroom based on the specified request parameters.
  ///
  /// - Parameter request: A `GetChatroomRequest` object containing the parameters for fetching the chatroom.
  /// - Returns: An optional `LMResponse<GetChatroomResponse>` containing the chatroom information if successful.
  public func getChatroom(request: GetChatroomRequest) -> LMResponse<
    GetChatroomResponse
  >? {
    ChatroomClient.shared.getChatroom(request: request)
  }

  /// Retrieves available actions for a chatroom based on the specified request parameters.
  ///
  /// - Parameters:
  ///   - request: A `GetChatroomActionsRequest` object containing the parameters for fetching chatroom actions.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<GetChatroomActionsResponse>`.
  public func getChatroomActions(
    request: GetChatroomActionsRequest,
    response: LMClientResponse<GetChatroomActionsResponse>?
  ) {
    ChatroomClient.shared.getChatroomActions(
      request: request, response: response)
  }

  /// Updates the follow status of a chatroom.
  ///
  /// - Parameters:
  ///   - request: A `FollowChatroomRequest` object containing the chatroom ID and follow status.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<NoData>`.
  public func followChatroom(
    request: FollowChatroomRequest, response: LMClientResponse<NoData>?
  ) {
    ChatroomClient.shared.followChatroom(
      request: request, response: response)
  }

  /// Removes the current user from a secret chatroom.
  ///
  /// - Parameters:
  ///   - request: A `LeaveSecretChatroomRequest` object containing the chatroom ID.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<NoData>`.
  public func leaveSecretChatroom(
    request: LeaveSecretChatroomRequest, response: LMClientResponse<NoData>?
  ) {
    ChatroomClient.shared.leaveSecretChatroom(
      request: request, response: response)
  }

  /// Updates the mute status of a chatroom.
  ///
  /// - Parameters:
  ///   - request: A `MuteChatroomRequest` object containing the chatroom ID and mute status.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<NoData>`.
  public func muteChatroom(
    request: MuteChatroomRequest, response: LMClientResponse<NoData>?
  ) {
    ChatroomClient.shared.muteChatroom(request: request, response: response)
  }

  /// Marks a chatroom as read.
  ///
  /// - Parameters:
  ///   - request: A `MarkReadChatroomRequest` object containing the chatroom ID.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<NoData>`.
  public func markReadChatroom(
    request: MarkReadChatroomRequest, response: LMClientResponse<NoData>?
  ) {
    ConversationClient.shared.markRead(request: request, response: response)
  }

  /// Sets a conversation as the topic for a chatroom.
  ///
  /// - Parameters:
  ///   - request: A `SetChatroomTopicRequest` object containing the chatroom and conversation details.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<NoData>`.
  public func setChatroomTopic(
    request: SetChatroomTopicRequest, response: LMClientResponse<NoData>?
  ) {
    ChatroomClient.shared.setChatroomTopic(
      request: request, response: response)
  }

  /// Adds a new option to an existing poll.
  ///
  /// - Parameters:
  ///   - request: An `AddPollOptionRequest` object containing the poll and option details.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<AddPollOptionResponse>`.
  public func addPollOption(
    request: AddPollOptionRequest,
    response: LMClientResponse<AddPollOptionResponse>?
  ) {
    PollClient.shared.addPollOption(request: request, response: response)
  }

  /// Submits a vote for a poll option.
  ///
  /// - Parameters:
  ///   - request: A `SubmitPollRequest` object containing the poll and vote details.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<NoData>`.
  public func submitPoll(
    request: SubmitPollRequest, response: LMClientResponse<NoData>?
  ) {
    PollClient.shared.submitPoll(request: request, response: response)
  }

  /// Retrieves users who have voted in a poll.
  ///
  /// - Parameters:
  ///   - request: A `GetPollUsersRequest` object containing the poll details.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<GetPollUsersResponse>`.
  public func getPollUsers(
    request: GetPollUsersRequest,
    response: LMClientResponse<GetPollUsersResponse>?
  ) {
    PollClient.shared.getPollUsers(request: request, response: response)
  }

  /// Creates a new poll conversation.
  ///
  /// - Parameters:
  ///   - request: A `PostPollConversationRequest` object containing the poll conversation details.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<PostPollConversationResponse>`.
  public func postPollConversation(
    request: PostPollConversationRequest,
    response: LMClientResponse<PostPollConversationResponse>?
  ) {
    PollClient.shared.postPollConversation(
      request: request, response: response)
  }

  /// Decodes a URL to extract relevant information.
  ///
  /// - Parameters:
  ///   - request: A `DecodeUrlRequest` object containing the URL to decode.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<DecodeUrlResponse>`.
  public func decodeUrl(
    request: DecodeUrlRequest,
    response: LMClientResponse<DecodeUrlResponse>?
  ) {
    ConversationClient.shared.decodeUrl(request: request) { result in
      response?(result)
    }
  }

  /// Retrieves a list of users that can be tagged in conversations.
  ///
  /// - Parameters:
  ///   - request: A `GetTaggingListRequest` object containing the search parameters.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<GetTaggingListResponse>`.
  public func getTaggingList(
    request: GetTaggingListRequest,
    response: LMClientResponse<GetTaggingListResponse>?
  ) {
    ConversationClient.shared.getTaggingList(request: request) { result in
      response?(result)
    }
  }

  /// Checks if the database is empty.
  ///
  /// This method verifies if the local database contains any data.
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
    SearchClient.shared.searchChatroom(request: request, response: response)
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
      request: request, response: response
    )
  }

  /// Retrieves the count of conversations.
  ///
  /// This method returns the total number of conversations in the system.
  public func getConversationsCount() {

  }

  /// Permanently deletes a conversation.
  ///
  /// This method removes a conversation from both the server and local storage.
  public func deleteConversationPermanatly() {

  }

  /// Updates the uploading status of a conversation.
  ///
  /// - Parameters:
  ///   - conversationId: The ID of the conversation to update.
  ///   - status: The new `ConversationStatus` to set.
  public func updateConversationUploadingStatus(
    withId conversationId: String, withStatus status: ConversationStatus
  ) {
    ConversationClient.shared.updateConversationUploadingStatus(
      withConversationId: conversationId, withStatus: status)
  }

  /// Updates a temporary conversation.
  ///
  /// This method updates the state of a temporary conversation in local storage.
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

  /// Deletes a temporary conversation from local storage.
  ///
  /// - Parameter conversationId: The ID of the temporary conversation to delete.
  public func deleteTempConversations(conversationId: String) {
    ConversationClient.shared.deleteTempConversation(
      conversationId: conversationId)
  }

  /// Adds a reaction to a conversation.
  ///
  /// - Parameters:
  ///   - request: A `PutReactionRequest` object containing the reaction details.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<NoData>`.
  public func putReaction(
    request: PutReactionRequest, response: LMClientResponse<NoData>?
  ) {
    ConversationClient.shared.putReaction(request: request) { result in
      response?(result)
    }
  }

  /// Removes a reaction from a conversation.
  ///
  /// - Parameters:
  ///   - request: A `DeleteReactionRequest` object containing the reaction details to remove.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<NoData>`.
  public func deleteReaction(
    request: DeleteReactionRequest, response: LMClientResponse<NoData>?
  ) {
    ConversationClient.shared.deleteReaction(
      request: request, response: response)
  }

  /// Saves a conversation that has been successfully posted to the server.
  ///
  /// - Parameter request: A `SavePostedConversationRequest` object containing the conversation details to save.
  public func savePostedConversation(request: SavePostedConversationRequest) {
    ConversationClient.shared.savePostedConversation(request: request)
  }

  /// Starts observing live updates for a specific chatroom.
  ///
  /// - Parameter chatroomId: The ID of the chatroom to observe.
  public func observeLiveConversation(withChatroomId chatroomId: String?) {
    ConversationClient.shared.observeChatRoomLatestConversations(
      forChatRoomID: chatroomId)
  }

  /// Starts observing live updates for the home feed of a community.
  ///
  /// - Parameter communityId: The ID of the community to observe.
  public func observeLiveHomeFeed(withCommunityId communityId: String) {
    HomeFeedClient.shared.observeLiveHomeFeed(forCommunity: communityId)
  }

  /// Starts observing live updates for direct messages in a community.
  ///
  /// - Parameter communityId: The ID of the community to observe.
  public func observeLiveDMFeed(withCommunityId communityId: String) {
    DirectMessageClient.shared.observeLiveHomeFeed(
      forCommunity: communityId)
  }

  /// Checks if the direct messaging tab is available.
  ///
  /// - Parameter response: An optional closure to handle the server response of type `LMClientResponse<CheckDMTabResponse>`.
  public func checkDMTab(_ response: LMClientResponse<CheckDMTabResponse>?) {
    DirectMessageClient.shared.checkDMTab(response)
  }

  /// Checks the status of direct messaging with a specific member.
  ///
  /// - Parameters:
  ///   - request: A `CheckDMStatusRequest` object containing the member details.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<CheckDMStatusResponse>`.
  public func checkDMStatus(
    request: CheckDMStatusRequest,
    _ response: LMClientResponse<CheckDMStatusResponse>?
  ) {
    DirectMessageClient.shared.checkDMStatus(
      request: request, response: response)
  }

  /// Checks if the user has reached their direct messaging limit.
  ///
  /// - Parameters:
  ///   - request: A `CheckDMLimitRequest` object containing the request parameters.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<CheckDMLimitResponse>`.
  public func checkDMLimit(
    request: CheckDMLimitRequest,
    response: LMClientResponse<CheckDMLimitResponse>?
  ) {
    DirectMessageClient.shared.checkDMLimit(
      request: request, response: response)
  }

  /// Creates a new direct message chatroom.
  ///
  /// - Parameters:
  ///   - request: A `CreateDMChatroomRequest` object containing the chatroom details.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<CheckDMChatroomResponse>`.
  public func createDMChatroom(
    request: CreateDMChatroomRequest,
    response: LMClientResponse<CheckDMChatroomResponse>?
  ) {
    DirectMessageClient.shared.createDMChatroom(
      request: request, response: response)
  }

  /// Sends a direct message request to another member.
  ///
  /// - Parameters:
  ///   - request: A `SendDMRequest` object containing the message details.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<SendDMResponse>`.
  public func sendDMRequest(
    request: SendDMRequest, response: LMClientResponse<SendDMResponse>?
  ) {
    DirectMessageClient.shared.sendDMRequest(
      request: request, response: response)
  }

  /// Blocks a member from sending direct messages.
  ///
  /// - Parameters:
  ///   - request: A `BlockMemberRequest` object containing the member details.
  ///   - response: An optional closure to handle the server response of type `LMClientResponse<BlockMemberResponse>`.
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
  /// `GetChannelInvitesResponse` models the server's response, typically including a list of invites and any relevant metadata.
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

  /// Updates an attachment in the local database asynchronously.
  ///
  /// This method delegates the attachment update operation to the ConversationClient.
  /// It uses modern Swift concurrency with async/await for better performance and error handling.
  ///
  /// - Parameters:
  ///   - attachment: The Attachment object containing the updated attachment data to be stored in the local database.
  ///
  /// - Returns: An LMResponse<NoData> indicating the success or failure of the update operation.
  ///
  /// - Example:
  /// ```swift
  /// let attachment = Attachment(...)
  /// let response = await LMChatClient.shared.updateAttachment(attachment: attachment)
  /// if response.success {
  ///     print("Attachment updated successfully")
  /// } else {
  ///     print("Failed to update attachment: \(response.errorMessage ?? "Unknown error")")
  /// }
  /// ```
  public func updateAttachment(attachment: Attachment) async -> LMResponse<NoData> {
    await ConversationClient.shared.updateAttachment(attachment: attachment)
  }

  /// Updates a conversation in the local database asynchronously.
  ///
  /// This method delegates the conversation update operation to the ConversationClient.
  /// It uses modern Swift concurrency with async/await for better performance and error handling.
  ///
  /// - Parameters:
  ///   - conversation: The Conversation object containing the updated conversation data to be stored in the local database.
  ///
  /// - Returns: An LMResponse<NoData> indicating the success or failure of the update operation.
  ///
  /// - Example:
  /// ```swift
  /// let conversation = Conversation(...)
  /// let response = await LMChatClient.shared.updateConversation(conversation: conversation)
  /// if response.success {
  ///     print("Conversation updated successfully")
  /// } else {
  ///     print("Failed to update conversation: \(response.errorMessage ?? "Unknown error")")
  /// }
  /// ```
  public func updateConversation(conversation: Conversation) async -> LMResponse<NoData> {
    await ConversationClient.shared.updateConversation(conversation: conversation)
  }

  /// Updates the last conversation in the database for a given conversation.
  /// This method converts the provided conversation to a LastConversationRO and updates it in the database.
  ///
  /// - Parameter conversation: The conversation to be converted and stored as the last conversation
  public func updateLastConversation(conversation: Conversation) {
    ConversationClient.shared.updateLastConversation(conversation: conversation)
  }

  /// Updates the last conversation model in the chatroom with the provided conversation.
  /// This method updates the chatroom's last conversation references and stores the conversation in the database.
  ///
  /// - Parameters:
  ///   - chatroomId: The ID of the chatroom whose last conversation needs to be updated
  ///   - conversation: The conversation to be set as the last conversation
  public func updateLastConversationModel(chatroomId: String, conversation: Conversation) {
    ConversationClient.shared.updateLastConversationModel(
      chatroomId: chatroomId, conversation: conversation)
  }

  // MARK: AI Chatbot

  /// Retrieves a list of AI chatbots from the server based on the specified request parameters.
  ///
  /// This method utilizes the `AIChatBotClient` to perform the actual network call. The `GetAIChatbotsRequest` object
  /// contains the criteria for fetching chatbots (such as page number and page size), and `GetAIChatbotsResponse` models
  /// the server's response, typically including a list of chatbots and pagination metadata.
  ///
  /// - Parameters:
  ///   - request: A `GetAIChatbotsRequest` object containing parameters such as page number and page size.
  ///   - response: A closure to handle the server response, which includes either the successful `GetAIChatbotsResponse` data
  ///               or an error message in case of failure.
  ///
  /// - Example:
  /// ```swift
  /// let request = GetAIChatbotsRequest.builder()
  ///     .page(1)
  ///     .pageSize(10)
  ///     .build()
  ///
  /// LMChatClient.shared.getAIChatbots(request: request) { result in
  ///     switch result {
  ///     case .success(let responseData):
  ///         print("Fetched \(responseData.users?.count ?? 0) chatbots.")
  ///         print("Current page: \(responseData.page)")
  ///         print("Total pages: \(responseData.totalPages)")
  ///     case .failure(let error):
  ///         print("Failed to get chatbots: \(error.localizedDescription)")
  ///     }
  /// }
  /// ```
  public func getAIChatbots(
    request: GetAIChatbotsRequest,
    response: LMClientResponse<GetAIChatbotsResponse>?
  ) {

    AIChatBotsClient.getAIChatbots(
      request: request,
      withModuleName: moduleName,
      response
    )
  }

}
