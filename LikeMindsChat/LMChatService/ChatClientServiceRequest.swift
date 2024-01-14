//
//  ChatClientServiceRequest.swift
//  LMFeed
//
//  Created by Pushpendra Singh on 24/02/23.
//

import Foundation

class ChatClientServiceRequest: ServiceRequest {
    
    static func initiateChatService(_ request: InitiateUserRequest, withModuleName moduleName: String, _ response: _LMClientResponse_<InitiateUserResponse>?) {
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
                let result = try JSONDecoder().decode(_LMResponse_<InitiateUserResponse>.self, from: data)
                response?(result)
            } catch let error {
                response?(_LMResponse_.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
    
    static func registerDevice(request: RegisterDeviceRequest, withModuleName moduleName: String, _ response: _LMClientResponse_<RegisterDeviceResponse>?) {
        
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
                let result = try JSONDecoder().decode(_LMResponse_<RegisterDeviceResponse>.self, from: data)
                response?(result)
            } catch let error {
                response?(_LMResponse_.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
    
    static func logout(request: LogoutRequest, withModuleName moduleName: String, _ response: _LMClientResponse_<_NoData_>?) {
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
                let result = try JSONDecoder().decode(_LMResponse_<_NoData_>.self, from: data)
                response?(result)
            } catch let error {
                response?(_LMResponse_.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
    
    static func getConfig(withModuleName moduleName: String, _ response: _LMClientResponse_<ConfigResponse>?) {
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
    
    static func syncChatrooms(request: ChatroomSyncRequest, moduleName: String, _ response: _LMClientResponse_<_SyncChatroomResponse_>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.syncChatrooms(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: ServiceRequest.httpHeaders(),
                                   withEncoding: networkPath.encoding, withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
            do {
                let json = try JSONDecoder().decode(_LMResponse_<_SyncChatroomResponse_>.self, from: data)
                response?(json)
            } catch {
                response?(_LMResponse_.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
    
    static func syncConversations(request: ConversationSyncRequest, moduleName: String, _ response: _LMClientResponse_<_SyncConversationResponse_>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.syncConversations(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: ServiceRequest.httpHeaders(),
                                   withEncoding: networkPath.encoding, withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
            do {
                let json = try JSONDecoder().decode(_LMResponse_<_SyncConversationResponse_>.self, from: data)
                response?(json)
            } catch {
                response?(_LMResponse_.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(_LMResponse_.failureResponse(error.localizedDescription))
        }
    }
    
}
