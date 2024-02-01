//
//  _Member_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 20/12/23.
//

import Foundation


struct Member: Decodable {
    
    var id: String?
    var userUniqueId: String?
    var name: String?
    var imageUrl: String?
    var questionAnswers: [Question]?
    var state: Int?
    var isGuest: Bool = false
    var customIntroText: String?
    var customClickText: String?
    var memberSince: String?
    var communityName: String?
    var isOwner: Bool = false
    var isDeleted: Bool?
    var customTitle: String?
    var menu: [MemberAction]?
    var communityId: Int?
    var chatroomId: Int?
    var route: String?
    var attendingStatus: Bool?
    var hasProfileImage: Bool?
    var updatedAt: Int?
    var sdkClientInfo: SDKClientInfo?
    var uuid: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageUrl = "image_url"
        case userUniqueId = "user_unique_id"
        case isGuest = "is_guest"
        case isDeleted = "is_deleted"
        case isOwner = "is_owner"
        case customTitle = "custom_title"
        case state, menu, route
        case updatedAt = "updated_at"
        case sdkClientInfo = "sdk_client_info"
        case uuid
        case questionAnswers = "question_answers"
        case customIntroText = "custom_intro_text"
        case customClickText = "custom_click_text"
        case memberSince = "member_since"
        case communityName = "community_name"
        case communityId = "community_id"
        case chatroomId = "chatroom_id"
        case attendingStatus = "attending_status"
        case hasProfileImage = "has_profile_image"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode your properties using the container
        id = try container.decodeIntToStringIfPresent(forKey: .id)
        userUniqueId = try container.decodeIfPresent(String.self, forKey: .userUniqueId)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        questionAnswers = try container.decodeIfPresent([Question].self, forKey: .questionAnswers)
        state = try container.decodeIfPresent(Int.self, forKey: .state)
        isGuest = try container.decodeIfPresent(Bool.self, forKey: .isGuest) ?? false
        customIntroText = try container.decodeIfPresent(String.self, forKey: .customIntroText)
        customClickText = try container.decodeIfPresent(String.self, forKey: .customClickText)
        memberSince = try container.decodeIfPresent(String.self, forKey: .memberSince)
        communityName = try container.decodeIfPresent(String.self, forKey: .communityName)
        isOwner = try container.decodeIfPresent(Bool.self, forKey: .isOwner) ?? false
        isDeleted = try container.decodeIfPresent(Bool.self, forKey: .isDeleted)
        customTitle = try container.decodeIfPresent(String.self, forKey: .customTitle)
        menu = try container.decodeIfPresent([MemberAction].self, forKey: .menu)
        communityId = try container.decodeIfPresent(Int.self, forKey: .communityId)
        chatroomId = try container.decodeIfPresent(Int.self, forKey: .chatroomId)
        route = try container.decodeIfPresent(String.self, forKey: .route)
        attendingStatus = try container.decodeIfPresent(Bool.self, forKey: .attendingStatus)
        hasProfileImage = try container.decodeIfPresent(Bool.self, forKey: .hasProfileImage)
        updatedAt = try container.decodeIfPresent(Int.self, forKey: .updatedAt)
        sdkClientInfo = try container.decodeIfPresent(SDKClientInfo.self, forKey: .sdkClientInfo)
        uuid = try container.decodeIfPresent(String.self, forKey: .uuid)
    }
    
    // Using UUID for user unique id
    var clientUUID: String? {
        return self.sdkClientInfo?.uuid ?? ""
    }
}
