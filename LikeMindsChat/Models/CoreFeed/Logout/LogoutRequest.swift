//
//  LogoutRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 28/06/23.
//

import Foundation

public class LogoutRequest: Encodable {
    private(set) var refreshToken: String?
    private(set) var deviceId: String?
    
    private init(builder: Builder) {
        self.refreshToken = builder.refreshToken
        self.deviceId = builder.deviceId
    }
    
    public static func builder() -> Builder {
        return Builder()
    }
    
    public class Builder {
        var refreshToken: String?
        var deviceId: String?
        
        public init() {}
        
        public func refreshToken(_ refreshToken: String?) -> Builder {
            self.refreshToken = refreshToken
            return self
        }
        
        public func deviceId(_ deviceId: String?) -> Builder {
            self.deviceId = deviceId
            return self
        }
        
        public func build() -> LogoutRequest {
            return LogoutRequest(builder: self)
        }
    }
    
    public func toBuilder() -> Builder {
        var builder = Builder()
        if let refreshToken = self.refreshToken {
            builder = builder.refreshToken(refreshToken)
        }
        if let deviceId = self.deviceId {
            builder = builder.deviceId(deviceId)
        }
        return builder
    }
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
        case deviceId = "device_token"
    }
}
