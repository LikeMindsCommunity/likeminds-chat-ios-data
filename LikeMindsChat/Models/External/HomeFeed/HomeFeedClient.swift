//
//  HomeFeedClient.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 24/01/24.
//

import Foundation

class HomeFeedClient {
    
    
    static func getConfig(withModuleName moduleName: String,response: _LMClientResponse_<ConfigResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.getConfig
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: ServiceRequest.httpHeaders(),
                                   withParameters: networkPath.parameters,
                                   withEncoding: networkPath.encoding,
                                   withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
            do {
                let result = try JSONDecoder().decode(_LMResponse_<ConfigResponse>.self, from: data)
                response?(result)
            } catch let error {
                response?(_LMResponse_.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
    
    public static func getExploreTabCount(withModuleName moduleName: String,response: _LMClientResponse_<GetExploreTabCountResponse>?) {
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
                let result = try JSONDecoder().decode(_LMResponse_<GetExploreTabCountResponse>.self, from: data)
                response?(result)
            } catch let error {
                response?(_LMResponse_.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
    
    static func syncChatrooms() {
        
        let isFirstSync = ChatDBUtil.shared.isEmpty()
        if isFirstSync {
            SyncOperationUtil.startFirstHomeFeedSync { response in
                // Do somthing with response
            }
        } else {
            SyncOperationUtil.startReopenSyncForHomeFeed { response in
                // Do somthing with response
            }
        }
    }
    
    static func getChatrooms() {
        
    }
    
}
