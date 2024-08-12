//
//  LMChatClient.swift
//  LMChat
//
//  Created by Pushpendra Singh on 16/02/23.
//

import Foundation
import FirebaseDatabase
/// Protocol defining callback methods for handling token-related events in LMChat.
public protocol LMChatSDKCallback: AnyObject {
    /// Called when the access token has expired and been successfully refreshed.
    ///
    /// - Parameters:
    ///   - accessToken: The new access token.
    ///   - refreshToken: The new refresh token.
    func onAccessTokenExpiredAndRefreshed(accessToken: String, refreshToken: String)
    
    /// Called when the refresh token has expired.
    ///
    /// - Parameter completionHandler: A closure to be called with new tokens.
    ///   The closure takes a tuple containing the new access token and refresh token.
    func onRefreshTokenExpired(_ completionHandler: (((accessToken: String, refreshToken: String)?) -> Void)?)
}

/// Main class for interacting with the LMChat SDK.
public class LMChatClient {
    /// Module name for logging and identification purposes.
    let moduleName = "LMChatClient-SDK"
    
    /// Shared instance of LMChatClient (Singleton pattern).
    public private(set) static var shared = LMChatClient()
    
    /// Callback for handling SDK-related events.
    static weak private(set) var lMChatSDKCallback: LMChatSDKCallback?
    
    /// Private initializer to enforce singleton pattern.
    private init() {
        FirebaseServiceConfiguration.setupFirebaseAppService()
    }
    
    /// Creates and returns a new instance of LMChatClient.
    ///
    /// - Returns: A new instance of LMChatClient.
    public static func builder() -> LMChatClient {
        Self.shared = LMChatClient()
        return Self.shared
    }
    
    /// Finalizes the building process and returns the shared instance.
    ///
    /// - Returns: The shared instance of LMChatClient.
    public func build() -> LMChatClient {
        return Self.shared
    }
    
    /// Retrieves the current access and refresh tokens.
    ///
    /// - Returns: An LMResponse containing LMChatTokenResponse if successful, or an error message if tokens are not found.
    public func getTokens() -> LMResponse<LMChatTokenResponse> {
        guard let accessToken = TokenManager.shared.accessToken,
              let refreshToken = TokenManager.shared.refreshToken,
              !accessToken.isEmpty,
              !refreshToken.isEmpty else { return .failureResponse("Tokens not found") }
        
        let tokens = LMChatTokenResponse(accessToken: accessToken, refreshToken: refreshToken)
        
        return .successResponse(tokens)
    }
    
    /// Sets the callback for handling SDK-related events.
    ///
    /// - Parameter lMChatSDKCallback: The callback to be set.
    public func setTokenManager(with lMChatSDKCallback: LMChatSDKCallback) {
        Self.lMChatSDKCallback = lMChatSDKCallback
    }
    
    /// Retrieves the API key.
    ///
    /// - Returns: An LMResponse containing the API key if successful, or an error message if the API key is not found.
    public func getAPIKey() -> LMResponse<String> {
        guard let apiKey = SDKPreferences.shared.getApiKey(),
              !apiKey.isEmpty else { return .failureResponse("API Key not found") }
        
        return .successResponse(apiKey)
    }
    
    /// Retrieves the current user details.
    ///
    /// - Returns: A User object if available, or nil if no user details are found.
    public func getUserDetails() -> User? {
        UserDetails.userDetails
    }
}
