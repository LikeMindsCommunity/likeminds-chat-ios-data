//
//  LMChatClientServiceRequest.swift
//  LMFeed
//
//  Created by Pushpendra Singh on 23/02/23.
//

import Foundation

class LMChatClientServiceRequest: ServiceRequest {
    
    public static func getChatrooms(request: ChatroomSyncRequest, withModuleName moduleName: String, response: LMClientResponse<_SyncChatroomResponse_>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.syncChatrooms(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: ServiceRequest.httpHeaders(),
                                   withParameters: networkPath.parameters,
                                   withEncoding: networkPath.encoding,
                                   withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
            do {
                let result = try JSONDecoder().decode(LMResponse<_SyncChatroomResponse_>.self, from: data)
                response?(result)
            } catch let error {
                response?(LMResponse.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    public static func getExploreTabCount(withModuleName moduleName: String,response: LMClientResponse<GetExploreTabCountResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.explorTabCount
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: ServiceRequest.httpHeaders(),
                                   withParameters: networkPath.parameters,
                                   withEncoding: networkPath.encoding,
                                   withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
            do {
                let result = try JSONDecoder().decode(LMResponse<GetExploreTabCountResponse>.self, from: data)
                response?(result)
            } catch let error {
                response?(LMResponse.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
  
    /*
    public static func getExploreFeed(request: GetExploreFeedRequest, withModuleName moduleName: String, response: _LMClientResponse_<GetExploreFeedResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.explorFeed
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: ServiceRequest.httpHeaders(),
                                   withParameters: networkPath.parameters,
                                   withEncoding: networkPath.encoding,
                                   withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
            do {
                let result = try JSONDecoder().decode(_LMResponse_<GetExploreFeedResponse>.self, from: data)
                response?(result)
            } catch let error {
                response?(_LMResponse_.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
    */
    
}
