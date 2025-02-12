//
//  InitiateUserClient.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 17/01/24.
//

import Foundation

class InitiateUserClient: ServiceRequest {
    static func initiateChatService(
        _ request: InitiateUserRequest, withModuleName moduleName: String,
        _ response: LMClientResponse<InitiateUserResponse>?
    ) {
        let networkPath = ServiceAPIRequest.NetworkPath.initiateChatClient(
            request)
        guard
            let url: URL = URL(
                string: ServiceAPI.authBaseURL + networkPath.apiURL)
        else { return }
        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpSdkHeaders(value: request.apiKey ?? ""),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: InitiateUserResponse.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            guard let result = responseData as? LMResponse<InitiateUserResponse>
            else { return }
            TokenManager.shared.updateToken(
                result.data?.accessToken, result.data?.refreshToken)
            if !(result.data?.appAccess ?? false) {
                let logoutRequest = LogoutUserRequest.builder()
                    .build()
                Self.logoutUser(
                    request: logoutRequest,
                    withModuleName: "Intiate User Client", nil)
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
                SDKPreferences.shared.setCommunityId(
                    communityId: "\(communityId)")
                SDKPreferences.shared.setCommunityName(
                    communityName: result.data?.community?.name ?? "")
                ChatDBUtil.shared.userROUpdate(user)
            }
            response?(result)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    static func validateUser(
        request: ValidateUserRequest, withModuleName moduleName: String,
        _ response: LMClientResponse<ValidateUserResponse>?
    ) {
        // Update tokens in TokenManager
        TokenManager.shared.updateToken(
            request.accessToken, request.refreshToken)

        // Construct the API URL
        let networkPath = ServiceAPIRequest.NetworkPath.validateUser(request)
        guard
            let url: URL = URL(
                string: ServiceAPI.authBaseURL + networkPath.apiURL)
        else { return }

        // Set up headers, including Authorization
        var headers = ServiceRequest.httpHeaders()
        headers["Authorization"] = "Bearer \(request.accessToken)"

        // Make the network request
        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: headers,
            withParameters: nil,
            withEncoding: networkPath.encoding,
            withResponseType: ValidateUserResponse.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            // Ensure we can cast the response to the expected type
            guard let result = responseData as? LMResponse<ValidateUserResponse>
            else {
                response?(
                    LMResponse.failureResponse("Unable to convert to Data"))
                return
            }

            // Check if the user has app access
            if !(result.data?.appAccess ?? false) {
                // If no access, log the user out
                let logoutRequest = LogoutUserRequest.builder()
                    .build()
                Self.logoutUser(
                    request: logoutRequest,
                    withModuleName: "Intiate User Client", nil)
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
                SDKPreferences.shared.setCommunityId(
                    communityId: "\(communityId)")

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

    static func refreshAccessToken(
        request: RefreshAccessTokenRequest, withModuleName moduleName: String,
        _ response: LMClientResponse<RefreshAccessTokenResponse>?
    ) {

        // Construct the API URL for token refresh
        let networkPath = ServiceAPIRequest.NetworkPath.refreshServiceToken(
            rtm: "")
        guard
            let url: URL = URL(
                string: ServiceAPI.authBaseURL + networkPath.apiURL)
        else {
            response?(LMResponse.failureResponse("Unable to parse URL"))
            return
        }

        // Send the network request
        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpSdkHeaders(
                headerKey: "Authorization", value: request.refreshToken),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: RefreshAccessTokenResponse.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            // Attempt to cast the response to the expected type
            guard
                let result = responseData
                    as? LMResponse<RefreshAccessTokenResponse>
            else {
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

    static func registerDevice(
        request: RegisterDeviceRequest, withModuleName moduleName: String,
        _ response: LMClientResponse<RegisterDeviceResponse>?
    ) {

        let networkPath = ServiceAPIRequest.NetworkPath.pushToken(request)
        guard
            let url: URL = URL(
                string: ServiceAPI.authBaseURL + networkPath.apiURL)
        else { return }
        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.deviceRegisterHeaders(
                headerKey: "x-device-id", value: request.deviceId ?? ""),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: RegisterDeviceResponse.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            guard
                let result = responseData as? LMResponse<RegisterDeviceResponse>
            else {
                return
            }
            response?(result)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    // MARK: Logout User
    /**
     Logs out the current user by clearing tokens and optionally notifying the backend service.

     This function checks if the user is currently logged in by retrieving the access and refresh tokens.
     - If both tokens are `nil`, it clears local storage and immediately returns a success response.
     - If the tokens exist but no `deviceId` is provided in the logout request, it clears local storage and returns success.
     - If a valid `deviceId` is provided, it sends a logout request to the backend service using the provided device ID in the HTTP headers.
       On a successful network response, it clears the local storage and returns the success response. On failure, it returns
       an error response with the error's localized description.

     - Parameters:
        - request: An instance of `LogoutUserRequest` containing the logout parameters (such as `deviceId`).
        - moduleName: A `String` representing the module name for logging or tracking purposes.
        - response: An optional closure of type `LMClientResponse<NoData>?` that is called with the logout response.

     - Note: This function relies on several helper methods and objects, such as `TokenManager`, `clearLocalStorage()`,
       `ServiceAPI`, and `DataNetwork.shared.requestWithDecoded(_:)`.
     */
    static func logoutUser(
        request: LogoutUserRequest, withModuleName moduleName: String,
        _ response: LMClientResponse<NoData>?
    ) {
        
        // Retrieve tokens from the TokenManager
        var (accessToken, refreshToken) = TokenManager.shared.getTokens()

        // If both tokens are nil, the user is not logged in; clear local storage and return a success response.
        if accessToken == nil && refreshToken == nil {
            clearLocalStorage()
            response?(LMResponse.successResponse(NoData()))
        } else {
            // If no deviceId is provided in the request, clear local storage and return success.
            if request.deviceId == nil {
                clearLocalStorage()
                response?(LMResponse.successResponse(NoData()))
            } else {
                let request = request.toBuilder().refreshToken(refreshToken).build()
                // Build the network path for the logout request
                let networkPath = ServiceAPIRequest.NetworkPath.logout(request)
                // Prepare HTTP headers and add the device ID to the headers.
                var headers = ServiceRequest.httpHeaders()
                headers["x-device-id"] = request.deviceId ?? ""

                // Construct the URL for the logout API endpoint
                guard
                    let url: URL = URL(
                        string: ServiceAPI.authBaseURL + networkPath.apiURL)
                else {
                    return
                }

                // Perform the network request using the decoded response method.
                DataNetwork.shared.requestWithDecoded(
                    for: url,
                    withHTTPMethod: networkPath.httpMethod,
                    headers: headers,
                    withParameters: networkPath.parameters,
                    withEncoding: networkPath.encoding,
                    withResponseType: NoData.self,
                    withModuleName: moduleName
                ) { (moduleName, responseData) in
                    // On successful response, cast the data and clear local storage.
                    guard let data = responseData as? LMResponse<NoData> else {
                        return
                    }
                    clearLocalStorage()
                    response?(data)
                } failureCallback: { (moduleName, error) in
                    // On error, return a failure response with the error description.
                    response?(
                        LMResponse.failureResponse(error.localizedDescription))
                }
            }
        }
    }

    static func getConfig(
        withModuleName moduleName: String,
        _ response: LMClientResponse<ConfigResponse>?
    ) {
        let networkPath = ServiceAPIRequest.NetworkPath.getConfig
        guard
            let url: URL = URL(
                string: ServiceAPI.authBaseURL + networkPath.apiURL)
        else { return }
        DataNetwork.shared.request(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeaders(),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            guard let data = responseData as? Data else { return }
            do {
                let result = try JSONDecoder().decode(
                    LMResponse<ConfigResponse>.self, from: data)
                response?(result)
            } catch let error {
                response?(
                    LMResponse.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    /// Clears all locally stored data within the application.
    ///
    /// This includes clearing the chat database, SDK preferences, user preferences,
    /// synchronization preferences, and authentication tokens.
    static func clearLocalStorage() {
        // Clear all data stored in the chat database.
        ChatDBUtil.shared.clearData()
        
        // Clear preferences and settings specific to the SDK.
        SDKPreferences.shared.clearData()
        
        // Clear all user-specific preferences and data.
        UserPreferences.shared.clearData()
        
        // Clear synchronization-related preferences.
        SyncPreferences.shared.clearData()
        
        // Remove any stored authentication tokens.
        // Clears out the access and refresh token
        TokenManager.shared.clearToken()
    }

}
