//
//  ChatClientServiceRequest.swift
//  LMFeed
//
//  Created by Pushpendra Singh on 24/02/23.
//

import Foundation

class ChatClientServiceRequest: ServiceRequest {
    
    static func initiateChatService(_ request: InitiateUserRequest, withModuleName moduleName: String, _ response: LMClientResponse<InitiateUserResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.initiateChatClient(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: ServiceRequest.httpSdkHeaders(value: request.apiKey ?? ""),
                                   withParameters: networkPath.parameters,
                                   withEncoding: networkPath.encoding,
                                   withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
            do {
                let result = try JSONDecoder().decode(LMResponse<InitiateUserResponse>.self, from: data)
                response?(result)
            } catch let error {
                response?(LMResponse.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    static func registerDevice(request: RegisterDeviceRequest, withModuleName moduleName: String, _ response: LMClientResponse<RegisterDeviceResponse>?) {
        
        let networkPath = ServiceAPIRequest.NetworkPath.pushToken(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: ServiceRequest.deviceRegisterHeaders(headerKey: "x-device-id", value: request.deviceId ?? ""),
                                   withParameters: networkPath.parameters,
                                   withEncoding: networkPath.encoding,
                                   withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
            do {
                let result = try JSONDecoder().decode(LMResponse<RegisterDeviceResponse>.self, from: data)
                response?(result)
            } catch let error {
                response?(LMResponse.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    static func logout(request: LogoutRequest, withModuleName moduleName: String, _ response: LMClientResponse<NoData>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.logout(request)
        var headers = ServiceRequest.httpHeaders()
        headers["x-device-id"] = request.deviceId ?? ""
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: headers,
                                   withParameters: networkPath.parameters,
                                   withEncoding: networkPath.encoding,
                                   withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
            do {
                let result = try JSONDecoder().decode(LMResponse<NoData>.self, from: data)
                response?(result)
            } catch let error {
                response?(LMResponse.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    static func getConfig(withModuleName moduleName: String, _ response: LMClientResponse<ConfigResponse>?) {
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
                let result = try JSONDecoder().decode(LMResponse<ConfigResponse>.self, from: data)
                response?(result)
            } catch let error {
                response?(LMResponse.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    static func syncChatrooms(request: ChatroomSyncRequest, moduleName: String, _ response: LMClientResponse<_SyncChatroomResponse_>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.syncChatrooms(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: ServiceRequest.httpHeaders(),
                                   withEncoding: networkPath.encoding, withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
            do {
                let json = try JSONDecoder().decode(LMResponse<_SyncChatroomResponse_>.self, from: data)
                response?(json)
            } catch {
                response?(LMResponse.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    static func syncConversations(request: ConversationSyncRequest, moduleName: String, _ response: LMClientResponse<_SyncConversationResponse_>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.syncConversations(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: ServiceRequest.httpHeaders(),
                                   withEncoding: networkPath.encoding, withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
            do {
                let json = try JSONDecoder().decode(LMResponse<_SyncConversationResponse_>.self, from: data)
                response?(json)
            } catch {
                response?(LMResponse.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
}
