//
//  SearchClient.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 12/04/24.
//

import Foundation

class SearchClient {
    let moduleName = "SearchClient"
    static let shared = SearchClient()
    
    func searchChatroom(with request: SearchChatroomRequest, response: LMClientResponse<SearchChatroomResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.searchChatroom(request)
        
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: SearchChatroomResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<SearchChatroomResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    func searchConversation(with request: SearchConversationRequest, response: LMClientResponse<SearchConversationResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.searchConversation(request)
        
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: SearchConversationResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<SearchConversationResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
}
