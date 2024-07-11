//
//  ValidateUserRequest.swift
//  LikeMindsChatData
//
//  Created by Anurag Tyagi on 02/07/24.    
//

import Foundation

public class ValidateUserRequest: Encodable {
    private(set) var accessToken: String
    private(set) var refreshToken: String
    
    private init(builder: Builder) {
        self.accessToken = builder.accessToken
        self.refreshToken = builder.refreshToken
    }
    
    public static func builder() -> Builder {
        return Builder()
    }
    
    public class Builder {
        var accessToken: String = ""
        var refreshToken: String = ""
        
        public init() {}
        
        public func accessToken(_ accessToken: String) -> Builder {
            self.accessToken = accessToken
            return self
        }
        
        public func refreshToken(_ refreshToken: String) -> Builder {
            self.refreshToken = refreshToken
            return self
        }
        
        public func build() -> ValidateUserRequest {
            return ValidateUserRequest(builder: self)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder()
            .accessToken(accessToken)
            .refreshToken(refreshToken)
    }
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
