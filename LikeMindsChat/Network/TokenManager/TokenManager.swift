//
//  TokenManager.swift
//  LMCore
//
//  Created by Pushpendra Singh on 15/02/23.
//

import Foundation
import Alamofire


final public class TokenManager {
    /// Singleton object property
    public private(set) static var shared = TokenManager()
    
    /// Refresh token completion block
    private var refreshTokenBlock: [((String?) -> Void)?] = []
    private var isRefreshingToken: Bool = false
    private var isRefreshingAccessToken: Bool = false
    
    
    private(set) var accessToken: String?
    private (set) var refreshToken: String?
    /// Restrict to create another object of this singleton class
    private init(){
        
    }
    
    func onRefreshTokenExpired() {
        if isRefreshingToken { return }
        
        isRefreshingToken = true
        clearToken()
        
        LMChatClient.lMChatSDKCallback?.onRefreshTokenExpired { [weak self] tokens in
            defer{
                self?.isRefreshingAccessToken = false
                self?.isRefreshingToken = false
                self?.refreshTokenBlock.removeAll()
            }
            guard let tokens else {
                return
            }
            
            self?.updateToken(tokens.accessToken, tokens.refreshToken)
            
            self?.refreshTokenBlock.forEach { com in
                com?(tokens.accessToken)
            }
        }
    }
    
    func refreshAccessToken(_ completion: @escaping (String?)->Void) {
        refreshTokenBlock.append(completion)
        
        if isRefreshingAccessToken { return }
        
        isRefreshingAccessToken = true
        
        guard let refreshToken = self.refreshToken else {
            isRefreshingAccessToken = false
            isRefreshingToken = false
            return
        }
        
        let refreshAccessTokenRequest: RefreshAccessTokenRequest = RefreshAccessTokenRequest.builder().refreshToken(refreshToken: refreshToken).build()
        
        LMChatClient.shared.refreshAccessToken(request: refreshAccessTokenRequest) { [weak self] response in
            defer{
                self?.isRefreshingAccessToken = false
                self?.refreshTokenBlock.removeAll()
            }
            
            guard response.success,
                  let accessToken = response.data?.accessToken,
                  let refreshToken = response.data?.refreshToken else {
                self?.isRefreshingAccessToken = false
                return
            }
            
            self?.updateToken(accessToken, refreshToken)
            
            self?.refreshTokenBlock.forEach { com in
                com?(accessToken)
            }
            
            LMChatClient.lMChatSDKCallback?.onAccessTokenExpiredAndRefreshed(accessToken: accessToken, refreshToken: refreshToken)
        }
    }
    
    func updateToken(_ accessToken: String?, _ refreshToken: String?) {
        LMChatTokenManager.refreshToken = refreshToken
        LMChatTokenManager.accessToken = accessToken
        
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    func clearToken() {
        LMChatTokenManager.refreshToken = nil
        LMChatTokenManager.accessToken = nil
        
        accessToken = nil
        refreshToken = nil
    }
}
