//
//  ExplorerFeedClient.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation


class ExplorerFeedClient {
    
    let moduleName = "ExplorerFeedClient"
    
    static let shared: ExplorerFeedClient = ExplorerFeedClient()
    private init() {}
    
    /**
     * Converts client request model to internal model and calls the api
     * @param getExploreFeedRequest - client request model to get explore feed
     * @throws IllegalArgumentException - when LMChatClient is not instantiated or required properties not provided
     * @return GetExploreFeedResponse - GetExploreFeedResponse model for getExploreFeedRequest
     */
    func getExploreFeed(request: GetExploreFeedRequest, response: LMClientResponse<GetExploreFeedResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.explorFeed(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeadersWithAcceptVersionV2(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: GetExploreFeedResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<GetExploreFeedResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    
}
