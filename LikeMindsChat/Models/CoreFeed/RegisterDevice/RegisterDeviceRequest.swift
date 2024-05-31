//
//  RegisterDeviceRequest.swift
//  LMCore
//
//  Created by Pushpendra Singh on 20/02/23.
//

import Foundation

public class RegisterDeviceRequest: Encodable {
    var deviceId: String? //unique device id
    var token: String? // firebase device token
    
    /// Initiate method
    private init() {}
    
    public static func builder() -> RegisterDeviceRequest {
        return RegisterDeviceRequest()
    }
    
    public func build() -> RegisterDeviceRequest {
        return self
    }
    
    enum CodingKeys: String, CodingKey {
        case token
        case deviceId = "device_id"
    }
    
    public func deviceId(_ deviceId: String) -> RegisterDeviceRequest {
        self.deviceId = deviceId
        return self
    }
    
    public func token(_ token: String) -> RegisterDeviceRequest {
        self.token = token
        return self
    }
}
