//
//  LMChatClient.swift
//  LMChat
//
//  Created by Pushpendra Singh on 16/02/23.
//

import FirebaseDatabase
import Foundation

/// Protocol defining callback methods for handling token-related events in LMChat.
public protocol LMChatSDKCallback: AnyObject {
    /// Called when the access token has expired and been successfully refreshed.
    ///
    /// - Parameters:
    ///   - accessToken: The new access token.
    ///   - refreshToken: The new refresh token.
    func onAccessTokenExpiredAndRefreshed(
        accessToken: String, refreshToken: String)

    /// Called when the refresh token has expired.
    ///
    /// - Parameter completionHandler: A closure to be called with new tokens.
    ///   The closure takes a tuple containing the new access token and refresh token.
    func onRefreshTokenExpired(
        _ completionHandler: (
            ((accessToken: String, refreshToken: String)?) -> Void
        )?)
}

/// Main class for interacting with the LMChat SDK.


public final class LMChatClient {
    
    // MARK: - Builder Implementation
    public class Builder {
        private var client: LMChatClient
        private var excludedConversationStates: [ConversationState]?
        private weak var callback: LMChatSDKCallback?
        
        public init() {
            self.client = LMChatClient.shared
        }
        
        @discardableResult
        public func excludedConversationStates(_ states: [ConversationState]?) -> Self {
            self.excludedConversationStates = states
            return self
        }
        
        @discardableResult
        public func setTokenManager(_ callback: LMChatSDKCallback) -> Self {
            self.callback = callback
            return self
        }
        
        public func build() -> LMChatClient {
            // Set excluded conversation states if provided
            if let excludedStates = excludedConversationStates {
                client.excludedConversationStates = excludedStates.map { $0.rawValue }
            }
            
            // Set token manager callback
            LMChatClient.lMChatSDKCallback = callback
            
            // Set singleton instance
            shared = client
            return client
        }
    }
    
    // MARK: - Core Properties
    let moduleName = "LMChatClient-SDK"
    public private(set) static var shared: LMChatClient = LMChatClient()
    static weak private(set) var lMChatSDKCallback: LMChatSDKCallback?
    private(set) var excludedConversationStates: [Int] = []
    
    // MARK: - Initialization
    private init() {
        FirebaseServiceConfiguration.setupFirebaseAppService()
    }
    
    // MARK: - Token Management
    public func getTokens() -> LMResponse<LMChatTokenResponse> {
        guard let accessToken = TokenManager.shared.accessToken,
              let refreshToken = TokenManager.shared.refreshToken,
              !accessToken.isEmpty,
              !refreshToken.isEmpty else {
            return .failureResponse("Tokens not found")
        }
        return .successResponse(LMChatTokenResponse(
            accessToken: accessToken,
            refreshToken: refreshToken
        ))
    }
    
    // MARK: - API Configuration
    public func getAPIKey() -> LMResponse<String> {
        guard let apiKey = SDKPreferences.shared.getApiKey(),
              !apiKey.isEmpty else {
            return .failureResponse("API Key not found")
        }
        return .successResponse(apiKey)
    }
    
    // MARK: - User Management
    public func getUserDetails() -> User? {
        UserDetails.userDetails
    }
    
    // MARK: - Local Storage
    public func clearLocalStorage() {
        ChatDBUtil.shared.clearData()
        SDKPreferences.shared.clearData()
        UserPreferences.shared.clearData()
        SyncPreferences.shared.clearData()
        TokenManager.shared.clearToken()
    }
}
