//
//  PollClient.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class PollClient {
    
    let moduleName = "PollClient"
    static let shared = ChatroomClient()
    
    /**
     * Converts client request model to internal model and calls the api
     * @param postPollConversationRequest - client request model to post a poll conversation
     * @throws IllegalArgumentException - when LMFeedClient is not instantiated
     * @return PostPollConversationResponse - PostPollConversationResponse model for postPollConversationRequest
     */
    func postPollConversation(request: PostPollConversationRequest, response: LMClientResponse<PostPollConversationResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.postPollConversation(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: PostPollConversationResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<PostPollConversationResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param addPollOptionRequest - client request model to add poll option
     * @throws IllegalArgumentException - when LMFeedClient is not instantiated
     * @return AddPollOptionResponse - AddPollOptionResponse model for addPollOptionRequest
     */
    func addPollOption(addPollOptionRequest: AddPollOptionRequest, response: LMClientResponse<AddPollOptionResponse>) {
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param context - context required to start reopen sync
     * @param submitPollRequest - client request model to submit polls selected
     * @throws IllegalArgumentException - when LMFeedClient is not instantiated
     * @return LMResponse<Nothing> - Base LM response
     */
    func submitPoll(submitPollRequest: SubmitPollRequest, response: LMClientResponse<NoData>) {
    }
    
    /**
     * Converts client request model to internal model and calls the api
     * @param getPollUsersRequest - client request model to get users who have voted on that particular poll option
     * @throws IllegalArgumentException - when LMFeedClient is not instantiated
     * @return GetPollUsersResponse - GetPollUsersResponse model for getPollUsersRequest
     */
    func getPollUsers(getPollUsersRequest: GetPollUsersRequest, response: LMClientResponse<GetPollUsersResponse>) {
    }
}
