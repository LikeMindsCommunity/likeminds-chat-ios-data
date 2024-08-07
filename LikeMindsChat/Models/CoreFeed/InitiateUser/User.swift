//
//  User.swift
//  LMCore
//
//  Created by Pushpendra Singh on 19/02/23.
//

import Foundation

public struct User: Codable {
    public var id: String?
    public var imageUrl, name, organisationName: String?
    public var userUniqueID, uuid: String?
    public var isGuest: Bool = false
    public var isDeleted: Bool?
    public var isOwner: Bool?
    public var customTitle: String?
    public var state, updatedAt: Int?
    public var sdkClientInfo: SDKClientInfo?
    
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
    }
    
    init(id: String?, imageUrl: String?) {
        self.id = id
        self.imageUrl = imageUrl
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIntToStringIfPresent(forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        self.organisationName = try container.decodeIfPresent(String.self, forKey: .organisationName)
        self.userUniqueID = try container.decodeIfPresent(String.self, forKey: .userUniqueID)
        self.isGuest = try container.decode(Bool.self, forKey: .isGuest)
        self.isDeleted = try container.decodeIfPresent(Bool.self, forKey: .isDeleted)
        self.isOwner = try container.decodeIfPresent(Bool.self, forKey: .isOwner)
        self.customTitle = try container.decodeIfPresent(String.self, forKey: .customTitle)
        self.state = try container.decodeIfPresent(Int.self, forKey: .state)
        self.updatedAt = try container.decodeIfPresent(Int.self, forKey: .updatedAt)
        self.sdkClientInfo = try container.decode(SDKClientInfo.self, forKey: .sdkClientInfo)
        self.uuid = try container.decodeIfPresent(String.self, forKey: .uuid)
    }
    // Using UUID for user unique id
    public var clientUUID: String? {
        return self.sdkClientInfo?.uuid
    }
}
