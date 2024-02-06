//
//  ConversationClient.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 11/01/24.
//

import Foundation
import RealmSwift

class ConversationClient: ServiceRequest {
    
    let moduleName: String = "ConversationClient"
    
    /**
     * Converts client request model to internal model and calls the api
     * @param postConversationRequest - client request model to post a conversation
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<PostConversationResponse> - Base LM response[PostConversationResponse]
     */
    func postConversation(request: PostConversationRequest, response: _LMClientResponse_<PostConversationResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.postConversation(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: PostConversationResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? _LMResponse_<PostConversationResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
    
    /**
     * Converts client request model to internal model and stores the posted conversation in DB
     * @param savePostedConversationRequest - client request model to store a posted conversation
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     */
    func savePostedConversation(savePostedConversationRequest: SavePostedConversationRequest) {
        
    }
    
    /**
     * runs the query for observing new conversations and returns the data in listener
     * @param observeConversationsRequest: [ObserveConversationsRequest] request for observing new conversation
     *
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     */
    func observeConversations(
        observeConversationsRequest: ObserveConversationsRequest
    ) {
    }
    
    /**
     * returns list of [ConversationRO] as per indexes received in
     * @param indexes
     */
    private func getConversationFromChanges(
        list: Results<ConversationRO>,
        indexes: [Int]?
    ) -> [ConversationRO]? {
        if (list.isEmpty) {
            return nil
        }
        return indexes?.map({ index in
            list[index]
        })
    }
    
    /**
     * runs the worker as per [LoadConversationType] and save data in local db
     */
    func loadConversations(
        type: LoadConversationType,
        chatroomId: String
    ) {
       /*
        return when (type) {
            LoadConversationType.FIRST_TIME -> {
                SyncSDK.startFirstTimeSyncForChatroom(context, chatroomId)
            }
            
            LoadConversationType.FIRST_TIME_BACKGROUND -> {
                SyncSDK.startFirstTimeBackgroundSync(context, chatroomId)
            }
            
            LoadConversationType.REOPEN -> {
                SyncSDK.startReopenSyncForChatroom(context, chatroomId)
            }
        }*/
    }
    
    /**
     * runs the query and returns the conversations as per situations
     * @param getConversationsRequest - client request model to get conversations
     *
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<GetConversationsResponse> - Base LM response[GetConversationsResponse]
     */
    func getConversations(getConversationsRequest: GetConversationsRequest, response: LMClientResponse<GetConversationsResponse>) {
    }
    
    //get conversations below a particular conversation
    private func getBelowConversations(
        chatroomId: String,
        limit: Int,
        belowConversation: Conversation?, response: LMClientResponse<GetConversationsResponse>) {
    }
    
    //get conversations above a particular conversation
    private func getAboveConversation(
        chatroomId: String,
        limit: Int,
        conversation: Conversation?, response: LMClientResponse<GetConversationsResponse>) {
    }
    
    //get conversations from start of a chatroom
    private func getTopConversations(
        chatroomId: String,
        limit: Int, response: LMClientResponse<GetConversationsResponse>) {
    }
    
    //get conversations from end of a chatroom
    private func getBottomConversations(
        chatroomId: String,
        limit: Int, response: LMClientResponse<GetConversationsResponse>) {
    }
    
    /**
     * runs the query and returns the conversations above count
     * @param getConversationsCountRequest - client request model to get conversations count
     *
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<GetConversationsResponse> - Base LM response[GetConversationsResponse]
     */
    func getConversationsCount(getConversationsCountRequest: GetConversationsCountRequest, response: LMClientResponse<GetConversationsCountResponse>) {
    }
    
    // gets count of conversations above the provided conversation
    private func getConversationsAboveCount(
        chatroomId: String,
        conversationId: String,
        createdEpoch: Int, response: LMClientResponse<GetConversationsCountResponse>) {
    }
    
    // gets count of conversations below the provided conversation
    private func getConversationsBelowCount(
        chatroomId: String,
        conversationId: String,
        createdEpoch: Int, response: LMClientResponse<GetConversationsCountResponse>) {
    }
    
    /**
     * deletes a conversation from local db permanently
     * @param deleteConversationPermanentlyRequest - client request model to delete a conversation from local db permanently
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * */
    func deleteConversationPermanently(deleteConversationPermanentlyRequest: DeleteConversationPermanentlyRequest) {
    }
    
    /**
     * save conversation in local db
     * @param saveConversationRequest - client request model to save a temporary conversation
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * */
    func saveTemporaryConversation(saveConversationRequest: SaveConversationRequest) {
    }
    
    /**
     * updates a conversation in local db
     * @param updateConversationRequest - client request model to update the conversation in local db
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * */
    func updateConversation(updateConversationRequest: UpdateConversationRequest) {
    }
    
    /**
     * updates temporary conversation in local db
     * @param updateTemporaryConversationRequest - client request model to update temporary conversation
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * */
    func updateTemporaryConversation(updateTemporaryConversationRequest: UpdateTemporaryConversationRequest) {
    }
    
    /**
     * return a single conversation from local db
     * @param getConversationRequest: client request model to get a conversation
     *
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<GetConversationResponse> - Base LM response[GetConversationResponse]
     */
    func getConversation(getConversationRequest: GetConversationRequest, response: LMClientResponse<GetConversationResponse>) {
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param editConversationRequest - client request model to edit a conversation
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<EditConversationResponse> - Base LM response[EditConversationResponse]
     */
    func editConversation(request: EditConversationRequest, response: _LMClientResponse_<EditConversationResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.editConversation(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: EditConversationResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? _LMResponse_<EditConversationResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param deleteConversationsRequest - client request model to delete conversations
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<DeleteConversationRequest> - Base LM response[DeleteConversationsRequest]
     */
    func deleteConversations(request: DeleteConversationsRequest, response: _LMClientResponse_<DeleteConversationsResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.deleteConversations(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: DeleteConversationsResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? _LMResponse_<DeleteConversationsResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param putReactionRequest - client request model to put a reaction on a conversation
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func putReaction(request: PutReactionRequest, response: _LMClientResponse_<_NoData_>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.putReaction(request)
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
     * @param deleteReactionRequest - client request model to delete a reaction on a conversation
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func deleteReaction(request: DeleteReactionRequest, response: _LMClientResponse_<_NoData_>?) {
        
        let networkPath = ServiceAPIRequest.NetworkPath.deleteReaction(request)
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
     * @param putMultimediaRequest - client request model to upload a conversation attachment
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<PutMultimediaResponse> - Base LM response[PutMultimediaResponse]
     */
    func putMultimedia(request: PutMultimediaRequest, response: _LMClientResponse_<PutMultimediaResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.putMultimedia(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: PutMultimediaResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? _LMResponse_<PutMultimediaResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
    
    static func syncConversations(request: ConversationSyncRequest, moduleName: String, _ response: _LMClientResponse_<_SyncConversationResponse_>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.syncConversations(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: ServiceRequest.httpHeaders(),
                                   withEncoding: networkPath.encoding, withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
            do {
                let json = try JSONDecoder().decode(_LMResponse_<_SyncConversationResponse_>.self, from: data)
                response?(json)
            } catch {
                response?(_LMResponse_.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
}
