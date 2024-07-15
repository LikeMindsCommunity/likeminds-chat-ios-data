//
//  InitiateUserRequest.swift
//  LMCore
//
//  Created by Pushpendra Singh on 15/02/23.
//

import Foundation

public class InitiateUserRequest: Encodable {
    private(set) var isGuest: Bool?
    private(set) var uuid: String?
    private(set) var userName: String?
    private(set) var apiKey: String?
    
    private init(builder: Builder) {
        self.isGuest = builder.isGuest
        self.uuid = builder.uuid
        self.userName = builder.userName
        self.apiKey = builder.apiKey
    }
    
    public static func builder() -> Builder {
        return Builder()
    }
    
    public class Builder {
        var isGuest: Bool?
        var uuid: String?
        var userName: String?
        var apiKey: String?
        
        public init() {}
        
        public func isGuest(_ isGuest: Bool) -> Builder {
            self.isGuest = isGuest
            return self
        }
        
        public func uuid(_ uuid: String) -> Builder {
            self.uuid = uuid
            return self
        }
        
        public func userName(_ userName: String) -> Builder {
            self.userName = userName
            return self
        }
        
        public func apiKey(_ apiKey: String) -> Builder {
            self.apiKey = apiKey
            return self
        }
        
        public func build() -> InitiateUserRequest {
            return InitiateUserRequest(builder: self)
        }
    }
    
    public func toBuilder() -> Builder {
        var builder = Builder()
        if let isGuest = self.isGuest {
           builder = builder.isGuest(isGuest)
        }
        if let uuid = self.uuid {
            builder = builder.uuid(uuid)
        }
        if let userName = self.userName {
            builder = builder.userName(userName)
        }
        if let apiKey = self.apiKey {
            builder = builder.apiKey(apiKey)
        }
        return builder
    }
    
    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case isGuest = "is_guest"
        case uuid
        case apiKey = "api_key"
    }
}
