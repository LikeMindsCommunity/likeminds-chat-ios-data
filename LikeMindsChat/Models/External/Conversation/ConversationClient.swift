//
//  ConversationClient.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 11/01/24.
//

import Foundation
import RealmSwift
class ConversationClient {
    
    /**
     * Converts client request model to internal model and calls the api
     * @param postConversationRequest - client request model to post a conversation
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<PostConversationResponse> - Base LM response[PostConversationResponse]
     */
    func postConversation(request: PostConversationRequest, response: LMClientResponse<PostConversationResponse>?) {
        
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
    func editConversation(editConversationRequest: EditConversationRequest, response: LMClientResponse<EditConversationResponse>) {
        
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param deleteConversationsRequest - client request model to delete conversations
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<DeleteConversationRequest> - Base LM response[DeleteConversationsRequest]
     */
    func deleteConversations(deleteConversationsRequest: DeleteConversationsRequest, response: LMClientResponse<DeleteConversationsResponse>) {
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param putReactionRequest - client request model to put a reaction on a conversation
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func putReaction(putReactionRequest: PutReactionRequest, response: LMClientResponse<NoData>) {
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param deleteReactionRequest - client request model to delete a reaction on a conversation
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<Nothing> - Base LM response
     */
    func deleteReaction(deleteReactionRequest: DeleteReactionRequest, response: LMClientResponse<NoData>) {
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param putMultimediaRequest - client request model to upload a conversation attachment
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return LMResponse<PutMultimediaResponse> - Base LM response[PutMultimediaResponse]
     */
    func putMultimedia(putMultimediaRequest: PutMultimediaRequest, response: LMClientResponse<PutMultimediaResponse>) {
    }
        
}
