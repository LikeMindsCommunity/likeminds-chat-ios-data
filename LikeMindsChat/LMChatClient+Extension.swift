//
//  LMChatClient+Extension.swift
//  LMFeed
//
//  Created by Pushpendra Singh on 24/02/23.
//

import Foundation
import UIKit

public typealias LMClientResponse<T: Decodable> = (LMResponse<T>) -> (Void)

extension LMChatClient {
    
    func initialize() {
    }

    public func initiateUser(request: InitiateUserRequest, response: LMClientResponse<InitiateUserResponse>?) {
        ChatClientServiceRequest.initiateChatService(request, withModuleName: moduleName) { result in
            TokenManager.shared.accessToken = result.data?.accessToken
            TokenManager.shared.refreshToken = result.data?.refreshToken
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
