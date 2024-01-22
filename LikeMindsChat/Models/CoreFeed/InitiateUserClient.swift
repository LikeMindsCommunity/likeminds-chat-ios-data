//
//  InitiateUserClient.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 17/01/24.
//

import Foundation

class InitiateUserClient: ServiceRequest {

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
                TokenManager.shared.updateToken(result.data?.accessToken, result.data?.refreshToken)
                if !(result.data?.appAccess ?? false){
                    let logoutRequest = LogoutRequest.builder()
                        .deviceId(request.deviceId ?? "")
                        .refreshToken(result.data?.refreshToken ?? "")
                        .build()
                    Self.logout(request: logoutRequest, withModuleName: "Intiate User Client", nil)
                } else {
                    guard let user = result.data?.user else {
                        return
                    }
                    let lmUUID = user.uuid ?? ""
                    let lmMemberId = user.id ?? 0
                    let clientUUID = user.sdkClientInfo.uuid
                    
                    UserPreferences.shared.setLMUUID(lmUUID)
                    UserPreferences.shared.setLMMemberId("\(lmMemberId)")
                    UserPreferences.shared.setClientUUID(clientUUID)
                }
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
    
}
