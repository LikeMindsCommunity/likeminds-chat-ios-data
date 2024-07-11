//
//  RegisterDeviceRequest.swift
//  LMCore
//
//  Created by Pushpendra Singh on 20/02/23.
//

import Foundation

public class RegisterDeviceRequest: Encodable {
    private(set) var deviceId: String?
    private(set) var token: String?
    
    private init(builder: Builder) {
        self.deviceId = builder.deviceId
        self.token = builder.token
    }
    
    public static func builder() -> Builder {
        return Builder()
    }
    
    public class Builder {
        var deviceId: String?
        var token: String?
        
        public init() {}
        
        public func deviceId(_ deviceId: String?) -> Builder {
            self.deviceId = deviceId
            return self
        }
        
        public func token(_ token: String?) -> Builder {
            self.token = token
            return self
        }
        
        public func build() -> RegisterDeviceRequest {
            return RegisterDeviceRequest(builder: self)
        }
    }
    
    public func toBuilder() -> Builder {
        var builder = Builder()
        if let deviceId = self.deviceId {
            builder = builder.deviceId(deviceId)
        }
        if let token = self.token {
            builder = builder.token(token)
        }
        return builder
    }
    
    enum CodingKeys: String, CodingKey {
        case token
        case deviceId = "device_id"
    }
}

