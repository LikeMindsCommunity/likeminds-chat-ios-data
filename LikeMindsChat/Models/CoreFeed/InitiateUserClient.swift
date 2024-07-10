//
//  InitiateUserClient.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 17/01/24.
//

import Foundation

class InitiateUserClient: ServiceRequest {
    static func initiateChatService(_ request: InitiateUserRequest, withModuleName moduleName: String, _ response: LMClientResponse<InitiateUserResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.initiateChatClient(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpSdkHeaders(value: request.apiKey ?? ""),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: InitiateUserResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let result = responseData as? LMResponse<InitiateUserResponse> else {return}
            TokenManager.shared.updateToken(result.data?.accessToken, result.data?.refreshToken)
            if !(result.data?.appAccess ?? false){
                let logoutRequest = LogoutRequest.builder()
                    .refreshToken(result.data?.refreshToken ?? "")
                    .build()
                Self.logout(request: logoutRequest, withModuleName: "Intiate User Client", nil)
            } else {
                guard let user = result.data?.user else {
                    return
                }
                let lmUUID = user.sdkClientInfo?.userUniqueID ?? ""
                let lmMemberId = user.sdkClientInfo?.user ?? 0
                let clientUUID = user.sdkClientInfo?.uuid ?? ""
                let communityId = user.sdkClientInfo?.community ?? 0
                let apiKey = request.apiKey ?? ""
                
                SDKPreferences.shared.setApiKey(apiKey)
                UserPreferences.shared.setLMUUID(lmUUID)
                UserPreferences.shared.setLMMemberId("\(lmMemberId)")
                UserPreferences.shared.setClientUUID(clientUUID)
                SDKPreferences.shared.setCommunityId(communityId: "\(communityId)")
                ChatDBUtil.shared.userROUpdate(user)
            }
            response?(result)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    static func validateUser(request: ValidateUserRequest, withModuleName moduleName: String, _ response: LMClientResponse<ValidateUserResponse>?) {
        // Update tokens in TokenManager
        TokenManager.shared.updateToken(request.accessToken, request.refreshToken)
        
        // Construct the API URL
        let networkPath = ServiceAPIRequest.NetworkPath.validateUser(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else { return }
        
        // Set up headers, including Authorization
        var headers = ServiceRequest.httpHeaders()
        headers["Authorization"] = "Bearer \(request.accessToken)"
        
        // Make the network request
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: headers,
                                              withParameters: nil,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: ValidateUserResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            // Ensure we can cast the response to the expected type
            guard let result = responseData as? LMResponse<ValidateUserResponse> else {
                response?(LMResponse.failureResponse("Unable to convert to Data"))
                return
            }
            
            // Check if the user has app access
            if !(result.data?.appAccess ?? false) {
                // If no access, log the user out
                let logoutRequest = LogoutRequest.builder()
                    .refreshToken(request.refreshToken)
                    .build()
                Self.logout(request: logoutRequest, withModuleName: "Intiate User Client", nil)
            } else {
                // If access is granted, update local user data
                guard let user = result.data?.user else {
                    return
                }
                let lmUUID = user.sdkClientInfo?.userUniqueID ?? ""
                let lmMemberId = user.sdkClientInfo?.user ?? 0
                let clientUUID = user.sdkClientInfo?.uuid ?? ""
                let communityId = user.sdkClientInfo?.community ?? 0
                
                // Update user preferences
                UserPreferences.shared.setLMUUID(lmUUID)
                UserPreferences.shared.setLMMemberId("\(lmMemberId)")
                UserPreferences.shared.setClientUUID(clientUUID)
                SDKPreferences.shared.setCommunityId(communityId: "\(communityId)")
                
                // Update user in local database
                ChatDBUtil.shared.userROUpdate(user)
            }
            
            // Call the response handler with the result
            response?(result)
        } failureCallback: { moduleName, error in
            // Handle network request failure
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    static func refreshAccessToken(request: RefreshAccessTokenRequest, withModuleName moduleName: String, _ response: LMClientResponse<RefreshAccessTokenResponse>?) {
        
        // Construct the API URL for token refresh
        let networkPath = ServiceAPIRequest.NetworkPath.refreshServiceToken(rtm: "")
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {
            response?(LMResponse.failureResponse("Unable to parse URL"))
            return
        }
        
        // Send the network request
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpSdkHeaders(headerKey: "Authorization", value: request.refreshToken),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: RefreshAccessTokenResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            // Attempt to cast the response to the expected type
            guard let result = responseData as? LMResponse<RefreshAccessTokenResponse> else {
                response?(LMResponse.failureResponse("Unable to parse URL"))
                return
            }
            
            // Call the response handler with the result
            response?(result)
            
        } failureCallback: { (moduleName, error) in
            // Handle network request failure
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    static func registerDevice(request: RegisterDeviceRequest, withModuleName moduleName: String, _ response: LMClientResponse<RegisterDeviceResponse>?) {
        
        let networkPath = ServiceAPIRequest.NetworkPath.pushToken(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.deviceRegisterHeaders(headerKey: "x-device-id", value: request.deviceId ?? ""),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: RegisterDeviceResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let result = responseData as? LMResponse<RegisterDeviceResponse> else {
                return
            }
            response?(result)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    static func logout(request: LogoutRequest, withModuleName moduleName: String, _ response: LMClientResponse<NoData>?) {
        guard let refreshToken = TokenManager.shared.refreshToken else {
            response?(LMResponse.failureResponse("refresh token expired or not found!"))
            return
        }
        let request = request.toBuilder().refreshToken(refreshToken).build()
        let networkPath = ServiceAPIRequest.NetworkPath.logout(request)
        var headers = ServiceRequest.httpHeaders()
        headers["x-device-id"] = request.deviceId ?? ""
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: headers,
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: NoData.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<NoData> else {return}
            response?(data)
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
                let result=try JSONDecoder().decode(LMResponse<ConfigResponse>.self, from: data)
                response?(result)
            } catch let error {
                response?(LMResponse.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
}
