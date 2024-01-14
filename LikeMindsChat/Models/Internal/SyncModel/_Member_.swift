//
//  _Member_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 20/12/23.
//

import Foundation


struct _Member_: Decodable {
    
    var id: String?
    var userUniqueId: String?
    var name: String?
    var imageUrl: String?
    var questionAnswers: [_Question_]?
    var state: Int?
    var isGuest: Bool = false
    var customIntroText: String?
    var customClickText: String?
    var memberSince: String?
    var communityName: String?
    var isOwner: Bool = false
    var isDeleted: Bool?
    var customTitle: String?
    var menu: [_MemberAction_]?
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
    // Using UUID for user unique id
    var clientUUID: String? {
        return self.sdkClientInfo?.uuid ?? ""
    }
}
