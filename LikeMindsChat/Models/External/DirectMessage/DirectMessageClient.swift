//
//  DirectMessageClient.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 12/06/24.
//

import Foundation

import Foundation

class DirectMessageClient {
 
    static func fetchDMFeed(request: FetchDMFeedRequest, moduleName: String) {
        let networkPath = ServiceAPIRequest.NetworkPath.fetchDMFeeds(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: ServiceRequest.httpHeaders(),
                                   withEncoding: networkPath.encoding, withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
        } failureCallback: { (moduleName, error) in
            
        }
    }
    /*
    static func showDirectMessage(communityId: Int, fromModule: String, memberId: Int?, moduleName: String) {
        let networkPath = ServiceAPIRequest.NetworkPath.showDirectMessage(communityId, fromScreen: fromModule, memberId: memberId)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: ServiceRequest.httpHeaders(),
                                   withParameters: networkPath.parameters,
                                   withEncoding: networkPath.encoding, withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
        } failureCallback: { (moduleName, error) in
        }
    }
    static func updateDirectMessage(clicked: Bool?, messaged: Bool?, moduleName: String) {
        let networkPath = ServiceAPIRequest.NetworkPath.updateDMTutorial(clicked, messaged: messaged)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: ServiceRequest.httpHeaders(),
                                   withParameters: networkPath.parameters,
                                   withEncoding: networkPath.encoding, withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
        } failureCallback: { (moduleName, error) in
        }
    }
    
    */
    
    
    static func checkDMTab(moduleName: String, _ response: LMClientResponse<CheckDMTabResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.checkDMTab
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                               withHTTPMethod: networkPath.httpMethod,
                                               headers: ServiceRequest.httpHeadersWithAPIVersion(),
                                               withParameters: networkPath.parameters,
                                               withEncoding: networkPath.encoding,
                                               withResponseType: CheckDMTabResponse.self,
                                               withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<CheckDMTabResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    static func fetchDMFeeds(request: ChatroomSyncRequest, moduleName: String, _ response: LMClientResponse<Chatroom>?) {
        
    }
    
    static func checkDMStatus(request: CheckDMStatusRequest, moduleName: String, _ response: LMClientResponse<CheckDMStatusResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.checkDMStatus(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: CheckDMStatusResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<CheckDMStatusResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    static func checkDMLimit(request: CheckDMLimitRequest, moduleName: String, _ response: LMClientResponse<CheckDMLimitResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.checkDMLimit(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: CheckDMLimitResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<CheckDMLimitResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    static func createDMChatroom(request: CreateDMChatroomRequest, moduleName: String, _ response: LMClientResponse<CheckDMChatroomResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.createDMChatroom(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: CheckDMChatroomResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<CheckDMChatroomResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    static func sendDMRequest(request: SendDMRequest, moduleName: String, _ response: LMClientResponse<SendDMResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.sendDMRequest(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: SendDMResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<SendDMResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    static func blockDMMember(request: BlockMemberRequest, moduleName: String, _ response: LMClientResponse<BlockMemberResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.blockDMMember(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: BlockMemberResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<BlockMemberResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
}
