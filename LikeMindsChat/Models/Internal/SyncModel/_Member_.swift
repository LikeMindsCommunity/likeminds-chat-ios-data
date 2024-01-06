//
//  _Member_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 20/12/23.
//

import Foundation


public struct _Member_: Codable {
    public let id: Int?
    public let imageUrl, name, organisationName: String?
    public let userUniqueID, uuid: String?
    public let isGuest: Bool?
    public let isDeleted: Bool?
    public let isOwner: Bool?
    public let customTitle: String?
    public let state, updatedAt: Int?
    public let sdkClientInfo: SDKClientInfo?
    public let emails: [Email]?
    public let mobiles: [Mobile]?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageUrl = "image_url"
        case organisationName = "organisation_name"
        case userUniqueID = "user_unique_id"
        case isGuest = "is_guest"
        case isDeleted = "is_deleted"
        case isOwner = "is_owner"
        case customTitle = "custom_title"
        case state
        case updatedAt = "updated_at"
        case sdkClientInfo = "sdk_client_info"
        case uuid
        case emails, mobiles
    }
    // Using UUID for user unique id
    public var clientUUID: String? {
        return self.sdkClientInfo?.uuid ?? ""
    }
}

public struct Mobile : Codable {
    let countryCode, id, mobileNo, state: Int?
    let userID: Int?
    
    enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case id
        case mobileNo = "mobile_no"
        case state
        case userID = "user_id"
    }
    
}
public struct Email: Codable {
    let email: String?
    let id, state, userID: Int?
    let verified: Bool?
    
    enum CodingKeys: String, CodingKey {
        case email, id, state
        case userID = "user_id"
        case verified
    }
}
