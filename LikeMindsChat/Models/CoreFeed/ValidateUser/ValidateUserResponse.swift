//
//  ValidateUserResponse.swift
//  LikeMindsChatData
//
//  Created by Anurag Tyagi on 02/07/24.
//

import Foundation

public struct ValidateUserResponse: Decodable {
    public let appAccess: Bool?
    public let community: Community?
    public let hasAnswers: Bool?
    public let user: User?
    
    enum CodingKeys: String, CodingKey {
        case appAccess = "app_access"
        case community
        case hasAnswers = "has_answers"
        case user
    }
}
