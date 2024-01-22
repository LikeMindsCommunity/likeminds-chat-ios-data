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
            TokenManager.shared.updateToken(result.data?.accessToken, result.data?.refreshToken)
            if !(result.data?.appAccess ?? false){
                let logoutRequest = LogoutRequest.builder()
                    .deviceId(request.deviceId ?? "")
                    .refreshToken(result.data?.refreshToken ?? "")
                    .build()
                self.logout(request: logoutRequest, response: nil)
            } else {
                guard let user = result.data?.user else {
                    return
                }
                let lmUUID = user.uuid ?? ""
                let lmMemberId = user.id ?? 0
                let clientUUID = user.sdkClientInfo.uuid
                
                UserPreferences.shared.setLMUUID(lmUUID)
                UserPreferences.shared.setLMMemberId("\(lmMemberId)")
                UserPreferences.shared.setClientUUID(clientUUID)
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
        
    }
    
    public func getHomeFeed(request: GetHomeFeedRequest, response: LMClientResponse<GetHomeFeedResponse>?) {
        
    }
    
    public func getExploreTabCount(response: LMClientResponse<GetExploreTabCountResponse>?) {
        
    }
    
    public func getExploreFeed(request: GetExploreFeedRequest, response: LMClientResponse<GetExploreFeedResponse>?) {
        
    }
    
    func syncChatrooms() {
        let firstTimeOpenSync = FirstTimeChatroomSyncOperation(chatroomTypes: [])
        
    }
}
