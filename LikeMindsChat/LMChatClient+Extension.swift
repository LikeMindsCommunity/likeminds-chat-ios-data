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

    public func initiateUser(request: InitiateUserRequest, response: _LMClientResponse_<InitiateUserResponse>?) {
        InitiateUserClient.initiateChatService(request, withModuleName: moduleName) { result in
            if result.success {
                self.syncChatrooms()
            }
            response?(result)
        }
    }

    public func registerDevice(request: RegisterDeviceRequest, response: _LMClientResponse_<RegisterDeviceResponse>?) {
        InitiateUserClient.registerDevice(request: request, withModuleName: moduleName) { result in
            response?(result)
        }
    }
    
    public func logout(request: LogoutRequest, response: _LMClientResponse_<_NoData_>?) {
        InitiateUserClient.logout(request: request, withModuleName: moduleName) { result in
            response?(result)
        }
    }
    
    public func getConfig(response: _LMClientResponse_<ConfigResponse>?) {
        InitiateUserClient.getConfig(withModuleName: moduleName) { result in
            response?(result)
        }
    }
    
    public func getHomeFeed(request: GetHomeFeedRequest, response: LMClientResponse<GetHomeFeedResponse>?) {
        
    }
    
    public func getExploreTabCount(response: LMClientResponse<GetExploreTabCountResponse>?) {
        HomeFeedClient.getExploreTabCount(withModuleName: moduleName) { response in
            
        }
    }
    
    public func getExploreFeed(request: GetExploreFeedRequest, response: LMClientResponse<GetExploreFeedResponse>?) {
        
    }
    
    func syncChatrooms() {
        SyncOperationUtil.startFirstHomeFeedSync { respone in
            print(respone)
        }
    }
    
    func getChatrooms() {
        
    }
}
