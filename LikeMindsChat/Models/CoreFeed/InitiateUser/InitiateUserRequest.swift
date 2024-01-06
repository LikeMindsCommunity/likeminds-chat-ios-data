//
//  InitiateUserRequest.swift
//  LMCore
//
//  Created by Pushpendra Singh on 15/02/23.
//

import Foundation

public class InitiateUserRequest: Encodable {
    var isGuest: Bool? //true for guest user else false
    var uuid: String? //unique id of user
    var userName: String? //user name
    var apiKey: String?
    var page: Int = 10 //page number of home feed chat
    
    /// Initiate method
    private init() {}
    
    public static func builder() -> InitiateUserRequest {
        return InitiateUserRequest()
    }
    
    public func apiKey(_ apiKey: String) -> InitiateUserRequest {
        self.apiKey = apiKey
        return self
    }
    
    public func isGuest(_ isGuest: Bool) -> InitiateUserRequest {
        self.isGuest = isGuest
        return self
    }
    
    public func userName(_ userName: String) -> InitiateUserRequest {
        self.userName = userName
        return self
    }
    
    public func uuid(_ uuid: String) -> InitiateUserRequest {
        self.uuid = uuid
        return self
    }
    
    public func page(_ page: Int) -> InitiateUserRequest {
        self.page = page
        return self
    }
    
    public func build() -> InitiateUserRequest {
        return self
    }
    
    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case isGuest = "is_guest"
        case uuid
        case apiKey = "api_key"
        case page
    }
}
