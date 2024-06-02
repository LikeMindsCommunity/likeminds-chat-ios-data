//
//  InitiateUserResponse.swift
//  LMCore
//
//  Created by Pushpendra Singh on 15/02/23.
//

import Foundation

public struct InitiateUserResponse: Decodable {
    public let accessToken: String
    public let appAccess: Bool?
    public let community: Community?
    public let hasAnswers: Bool?
    public let refreshToken: String?
    public let user: User?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case appAccess = "app_access"
        case community
        case hasAnswers = "has_answers"
        case refreshToken = "refresh_token"
        case user
    }
}


public struct InitialUser: Decodable {
    public let user: User //user data
    public let community: Community //community data
}

// MARK: - SDKClientInfo
public struct SDKClientInfo: Codable {
    public let community, user: Int?
    public let userUniqueID, uuid: String?
    
    enum CodingKeys: String, CodingKey {
        case community, user
        case userUniqueID = "user_unique_id"
        case uuid
    }
}
