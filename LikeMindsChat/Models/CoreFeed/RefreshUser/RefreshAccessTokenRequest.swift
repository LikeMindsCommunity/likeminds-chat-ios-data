//
//  RefreshAccessTokenRequest.swift
//  LikeMindsChatData
//
//  Created by Anurag Tyagi on 04/07/24.
//

import Foundation

public class RefreshAccessTokenRequest : Encodable{
    var refreshToken: String
    
    private init() {
        self.refreshToken = ""
    }
    
    public static func builder() -> RefreshAccessTokenRequest{
        return RefreshAccessTokenRequest()
    }
    
    public func build() -> RefreshAccessTokenRequest{
        return self
    }
    
    public func refreshToken(refreshToken: String) -> RefreshAccessTokenRequest {
        self.refreshToken = refreshToken
        return self
    }
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}
