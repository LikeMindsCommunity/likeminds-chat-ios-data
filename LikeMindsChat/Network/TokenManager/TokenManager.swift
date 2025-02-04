//
//  TokenManager.swift
//  LMCore
//
//  Created by Pushpendra Singh on 15/02/23.
//

import Alamofire
import Foundation

/// A singleton class responsible for managing and refreshing access tokens and refresh tokens within the LMChat SDK.
///
/// This class handles:
/// - Storing tokens in memory.
/// - Triggering token refresh when required.
/// - Clearing tokens when necessary.
/// - Notifying other parts of the app or SDK about token updates or expiration events.
final public class TokenManager {

    /**
     Shared singleton instance of `TokenManager`.

     Use this instance to manage token-related operations throughout the app.
     */
    public private(set) static var shared = TokenManager()

    // MARK: - Private Properties

    /**
     An array of completion closures to be called once the token refresh operation completes.

     Each closure passes the newly refreshed access token or `nil` if the operation fails.
     */
    private var refreshTokenBlock: [((String?) -> Void)?] = []

    /**
     A Boolean flag indicating whether a refresh token request is currently in progress.

     - `true` if a refresh token request is ongoing.
     - `false` otherwise.
     */
    private var isRefreshingToken: Bool = false

    /**
     A Boolean flag indicating whether an access token refresh request is currently in progress.

     - `true` if an access token refresh request is ongoing.
     - `false` otherwise.
     */
    private var isRefreshingAccessToken: Bool = false

    // MARK: - Token Storage

    /**
     The currently stored access token, if any.
     */
    private(set) var accessToken: String?

    /**
     The currently stored refresh token, if any.
     */
    private(set) var refreshToken: String?

    // MARK: - Initializer

    /**
     Private initializer to enforce the singleton pattern.

     No other instance of `TokenManager` can be created.
     */
    private init() {}

    // MARK: - Public Methods

    /**
     Retrieves the current access token and refresh token.

     - Returns: A tuple containing the current access token and refresh token, respectively.
     */
    func getTokens() -> (String?, String?) {
        return (accessToken, refreshToken)
    }

    /**
     Handles the scenario where the refresh token has expired.

     - If a refresh token request is already in progress, this method returns immediately.
     - Clears the stored tokens.
     - Invokes the `onRefreshTokenExpired` callback on `LMChatSDKCallback`.
     - Once new tokens are obtained, updates the stored tokens and executes all completion blocks.
     */
    func onRefreshTokenExpired() {
        // If a token refresh is currently in progress, do nothing
        if isRefreshingToken { return }

        isRefreshingToken = true
        clearToken()

        LMChatClient.lMChatSDKCallback?.onRefreshTokenExpired {
            [weak self] tokens in
            defer {
                self?.isRefreshingAccessToken = false
                self?.isRefreshingToken = false
                self?.refreshTokenBlock.removeAll()
            }
            guard let tokens else {
                // If no tokens returned, there's no need to proceed
                return
            }

            // Update the tokens in memory
            self?.updateToken(tokens.accessToken, tokens.refreshToken)

            // Call all completion closures with the new access token
            self?.refreshTokenBlock.forEach { com in
                com?(tokens.accessToken)
            }
        }
    }

    /**
     Refreshes the access token using the stored refresh token.

     - If a refresh token operation is already in progress, this method appends the completion block to the list and returns.
     - Makes a network request through `LMChatClient` to refresh the access token.
     - Once refreshed, updates tokens and notifies all completion closures.

     - Parameter completion: A closure called with the new access token or `nil` if the operation fails.
     */
    func refreshAccessToken(_ completion: @escaping (String?) -> Void) {
        // Append the completion closure to the list
        refreshTokenBlock.append(completion)

        // If a refresh access token request is already in progress, do nothing
        if isRefreshingAccessToken { return }

        isRefreshingAccessToken = true

        // Guard against nil refresh token; if nil, we cannot refresh
        guard let refreshToken = self.refreshToken else {
            isRefreshingAccessToken = false
            isRefreshingToken = false
            return
        }

        let refreshAccessTokenRequest: RefreshAccessTokenRequest =
            RefreshAccessTokenRequest.builder()
            .refreshToken(refreshToken)
            .build()

        // Perform the network request to refresh the access token
        LMChatClient.shared.refreshAccessToken(
            request: refreshAccessTokenRequest
        ) { [weak self] response in
            defer {
                self?.isRefreshingAccessToken = false
                self?.refreshTokenBlock.removeAll()
            }

            // If request not successful or tokens are missing, exit early
            guard response.success,
                let accessToken = response.data?.accessToken,
                let refreshToken = response.data?.refreshToken
            else {
                self?.isRefreshingAccessToken = false
                return
            }

            // Update stored tokens
            self?.updateToken(accessToken, refreshToken)

            // Notify all completion closures of the new access token
            self?.refreshTokenBlock.forEach { com in
                com?(accessToken)
            }

            // Notify the SDK callback that tokens have been refreshed
            LMChatClient.lMChatSDKCallback?.onAccessTokenExpiredAndRefreshed(
                accessToken: accessToken,
                refreshToken: refreshToken
            )
        }
    }

    /**
     Updates the in-memory tokens to new values.

     - Parameters:
       - accessToken: The new access token.
       - refreshToken: The new refresh token.
     */
    func updateToken(_ accessToken: String?, _ refreshToken: String?) {
        // Update token references in the LMChatTokenManager (if needed by the SDK)
        LMChatTokenManager.refreshToken = refreshToken
        LMChatTokenManager.accessToken = accessToken

        // Update local references
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }

    /**
     Clears the stored access token and refresh token.

     This method also clears the tokens from `LMChatTokenManager`.
     */
    func clearToken() {
        // Clear tokens from the SDK's token manager
        LMChatTokenManager.refreshToken = nil
        LMChatTokenManager.accessToken = nil

        // Clear local references
        accessToken = nil
        refreshToken = nil
    }
}
