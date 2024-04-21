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
    func getChatroom(request: GetChatroomRequest, response: LMClientResponse<GetChatroomResponse>?) {
        
        guard let chatroomRO = ChatroomDBService.shared.getChatroom(chatroomId: request.chatroomId) else {
            response?(LMResponse.failureResponse("Chatroom not present!"))
            return
        }
        guard let chatroom = ModelConverter.shared.convertChatroomRO(chatroomRO: chatroomRO) else {
            response?(LMResponse.failureResponse("Chatroom conversion failed!"))
            return
        }
        
        let chatroomResponse = GetChatroomResponse(chatroom: chatroom)
        response?(LMResponse.successResponse(chatroomResponse))
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param getChatroomActionRequest - client request model to fetch chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return [GetChatroomActionsResponse] - GetChatroomActionsResponse model for [getChatroomActions]
     */
    func getChatroomActions(request: GetChatroomActionsRequest, response: LMClientResponse<GetChatroomActionsResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.getChatroomActions(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: GetChatroomActionsResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<GetChatroomActionsResponse> else {return}
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
    func followChatroom(request: FollowChatroomRequest, response: LMClientResponse<NoData>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.followChatroom(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: NoData.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<NoData> else {return}
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
    func leaveSecretChatroom(request: LeaveSecretChatroomRequest, response: LMClientResponse<NoData>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.leaveSecretChatroom(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: NoData.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<NoData> else {return}
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
    func muteChatroom(request: MuteChatroomRequest, response: LMClientResponse<NoData>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.muteChatroom(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: NoData.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<NoData> else {return}
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
    func markReadChatroom(request: MarkReadChatroomRequest, response: LMClientResponse<NoData>?) {
        
        let networkPath = ServiceAPIRequest.NetworkPath.markReadChatroom(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: NoData.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<NoData> else {return}
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
    func setChatroomTopic(request: SetChatroomTopicRequest, response: LMClientResponse<NoData>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.setChatroomTopic(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: NoData.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<NoData> else {return}
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
    func getParticipants(request: GetParticipantsRequest, response: LMClientResponse<GetParticipantsResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.getParticipants(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withEncoding: networkPath.encoding,
                                              withResponseType: GetParticipantsResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<GetParticipantsResponse> else {return}
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
    func updateLastSeenAndDraft(updateLastSeenAndDraftRequest: UpdateLastSeenAndDraftRequest) {
       
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param editChatroomTitleRequest - client request model to edit a chatroom title
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func editChatroomTitle(request: EditChatroomTitleRequest, response: LMClientResponse<NoData>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.editChatroomTitle(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: NoData.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<NoData> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    static func syncChatroomsApi(request: ChatroomSyncRequest, moduleName: String, _ response: LMClientResponse<_SyncChatroomResponse_>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.syncChatrooms(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withEncoding: networkPath.encoding,
                                              withResponseType: _SyncChatroomResponse_.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<_SyncChatroomResponse_> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
}
