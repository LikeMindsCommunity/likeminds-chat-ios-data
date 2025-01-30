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
    public let user: User  //user data
    public let community: Community  //community data
}

/// Holds additional client-related data, such as unique IDs that link a user to a
/// particular community.
///
/// This struct is Codable, so it can be easily serialized to/from JSON.
public struct SDKClientInfo: Codable {

    /// An optional integer representing the community ID.
    public let community: Int?

    /// An optional integer representing the user’s ID within the community.
    public let user: Int?

    /// An optional string representing the user’s unique ID (distinct from user ID).
    public let userUniqueID: String?

    /// An optional string representing a unique identifier (UUID) for the user.
    public let uuid: String?

    /// Coding keys to map between JSON property names and struct property names.
    enum CodingKeys: String, CodingKey {
        case community, user
        case userUniqueID = "user_unique_id"
        case uuid
    }
    
    public init(community: Int?, user: Int?, userUniqueID: String?, uuid: String?) {
        self.community = community
        self.user = user
        self.userUniqueID = userUniqueID
        self.uuid = uuid
    }
}
