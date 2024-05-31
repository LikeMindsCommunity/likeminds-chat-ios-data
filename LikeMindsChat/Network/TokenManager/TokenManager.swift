//
//  TokenManager.swift
//  LMCore
//
//  Created by Pushpendra Singh on 15/02/23.
//

import Foundation
import Alamofire

/**
 * A protocol to handle login requried action
 *
 */
public protocol LMCallback: AnyObject {
    /// This method is called when the user is not logged in or guest
    /// It is called when the user tries to perform an action that requires login
    /// The user should be redirected to your appropriate login screen
    func login()
}

/// Default implementation of delegate
public extension LMCallback {
    func login() {}
}

final public class TokenManager {
    /// Singleton object property
    public private(set) static var shared = TokenManager()
    /// Token manager callback
    private weak var lmCallback: LMCallback?
    /// Refresh token completion block
    fileprivate var refreshTokenBlock: (() -> Void)?
    private var isRefreshingToken: Bool = false
    var accessToken: String?
    var refreshToken: String?
    /// Restrict to create another object of this singleton class
    private init(){}

    public func lmCallback(_ lmCallback: LMCallback) -> TokenManager {
        Self.shared.lmCallback = lmCallback
        return Self.shared
    }

    /// Refresh access token api call
    func refreshInterceptor(_ completion: @escaping ()->Void ) {
        if isRefreshingToken { return }
        guard let refreshToken = self.refreshToken else {
            lmCallback?.login()
            return
        }
        self.refreshTokenBlock = completion
        self.isRefreshingToken = true
        self.refreshAccessToken(refreshToken: refreshToken, withModuleName: "Token-Manager") { [weak self] response in
            guard let initiateResponse = response.data, response.errorMessage == nil else {
                self?.clearToken()
                self?.isRefreshingToken = false
                self?.lmCallback?.login()
                return
            }
            self?.updateToken(initiateResponse.accessToken, initiateResponse.refreshToken)
            self?.isRefreshingToken = false
            completion()
        }
    }
    
    func commonInterceptor(_ key: String = "", value: String = "") -> HTTPHeaders {
        let accessToken = TokenManager.shared.accessToken ?? ""
        let buildVersion = BuildManager.buildVersion
        return [
            "x-platform-code": "ios",
            "x-version-code": buildVersion,
            "Cookie":"",
            "x-sdk-source": "feed",
            "Authorization": "Bearer " + accessToken
        ]
    }
    
    private func refreshAccessToken(refreshToken: String, withModuleName moduleName: String, _ response: LMClientResponse<InitiateUserResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.refreshServiceToken(rtm: "")
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpSdkHeaders(headerKey: "Authorization", value: refreshToken),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: InitiateUserResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let result = responseData as? LMResponse<InitiateUserResponse> else {
                return
            }
            response?(result)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    func updateToken(_ accessToken: String?, _ refreshToken: String?) {
        self.refreshToken = refreshToken
        self.accessToken = accessToken
    }
    
    func clearToken() {
        self.refreshToken = nil
        self.accessToken = nil
    }
}
