//
//  LogoutRequest.swift
//  LikeMindsFeed
//
//  Created by Pushpendra Singh on 28/06/23.
//

import Foundation

public class LogoutRequest: Encodable {
    var refreshToken: String?
    var deviceId: String?
    
    /// Initiate method
    private init() {}
    
    public static func builder() -> LogoutRequest {
        return LogoutRequest()
    }
    
    public func build() -> LogoutRequest {
        return self
    }
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
        case deviceId = "device_token"
    }
    
    public func refreshToken(_ refreshToken: String) -> LogoutRequest {
        self.refreshToken = refreshToken
        return self
    }
    
    public func deviceId(_ deviceId: String) -> LogoutRequest {
        self.deviceId = deviceId
        return self
    }
    
}
