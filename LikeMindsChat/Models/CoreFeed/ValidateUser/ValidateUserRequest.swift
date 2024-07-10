//
//  ValidateUserRequest.swift
//  LikeMindsChatData
//
//  Created by Anurag Tyagi on 02/07/24.    
//

import Foundation

public class ValidateUserRequest: Encodable {
    var accessToken: String
    var refreshToken: String
    
    private init() {
        accessToken = ""
        refreshToken = ""
    }
    
    public static func builder() -> ValidateUserRequest {
        return ValidateUserRequest()
    }
    
    public func build() -> ValidateUserRequest {
        return self
    }
    
    public func accessToken(_ accessToken: String) -> ValidateUserRequest {
        self.accessToken = accessToken
        return self
    }
    
    public func refreshToken(_ refreshToken: String) -> ValidateUserRequest {
        self.refreshToken = refreshToken
        return self
    }
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

