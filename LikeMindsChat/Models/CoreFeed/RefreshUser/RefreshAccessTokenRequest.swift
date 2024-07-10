//
//  RefreshAccessTokenRequest.swift
//  LikeMindsChatData
//
//  Created by Anurag Tyagi on 04/07/24.
//

import Foundation

public class RefreshAccessTokenRequest: Encodable {
    private(set) var refreshToken: String
    
    private init(builder: Builder) {
        self.refreshToken = builder.refreshToken
    }
    
    public static func builder() -> Builder {
        return Builder()
    }
    
    public class Builder {
        var refreshToken: String = ""
        
        public init() {}
        
        public func refreshToken(_ refreshToken: String) -> Builder {
            self.refreshToken = refreshToken
            return self
        }
        
        public func build() -> RefreshAccessTokenRequest {
            return RefreshAccessTokenRequest(builder: self)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder().refreshToken(refreshToken)
    }
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}
