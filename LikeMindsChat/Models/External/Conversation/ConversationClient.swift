//
//  ConversationClient.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 11/01/24.
//

import FirebaseDatabase
import Foundation
import RealmSwift

class ConversationClient: ServiceRequest {

    let moduleName: String = "ConversationClient"
    static let shared = ConversationClient()

    private var notificationToken: NotificationToken?
    private var conversations: Results<ConversationRO>?
    private var observers: [ConversationChangeDelegate?] = []
    private var firebaseRealTimeDBReference: DatabaseReference?

    func addObserver(_ ob: ConversationChangeDelegate) {
        guard observers.first(where: { type(of: $0) == type(of: ob) }) == nil
        else { return }
        observers.append(ob)
    }
    /**
     * Converts client request model to internal model and calls the api
     * @param postConversationRequest - client request model to post a conversation
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<PostConversationResponse> - Base LM response[PostConversationResponse]
     */
    func postConversation(
        request: PostConversationRequest,
        response: LMClientResponse<PostConversationResponse>?
    ) {
        let networkPath = ServiceAPIRequest.NetworkPath.postConversation(
            request
        )
        let endpoint = networkPath.apiURL
        guard let url = endpoint.url else {
            response?(LMResponse.failureResponse("Invalid URL"))
            return
        }

        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeaders(),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: PostConversationResponse.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            guard
                let data = responseData as? LMResponse<PostConversationResponse>
            else { return }
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    /**
     * Converts client request model to internal model and stores the posted conversation in DB
     * @param savePostedConversationRequest - client request model to store a posted conversation
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     */
    func savePostedConversation(request: SavePostedConversationRequest) {
        ConversationDBService.shared.savePostedConversation(
            savePostedConversationRequest: request
        )
    }

    func removeObserverConversation(
        _ ob: ConversationChangeDelegate
    ) {
        observers.removeAll(where: { type(of: $0) != type(of: ob) })
    }

    /**
     * runs the query for observing new conversations and returns the data in listener
     * @param observeConversationsRequest: [ObserveConversationsRequest] request for observing new conversation
     *
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     */
    func observeConversations(
        request: ObserveConversationsRequest
    ) {
        guard let communityId = SDKPreferences.shared.getCommunityId() else {
            return
        }
        //        addObserver(request.listener)
        conversations = ConversationDBService.shared.getChatroomConversations(
            chatroomId: request.chatroomId,
            filterConversations: LMChatClient.shared.excludedConversationStates
        )
        // Observe collection notifications. Keep a strong
        // reference to the notification token or the
        // observation will stop.
        notificationToken = conversations?.observe {
            [weak self] (changes: RealmCollectionChange) in
            guard let self else { return }
            switch changes {
            case .initial:
                break
            case .update(
                let collections,
                let deletions,
                let insertions,
                let modifications
            ):

                observers.forEach {
                    $0?.getNewConversations(
                        conversations: self.getIndexedConversations(
                            indexArray: insertions
                        )
                    )
                    //                    $0?.getPostedConversations(conversations: self.getIndexedConversations(indexArray: modifications))
                    $0?.getChangedConversations(
                        conversations: self.getIndexedConversations(
                            indexArray: modifications
                        )
                    )
                }
                break
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }

    /**
     * returns list of [ConversationRO] as per indexes received in
     * @param indexes
     */
    private func getConversationFromChanges(
        list: Results<ConversationRO>,
        indexes: [Int]?
    ) -> [ConversationRO]? {
        if list.isEmpty {
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
        if type == .firstTime {
            SyncOperationUtil.startFirstTimeSyncConversations(
                chatroomId: chatroomId
            ) { response in
                // Do somthing with response
            }
        } else if type == .reopen {
            SyncOperationUtil.reopenSyncConversations(chatroomId: chatroomId) {
                response in
                // Do somthing with response
            }
        }
    }

    func loadConversation(
        withConversationId conversationId: String,
        chatroomId: String
    ) {
        let maxTimestamp = Date().millisecondsSince1970
        let conversationSyncRequest = ConversationSyncRequest.builder()
            .page(1)
            .chatroomId(chatroomId)
            .conversationId(conversationId)
            .pageSize(500)
            .minTimestamp(0)
            .maxTimestamp(Int(maxTimestamp))
            .build()
        Self.syncConversationsApi(
            request: conversationSyncRequest,
            moduleName: "ConversationClient"
        ) {
            response in

            if response.errorMessage != nil {
                // retry
            } else if let chatrooms = response.data?.conversations,
                chatrooms.isEmpty
            {
                // No data but success
                return
            } else {
                guard let data = response.data else {
                    // retry flow
                    return
                }
                SyncUtil.saveConversationResponses(
                    chatroomId: chatroomId,
                    communityId: SDKPreferences.shared.getCommunityId() ?? "",
                    loggedInUUID: UserPreferences.shared.getClientUUID() ?? "",
                    dataList: [data]
                )
            }
        }
    }

    /**
     * runs the query and returns the conversations as per situations
     * @param getConversationsRequest - client request model to get conversations
     *
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<GetConversationsResponse> - Base LM response[GetConversationsResponse]
     */
    func getConversations(request: GetConversationsRequest) -> LMResponse<
        GetConversationsResponse
    >? {

        switch request.type {
        case .above:
            return getAboveConversations(
                chatroomId: request.chatroomId,
                limit: request.limit,
                conversation: request.conversation
            )
        case .below:
            return getBelowConversations(
                chatroomId: request.chatroomId,
                limit: request.limit,
                belowConversation: request.conversation
            )
        case .top:
            return getTopConversations(
                chatroomId: request.chatroomId,
                limit: request.limit
            )
        case .bottom:
            return getBottomConversations(
                chatroomId: request.chatroomId,
                limit: request.limit
            )
        case .none:
            break
        }
        return LMResponse.failureResponse("Failed to fetch conversations!")
    }

    private func getIndexedConversations(indexArray: [Int]) -> [Conversation] {
        return indexArray.compactMap { index in
            let conversationRO = conversations?[index]
            let conversation = ModelConverter.shared.convertConversationRO(
                conversationRO
            )
            return conversation
        }
    }
    /*
     private func getIndexedConversations(indexArray: [Int]) -> [(Int, Conversation)] {
         return indexArray.compactMap {  index in
             let conversationRO = conversations?[index]
             let conversation = ModelConverter.shared.convertConversationRO(conversationRO)
             return (index, conversation) as? (Int, Conversation)
         }
     }
     */

    //get conversations below a particular conversation
    private func getBelowConversations(
        chatroomId: String,
        limit: Int,
        belowConversation: Conversation?
    ) -> LMResponse<GetConversationsResponse>? {
        guard
            let topConversations = ConversationDBService.shared
                .getBelowConversations(
                    chatroomId: chatroomId,
                    limit: limit,
                    timestmap: belowConversation?.createdEpoch ?? 0,
                    filterConversations: LMChatClient.shared
                        .excludedConversationStates
                )?.compactMap({ ro in
                    ModelConverter.shared.convertConversationRO(ro)
                })
        else {
            return LMResponse.failureResponse(
                "Unable to fetch below conversations!"
            )
        }
        let responseData = GetConversationsResponse(
            conversations: Array(topConversations)
        )
        return LMResponse.successResponse(responseData)
    }

    //get conversations above a particular conversation
    private func getAboveConversations(
        chatroomId: String,
        limit: Int,
        conversation: Conversation?
    ) -> LMResponse<GetConversationsResponse>? {
        guard
            let topConversations = ConversationDBService.shared
                .getAboveConversations(
                    chatroomId: chatroomId,
                    limit: limit,
                    timestmap: conversation?.createdEpoch ?? 0,
                    filterConversations: LMChatClient.shared
                        .excludedConversationStates
                )?.compactMap({ ro in
                    ModelConverter.shared.convertConversationRO(ro)
                })
        else {
            return LMResponse.failureResponse(
                "Unable to fetch above conversations!"
            )
        }
        let responseData = GetConversationsResponse(
            conversations: Array(topConversations)
        )
        return LMResponse.successResponse(responseData)
    }

    //get conversations from start of a chatroom
    private func getTopConversations(
        chatroomId: String,
        limit: Int
    ) -> LMResponse<GetConversationsResponse>? {
        guard
            let topConversations = ConversationDBService.shared
                .getTopConversations(
                    chatroomId: chatroomId,
                    limit: limit,
                    filterConversations: LMChatClient.shared
                        .excludedConversationStates
                )?.compactMap({ ro in
                    ModelConverter.shared.convertConversationRO(ro)
                })
        else {
            return LMResponse.failureResponse(
                "Unable to fetch top conversations!"
            )
        }
        var responseData = GetConversationsResponse(
            conversations: Array(topConversations)
        )
        return LMResponse.successResponse(responseData)
    }

    //get conversations from end of a chatroom
    private func getBottomConversations(
        chatroomId: String,
        limit: Int
    ) -> LMResponse<GetConversationsResponse>? {
        guard
            let topConversations = ConversationDBService.shared
                .getBottomConversations(
                    chatroomId: chatroomId,
                    limit: limit,
                    filterConversations: LMChatClient.shared
                        .excludedConversationStates
                )?.compactMap({ ro in
                    ModelConverter.shared.convertConversationRO(ro)
                })
        else {
            return LMResponse.failureResponse(
                "Unable to fetch Bottom conversations!"
            )
        }
        let responseData = GetConversationsResponse(
            conversations: Array(topConversations)
        )
        return LMResponse.successResponse(responseData)
    }

    /**
     * runs the query and returns the conversations above count
     * @param getConversationsCountRequest - client request model to get conversations count
     *
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<GetConversationsResponse> - Base LM response[GetConversationsResponse]
     */
    func getConversationsCount(
        getConversationsCountRequest: GetConversationsCountRequest,
        response: LMClientResponse<GetConversationsCountResponse>
    ) {
    }

    // gets count of conversations above the provided conversation
    private func getConversationsAboveCount(
        chatroomId: String,
        conversationId: String,
        createdEpoch: Int,
        response: LMClientResponse<GetConversationsCountResponse>
    ) {
    }

    // gets count of conversations below the provided conversation
    private func getConversationsBelowCount(
        chatroomId: String,
        conversationId: String,
        createdEpoch: Int,
        response: LMClientResponse<GetConversationsCountResponse>
    ) {
    }

    /**
     * deletes a conversation from local db permanently
     * @param deleteConversationPermanentlyRequest - client request model to delete a conversation from local db permanently
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * */
    func deleteConversationPermanently(
        deleteConversationPermanentlyRequest:
            DeleteConversationPermanentlyRequest
    ) {
    }

    /**
     * save conversation in local db
     * @param saveConversationRequest - client request model to save a temporary conversation
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * */
    func saveTemporaryConversation(
        saveConversationRequest: SaveConversationRequest
    ) {
        ConversationDBService.shared.saveTemporaryConversation(
            request: saveConversationRequest
        )
    }

    /**
     * updates a conversation in local db
     * @param updateConversationRequest - client request model to update the conversation in local db
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * */
    func updateConversation(
        updateConversationRequest: UpdateConversationRequest
    ) {
    }

    func updateConversationUploadingStatus(
        withConversationId id: String,
        withStatus status: ConversationStatus
    ) {
        ConversationDBService.shared.updateConversationUploadingStatus(
            conversationId: id,
            withStatus: status
        )
    }

    /**
     * updates temporary conversation in local db
     * @param updateTemporaryConversationRequest - client request model to update temporary conversation
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * */
    func updateTemporaryConversation(
        updateTemporaryConversationRequest: UpdateTemporaryConversationRequest
    ) {
    }

    /**
     * return a single conversation from local db
     * @param getConversationRequest: client request model to get a conversation
     *
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<GetConversationResponse> - Base LM response[GetConversationResponse]
     */
    func getConversation(getConversationRequest: GetConversationRequest)
        -> Conversation?
    {
        let conversationRO = ConversationDBService.shared.getConversation(
            conversationId: getConversationRequest.conversationId
        )
        return ModelConverter.shared.convertConversationRO(conversationRO)
    }

    func decodeUrl(
        request: DecodeUrlRequest,
        response: LMClientResponse<DecodeUrlResponse>?
    ) {
        let networkPath = ServiceAPIRequest.NetworkPath.decodeUrl(request)
        let endpoint = networkPath.apiURL
        guard let url = endpoint.url else {
            response?(LMResponse.failureResponse("Invalid URL"))
            return
        }

        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeaders(),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: DecodeUrlResponse.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<DecodeUrlResponse>
            else { return }
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    /**
     * Converts client request model to internal model and calls the api
     * @param editConversationRequest - client request model to edit a conversation
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<EditConversationResponse> - Base LM response[EditConversationResponse]
     */
    func editConversation(
        request: EditConversationRequest,
        response: LMClientResponse<EditConversationResponse>?
    ) {
        let networkPath = ServiceAPIRequest.NetworkPath.editConversation(
            request
        )
        let endpoint = networkPath.apiURL
        guard let url = endpoint.url else {
            response?(LMResponse.failureResponse("Invalid URL"))
            return
        }

        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeaders(),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: EditConversationResponse.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            guard
                let data = responseData as? LMResponse<EditConversationResponse>
            else { return }
            if let conversation = data.data?.conversation {
                ConversationDBService.shared.updateEditedConversation(
                    conversation: conversation
                )
            }
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    /**
     * Converts client request model to internal model and calls the api
     * @param deleteConversationsRequest - client request model to delete conversations
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<DeleteConversationRequest> - Base LM response[DeleteConversationsRequest]
     */
    func deleteConversations(
        request: DeleteConversationsRequest,
        response: LMClientResponse<DeleteConversationsResponse>?
    ) {
        let networkPath = ServiceAPIRequest.NetworkPath.deleteConversations(
            request
        )
        let endpoint = networkPath.apiURL
        guard let url = endpoint.url else {
            response?(LMResponse.failureResponse("Invalid URL"))
            return
        }

        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeaders(),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: DeleteConversationsResponse.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            guard
                let data = responseData
                    as? LMResponse<DeleteConversationsResponse>
            else { return }
            if let conversations = data.data?.conversations {
                ConversationDBService.shared.updateDeletedConversations(
                    conversations: conversations
                )
            }
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    func deleteTempConversation(conversationId: String) {
        ConversationDBService.shared.deletedTempConversations(
            conversationId: conversationId
        )
    }

    /**
     * Converts client request model to internal model and calls the api
     * @param putReactionRequest - client request model to put a reaction on a conversation
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func putReaction(
        request: PutReactionRequest,
        response: LMClientResponse<NoData>?
    ) {
        let networkPath = ServiceAPIRequest.NetworkPath.putReaction(request)
        let endpoint = networkPath.apiURL
        guard let url = endpoint.url else {
            response?(LMResponse.failureResponse("Invalid URL"))
            return
        }

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
            if let conversationId = request.conversationId {
                ConversationDBService.shared.updateConversationReaction(
                    reaction: request.reaction,
                    conversationId: conversationId
                )
            }
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    func markRead(
        request: MarkReadChatroomRequest,
        response: LMClientResponse<NoData>?
    ) {
        let networkPath = ServiceAPIRequest.NetworkPath.markReadChatroom(
            request
        )
        let endpoint = networkPath.apiURL
        guard let url = endpoint.url else {
            response?(LMResponse.failureResponse("Invalid URL"))
            return
        }

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
     * @param deleteReactionRequest - client request model to delete a reaction on a conversation
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func deleteReaction(
        request: DeleteReactionRequest,
        response: LMClientResponse<NoData>?
    ) {

        let networkPath = ServiceAPIRequest.NetworkPath.deleteReaction(request)
        let endpoint = networkPath.apiURL
        guard let url = endpoint.url else {
            response?(LMResponse.failureResponse("Invalid URL"))
            return
        }
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
            if data.success, let conversationId = request.conversationId {
                ConversationDBService.shared.deleteReaction(
                    conversationId: conversationId
                )
            }
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    static func syncConversationsApi(
        request: ConversationSyncRequest,
        moduleName: String,
        _ response: LMClientResponse<_SyncConversationResponse_>?
    ) {
        let networkPath = ServiceAPIRequest.NetworkPath.syncConversations(
            request
        )
        let endpoint = networkPath.apiURL
        guard let url = endpoint.url else {
            response?(LMResponse.failureResponse("Invalid URL"))
            return
        }

        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeaders(),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: _SyncConversationResponse_.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            guard
                let data = responseData
                    as? LMResponse<_SyncConversationResponse_>
            else { return }
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    func getTaggingList(
        request: GetTaggingListRequest,
        response: LMClientResponse<GetTaggingListResponse>?
    ) {
        let networkPath = ServiceAPIRequest.NetworkPath.getTaggingList(request)
        let endpoint = networkPath.apiURL
        guard let url = endpoint.url else {
            response?(LMResponse.failureResponse("Invalid URL"))
            return
        }

        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeaders(),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: GetTaggingListResponse.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<GetTaggingListResponse>
            else { return }
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    func observeChatRoomLatestConversations(forChatRoomID chatRoomID: String?) {
        guard let chatRoomID else {
            firebaseRealTimeDBReference?.removeAllObservers()
            return
        }
        firebaseRealTimeDBReference =
            FirebaseServiceConfiguration.getDatabaseReferenceForConversation(
                chatRoomID
            )
        FireBaseFactoryClass.shared.getDataForQuery(firebaseRealTimeDBReference)
        { [weak self] entity in
            guard let data = entity else { return }
            do {
                guard
                    let json = try JSONSerialization.jsonObject(
                        with: data,
                        options: .allowFragments
                    )
                        as? [String: Any],
                    let answerId = json["answer_id"] as? String
                else { return }
                self?.loadConversation(
                    withConversationId: answerId,
                    chatroomId: chatRoomID
                )
            } catch let error {
                print("json error parsing - \(#function) \(error)")
            }
        }
    }

    func getMember(_ uuid: String) -> Member? {
        guard let memberRO = ConversationDBService.shared.getMemberBy(uuid),
            let member = ModelConverter.shared.convertMemberRO(memberRO)
        else { return nil }
        return member
    }

    /**
     * Updates an attachment in the local database
     * @param attachment - The attachment to update
     * @return LMResponse<NoData> - Response indicating success or failure of the update operation
     */
    func updateAttachment(attachment: Attachment) async -> LMResponse<NoData> {
        await ConversationDBService.shared.updateAttachment(
            attachment: attachment
        )
    }

    /**
     * Updates a conversation in the local database
     * @param conversation - The conversation to update
     * @return LMResponse<NoData> - Response indicating success or failure of the update operation
     */
    func updateConversation(conversation: Conversation) async -> LMResponse<
        NoData
    > {
        await ConversationDBService.shared.updateConversation(
            conversation: conversation
        )
    }

    /**
     * Updates the last conversation in the database for a given conversation.
     * This method converts the provided conversation to a LastConversationRO and updates it in the database.
     *
     * - Parameter conversation: The conversation to be converted and stored as the last conversation
     */
    func updateLastConversation(conversation: Conversation) {
        ConversationDBService.shared.updateLastConversation(
            conversation: conversation
        )
    }

    /**
     * Updates the last conversation model in the chatroom with the provided conversation.
     * This method updates the chatroom's last conversation references and stores the conversation in the database.
     *
     * - Parameters:
     *   - chatroomId: The ID of the chatroom whose last conversation needs to be updated
     *   - conversation: The conversation to be set as the last conversation
     */
    func updateLastConversationModel(
        chatroomId: String,
        conversation: Conversation
    ) {
        ConversationDBService.shared.updateLastConversationModel(
            chatroomId: chatroomId,
            conversation: conversation
        )
    }

}
