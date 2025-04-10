//
//  ChatroomClient.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

class ChatroomClient: ServiceRequest {

    let moduleName = "ChatroomClient"
    static let shared = ChatroomClient()
    /**
     * Converts client request model to internal model and calls the api
     * @param getChatroomRequest - client request model to fetch chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return GetChatroomResponse - GetChatroomResponse model for getChatroomRequest
     */
    func getChatroom(request: GetChatroomRequest) -> LMResponse<
        GetChatroomResponse
    >? {

        guard
            let chatroomRO = ChatroomDBService.shared.getChatroom(
                chatroomId: request.chatroomId)
        else {
            return LMResponse.failureResponse("Chatroom not present!")
        }
        guard
            let chatroom = ModelConverter.shared.convertChatroomRO(
                chatroomRO: chatroomRO)
        else {
            return LMResponse.failureResponse("Chatroom conversion failed!")
        }
        let chatroomResponse = GetChatroomResponse(chatroom: chatroom)
        return LMResponse.successResponse(chatroomResponse)
    }

    /**
     * Converts client request model to internal model and calls the api
     * @param getChatroomActionRequest - client request model to fetch chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return [GetChatroomActionsResponse] - GetChatroomActionsResponse model for [getChatroomActions]
     */
    func getChatroomActions(
        request: GetChatroomActionsRequest,
        response: LMClientResponse<GetChatroomActionsResponse>?
    ) {
        let networkPath = ServiceAPIRequest.NetworkPath.getChatroomActions(
            request)
        guard
            let url: URL = URL(
                string: ServiceAPI.authBaseURL + networkPath.apiURL)
        else { return }
        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeadersWithAPIVersion(extraHeaders: [
                "x-accept-version": "v2"
            ]),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: GetChatroomActionsResponse.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            guard
                let data = responseData
                    as? LMResponse<GetChatroomActionsResponse>
            else { return }
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    /**
     * Converts client request model to internal model and calls the api
     * @param followChatroomRequest - client request model to follow a chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func followChatroom(
        request: FollowChatroomRequest, response: LMClientResponse<NoData>?
    ) {
        let networkPath = ServiceAPIRequest.NetworkPath.followChatroom(request)
        guard
            let url: URL = URL(
                string: ServiceAPI.authBaseURL + networkPath.apiURL)
        else { return }
        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeaders(),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: NoData.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<NoData> else { return }
            if data.success {
                ChatroomDBService.shared.updateChatroomFollow(
                    chatroomId: request.chatroomId, status: request.value)
            }
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    /**
     * Converts client request model to internal model and calls the api
     * @param leaveSecretChatroomRequest - client request model to leave a secret chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func leaveSecretChatroom(
        request: LeaveSecretChatroomRequest, response: LMClientResponse<NoData>?
    ) {
        let networkPath = ServiceAPIRequest.NetworkPath.leaveSecretChatroom(
            request)
        guard
            let url: URL = URL(
                string: ServiceAPI.authBaseURL + networkPath.apiURL)
        else { return }
        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeaders(),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: NoData.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<NoData> else { return }
            if data.success {
                ChatroomDBService.shared.updateChatroomFollow(
                    chatroomId: request.chatroomId, status: false)
            }
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    /**
     * Converts client request model to internal model and calls the api
     * @param muteChatroomRequest - client request model to mute secret chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func muteChatroom(
        request: MuteChatroomRequest, response: LMClientResponse<NoData>?
    ) {
        let networkPath = ServiceAPIRequest.NetworkPath.muteChatroom(request)
        guard
            let url: URL = URL(
                string: ServiceAPI.authBaseURL + networkPath.apiURL)
        else { return }
        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeaders(),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: NoData.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<NoData> else { return }
            if data.success {
                ChatroomDBService.shared.updateChatroomMuteUnMute(
                    chatroomId: request.chatroomId, status: request.value)
            }
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    /**
     * Converts client request model to internal model and calls the api
     * @param markReadChatroomRequest - client request model to mark chatroom as read
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func markReadChatroom(
        request: MarkReadChatroomRequest, response: LMClientResponse<NoData>?
    ) {

        let networkPath = ServiceAPIRequest.NetworkPath.markReadChatroom(
            request)
        guard
            let url: URL = URL(
                string: ServiceAPI.authBaseURL + networkPath.apiURL)
        else { return }
        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeaders(),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: NoData.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<NoData> else { return }
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    /**
     * Converts client request model to internal model and calls the api
     * @param setChatroomTopicRequest - client request model to set a conversation as topic for chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func setChatroomTopic(
        request: SetChatroomTopicRequest, response: LMClientResponse<NoData>?
    ) {
        let networkPath = ServiceAPIRequest.NetworkPath.setChatroomTopic(
            request)
        guard
            let url: URL = URL(
                string: ServiceAPI.authBaseURL + networkPath.apiURL)
        else { return }
        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeaders(),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: NoData.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<NoData> else { return }
            if data.success {
                ChatroomDBService.shared.updateChatroomTopic(
                    chatroomId: request.chatroomId,
                    topicId: request.conversationId)
            }
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    /**
     * Converts client request model to internal model and calls the api
     * @param getParticipantsRequest - client request model to get list of participants in chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return GetParticipantsResponse - GetParticipantsResponse model for getParticipantsRequest
     */
    func getParticipants(
        request: GetParticipantsRequest,
        response: LMClientResponse<GetParticipantsResponse>?
    ) {
        let networkPath = ServiceAPIRequest.NetworkPath.getParticipants(request)
        guard
            let url: URL = URL(
                string: ServiceAPI.authBaseURL + networkPath.apiURL)
        else { return }
        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeaders(),
            withEncoding: networkPath.encoding,
            withResponseType: GetParticipantsResponse.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            guard
                let data = responseData as? LMResponse<GetParticipantsResponse>
            else { return }
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    /**
     * sets last seen to true and saves draft response
     * @param updateLastSeenAndDraftRequest - client request model to get list of participants in chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     */
    func updateLastSeenAndDraft(
        updateLastSeenAndDraftRequest: UpdateLastSeenAndDraftRequest
    ) {

    }

    /**
     * Converts client request model to internal model and calls the api
     * @param editChatroomTitleRequest - client request model to edit a chatroom title
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func editChatroomTitle(
        request: EditChatroomTitleRequest, response: LMClientResponse<NoData>?
    ) {
        let networkPath = ServiceAPIRequest.NetworkPath.editChatroomTitle(
            request)
        guard
            let url: URL = URL(
                string: ServiceAPI.authBaseURL + networkPath.apiURL)
        else { return }
        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeaders(),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: NoData.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<NoData> else { return }
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    static func syncChatroomsApi(
        request: ChatroomSyncRequest, moduleName: String,
        _ response: LMClientResponse<_SyncChatroomResponse_>?
    ) {
        let networkPath = ServiceAPIRequest.NetworkPath.syncChatrooms(request)
        guard
            let url: URL = URL(
                string: ServiceAPI.authBaseURL + networkPath.apiURL)
        else { return }
        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeaders(),
            withEncoding: networkPath.encoding,
            withResponseType: _SyncChatroomResponse_.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<_SyncChatroomResponse_>
            else { return }
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    /// Retrieves a list of channel invites from the server based on the specified request parameters.
    ///
    /// - Parameters:
    ///   - request: A `GetChannelInvitesRequest` object containing parameters such as the channel type, page number, and page size.
    ///   - response: An optional closure to handle the server response, which includes either the successful `GetChannelInvitesResponse` data or an error message.
    func getChannelInvites(
        request: GetChannelInvitesRequest,
        response: LMClientResponse<GetChannelInvitesResponse>?
    ) {
        // The NetworkPath for `getChannelInvites` is constructed with the request.
        // This typically defines the specific endpoint and parameters needed to fetch the channel invites.
        let networkPath = ServiceAPIRequest.NetworkPath.getChannelInvites(
            request)

        // Combines the base URL (authBaseURL) with the endpoint (apiURL) to form the complete URL.
        // If this fails to produce a valid URL, we return early.
        guard let url = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL)
        else {
            // An early return is used here to ensure we don't proceed with an invalid URL.
            return
        }

        // Makes a network request using a shared `DataNetwork` instance.
        // `requestWithDecoded` automatically decodes the server response into the specified type,
        // in this case `GetChannelInvitesResponse`.
        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeaders(),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: GetChannelInvitesResponse.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            // Ensures that the responseData matches the expected `LMResponse<GetChannelInvitesResponse>` type
            // before passing it to the response closure.
            guard
                let data = responseData
                    as? LMResponse<GetChannelInvitesResponse>
            else {
                // If the cast fails, the response can't be handled correctly, so we return early.
                return
            }

            // If everything is valid, invoke the success response closure with the data.
            response?(data)
        } failureCallback: { (moduleName, error) in
            // In case of failure, wrap the error description in an LMResponse
            // and invoke the response closure with a failure response.
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    /// Updates the status of a secret chatroom invite on the server (e.g., accept or reject).
    ///
    /// - Parameters:
    ///   - request: An `UpdateChannelInviteRequest` object containing the channel ID and the desired invite status.
    ///   - response: An optional closure to handle the server response, which includes either a successful `NoData` object or an error message.
    func updateChannelInvite(
        request: UpdateChannelInviteRequest,
        response: LMClientResponse<NoData>?
    ) {
        // The NetworkPath for `updateChannelInvite` is constructed with the request.
        // This typically defines the specific endpoint and parameters needed to update the invite.
        let networkPath = ServiceAPIRequest.NetworkPath.updateChannelInvite(
            request)

        // Combines the base URL (authBaseURL) with the endpoint (apiURL) to form the complete URL.
        // If this fails to produce a valid URL, we return early.
        guard let url = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL)
        else {
            // An early return is used here to ensure we don't proceed with an invalid URL.
            return
        }

        // Makes a network request using a shared `DataNetwork` instance.
        // `requestWithDecoded` automatically decodes the server response into the specified type,
        // in this case `NoData` since there's no actual response model.
        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeaders(),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: NoData.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            // Ensures that the responseData matches the expected `LMResponse<NoData>` type
            // before passing it to the response closure.
            guard let data = responseData as? LMResponse<NoData> else {
                // If the cast fails, the response can't be handled correctly, so we return early.
                return
            }

            // If everything is valid, invoke the success response closure with the data.
            response?(data)
        } failureCallback: { (moduleName, error) in
            // In case of failure, wrap the error description in an LMResponse
            // and invoke the response closure with a failure response.
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    /// Fetches an existing DM chatroom for a given user UUID
    /// - Parameter userUUID: The UUID of the user
    /// - Returns: `LMResponse` containing the converted Chatroom or error
    func getExistingDMChatroom(getExisingDMChatroomRequest: GetExistingDMChatroomRequest) -> LMResponse<Chatroom> {
        guard
            let chatroomRO = ChatroomDBService.shared.getExistingDMChatroom(
                userUUID: getExisingDMChatroomRequest.userUUID)
        else {
            return LMResponse.failureResponse("No existing DM chatroom found.")
        }

        guard
            let chatroom = ModelConverter.shared.convertChatroomRO(
                chatroomRO: chatroomRO)
        else {
            return LMResponse.failureResponse("Failed to convert chatroom.")
        }

        return LMResponse.successResponse(chatroom)
    }
}
