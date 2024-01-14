//
//  ChatroomClient.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

class ChatroomClient {
    
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
    func getChatroomActions(getChatroomActionRequest: GetChatroomActionsRequest, response: LMClientResponse<GetChatroomActionsResponse>) {
        
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
    func leaveSecretChatroom(leaveSecretChatroomRequest: LeaveSecretChatroomRequest, response: LMClientResponse<NoData>) {
        
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param muteChatroomRequest - client request model to mute secret chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func muteChatroom(muteChatroomRequest: MuteChatroomRequest, response: LMClientResponse<NoData>) {
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param markReadChatroomRequest - client request model to mark chatroom as read
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func markReadChatroom(markReadChatroomRequest: MarkReadChatroomRequest, response: LMClientResponse<NoData>) {
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param setChatroomTopicRequest - client request model to set a conversation as topic for chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func setChatroomTopic(setChatroomTopicRequest: SetChatroomTopicRequest, response: LMClientResponse<NoData>) {
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param getParticipantsRequest - client request model to get list of participants in chatroom
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return GetParticipantsResponse - GetParticipantsResponse model for getParticipantsRequest
     */
    func getParticipants(getParticipantsRequest: GetParticipantsRequest, response: LMClientResponse<GetParticipantsResponse>) {
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
    func editChatroomTitle(editChatroomTitleRequest: EditChatroomTitleRequest, response: LMClientResponse<NoData>) {
    }
    
}
