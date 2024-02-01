//
//  ChatroomClient.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

class ChatroomClient: ServiceRequest {
    
    let moduleName = "ChatroomClient"
    
    /**
     * Converts client request model to internal model and calls the api
     * @param getChatroomRequest - client request model to fetch chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return GetChatroomResponse - GetChatroomResponse model for getChatroomRequest
     */
    func getChatroom(getChatroomRequest: GetChatroomRequest, response: LMClientResponse<GetChatroomResponse>?) {
        // validates the client request
//        RequestUtils.validate()
//        validateGetChatroomRequest(getChatroomRequest)
        
//        val realm = Realm.getDefaultInstance()
//        val chatroomRO = chatroomDB.getChatroom(realm, getChatroomRequest.chatroomId)
//        val getChatroomResponse = ModelConverter.convertGetChatroomResponse(chatroomRO)
//        val chatroom = getChatroomResponse.chatroom
//        realm.close()
//        return if (chatroom == null) {
//            LMResponse(
//                success = false,
//                errorMessage = "Chatroom with respect to chatroomId not found."
//            )
//        } else {
//            LMResponse(
//                success = true,
//                errorMessage = null,
//                getChatroomResponse
//            )
//        }
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param getChatroomActionRequest - client request model to fetch chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return [GetChatroomActionsResponse] - GetChatroomActionsResponse model for [getChatroomActions]
     */
    func getChatroomActions(request: GetChatroomActionsRequest, response: _LMClientResponse_<GetChatroomActionsResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.getChatroomActions(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: GetChatroomActionsResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? _LMResponse_<GetChatroomActionsResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param followChatroomRequest - client request model to follow a chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func followChatroom(followChatroomRequest: FollowChatroomRequest, response: LMClientResponse<NoData>) {
        
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param leaveSecretChatroomRequest - client request model to leave a secret chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func leaveSecretChatroom(request: LeaveSecretChatroomRequest, response: _LMClientResponse_<_NoData_>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.leaveSecretChatroom(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: _NoData_.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? _LMResponse_<_NoData_> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param muteChatroomRequest - client request model to mute secret chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func muteChatroom(request: MuteChatroomRequest, response: _LMClientResponse_<_NoData_>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.muteChatroom(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: _NoData_.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? _LMResponse_<_NoData_> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param markReadChatroomRequest - client request model to mark chatroom as read
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func markReadChatroom(request: MarkReadChatroomRequest, response: _LMClientResponse_<_NoData_>?) {
        
        let networkPath = ServiceAPIRequest.NetworkPath.markReadChatroom(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: _NoData_.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? _LMResponse_<_NoData_> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param setChatroomTopicRequest - client request model to set a conversation as topic for chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func setChatroomTopic(request: SetChatroomTopicRequest, response: _LMClientResponse_<_NoData_>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.setChatroomTopic(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: _NoData_.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? _LMResponse_<_NoData_> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param getParticipantsRequest - client request model to get list of participants in chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return GetParticipantsResponse - GetParticipantsResponse model for getParticipantsRequest
     */
    func getParticipants(request: GetParticipantsRequest, response: _LMClientResponse_<GetParticipantsResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.getParticipants(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withEncoding: networkPath.encoding,
                                              withResponseType: GetParticipantsResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? _LMResponse_<GetParticipantsResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
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
    func editChatroomTitle(request: EditChatroomTitleRequest, response: LMClientResponse<NoData>) {
    }
    
    static func syncChatrooms(request: ChatroomSyncRequest, moduleName: String, _ response: _LMClientResponse_<_SyncChatroomResponse_>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.syncChatrooms(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withEncoding: networkPath.encoding,
                                              withResponseType: _SyncChatroomResponse_.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? _LMResponse_<_SyncChatroomResponse_> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
    
}
