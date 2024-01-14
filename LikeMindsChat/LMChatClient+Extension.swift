//
//  LMChatClient+Extension.swift
//  LMFeed
//
//  Created by Pushpendra Singh on 24/02/23.
//

import Foundation
import UIKit

public typealias LMClientResponse<T> = (LMResponse<T>) -> (Void)

extension LMChatClient {
    
    func initialize() {
    }

    public func initiateUser(request: InitiateUserRequest, response: LMClientResponse<InitiateUserResponse>?) {
        ChatClientServiceRequest.initiateChatService(request, withModuleName: moduleName) { result in
            TokenManager.shared.updateToken(result.data?.accessToken, result.data?.refreshToken)
            if !(result.data?.appAccess ?? false){
                let logoutRequest = LogoutRequest.builder()
                    .deviceId(request.deviceId ?? "")
                    .refreshToken(result.data?.refreshToken ?? "")
                    .build()
                self.logout(request: logoutRequest, response: nil)
            } else {
                
            }
            response?(result)
        }
    }

    public func registerDevice(request: RegisterDeviceRequest, response: LMClientResponse<RegisterDeviceResponse>?) {
        ChatClientServiceRequest.registerDevice(request: request, withModuleName: moduleName) { result in
            response?(result)
        }
    }
    
    public func logout(request: LogoutRequest, response: LMClientResponse<NoData>?) {
        ChatClientServiceRequest.logout(request: request, withModuleName: moduleName) { result in
            response?(result)
        }
    }
    
    public func getConfig(response: LMClientResponse<ConfigResponse>?) {
        
    }
    
    public func getHomeFeed(request: GetHomeFeedRequest, response: LMClientResponse<GetHomeFeedResponse>?) {
        
    }
    
    public func getExploreTabCount(response: LMClientResponse<GetExploreTabCountResponse>?) {
        
    }
    
    public func getExploreFeed(request: GetExploreFeedRequest, response: LMClientResponse<GetExploreFeedResponse>?) {
        
    }
}
