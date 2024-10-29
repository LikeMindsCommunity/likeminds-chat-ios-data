//
//  _Member_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 20/12/23.
//

import Foundation


public struct Member: Decodable {
    
    public private(set) var id: String?
    public private(set) var userUniqueId: String?
    public private(set) var name: String?
    public private(set) var imageUrl: String?
    public private(set) var questionAnswers: [Question]?
    public private(set) var state: Int?
    public private(set) var isGuest: Bool = false
    public private(set) var customIntroText: String?
    public private(set) var customClickText: String?
    public private(set) var memberSince: String?
    public private(set) var communityName: String?
    public private(set) var isOwner: Bool = false
    public private(set) var isDeleted: Bool?
    public private(set) var customTitle: String?
    public private(set) var menu: [MemberAction]?
    public private(set) var communityId: String?
    public private(set) var chatroomId: String?
    public private(set) var route: String?
    public private(set) var attendingStatus: Bool?
    public private(set) var hasProfileImage: Bool?
    public private(set) var updatedAt: Int?
    public private(set) var sdkClientInfo: SDKClientInfo?
    public private(set) var uuid: String?
    public private(set) var roles: [UserRole]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, roles
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
    
    init(){}
    
    public init(from decoder: Decoder) throws {
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
        communityId = try container.decodeIntToStringIfPresent(forKey: .communityId)
        chatroomId = try container.decodeIntToStringIfPresent(forKey: .chatroomId)
        route = try container.decodeIfPresent(String.self, forKey: .route)
        attendingStatus = try container.decodeIfPresent(Bool.self, forKey: .attendingStatus)
        hasProfileImage = try container.decodeIfPresent(Bool.self, forKey: .hasProfileImage)
        updatedAt = try container.decodeIfPresent(Int.self, forKey: .updatedAt)
        sdkClientInfo = try container.decodeIfPresent(SDKClientInfo.self, forKey: .sdkClientInfo)
        uuid = try container.decodeIfPresent(String.self, forKey: .uuid)
        roles = try container.decodeIfPresent([UserRole].self, forKey: .roles)
    }
    
    
    // Using UUID for user unique id
    var clientUUID: String? {
        return self.sdkClientInfo?.uuid ?? ""
    }
    class Builder {
        private var id: String = ""
        private var userUniqueId: String = ""
        private var name: String = ""
        private var imageUrl: String = ""
        private var questionAnswers: [Question]?
        private var state: Int?
        private var isGuest: Bool = false
        private var customIntroText: String?
        private var customClickText: String?
        private var memberSince: String?
        private var communityName: String?
        private var isOwner: Bool = false
        private var customTitle: String?
        private var menu: [MemberAction]?
        private var communityId: String?
        private var chatroomId: String?
        private var route: String?
        private var attendingStatus: Bool?
        private var hasProfileImage: Bool?
        private var updatedAt: Int?
        private var sdkClientInfo: SDKClientInfo?
        private var uuid: String = ""
        private var roles: [UserRole] = []
        
        @discardableResult
        func id(_ id: String) -> Builder {
            self.id = id
            return self
        }
        
        func userUniqueId(_ userUniqueId: String) -> Builder {
            self.userUniqueId = userUniqueId
            return self
        }
        
        func name(_ name: String) -> Builder {
            self.name = name
            return self
        }
        
        func imageUrl(_ imageUrl: String) -> Builder {
            self.imageUrl = imageUrl
            return self
        }
        
        func questionAnswers(_ questionAnswers: [Question]?) -> Builder {
            self.questionAnswers = questionAnswers
            return self
        }
        
        func state(_ state: Int?) -> Builder {
            self.state = state
            return self
        }
        
        func isGuest(_ isGuest: Bool) -> Builder {
            self.isGuest = isGuest
            return self
        }
        
        func customIntroText(_ customIntroText: String?) -> Builder {
            self.customIntroText = customIntroText
            return self
        }
        
        func customClickText(_ customClickText: String?) -> Builder {
            self.customClickText = customClickText
            return self
        }
        
        func memberSince(_ memberSince: String?) -> Builder {
            self.memberSince = memberSince
            return self
        }
        
        func communityName(_ communityName: String?) -> Builder {
            self.communityName = communityName
            return self
        }
        
        func isOwner(_ isOwner: Bool) -> Builder {
            self.isOwner = isOwner
            return self
        }
        
        func customTitle(_ customTitle: String?) -> Builder {
            self.customTitle = customTitle
            return self
        }
        
        func menu(_ menu: [MemberAction]?) -> Builder {
            self.menu = menu
            return self
        }
        
        func communityId(_ communityId: String?) -> Builder {
            self.communityId = communityId
            return self
        }
        
        func chatroomId(_ chatroomId: String?) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func route(_ route: String?) -> Builder {
            self.route = route
            return self
        }
        
        func attendingStatus(_ attendingStatus: Bool?) -> Builder {
            self.attendingStatus = attendingStatus
            return self
        }
        
        func hasProfileImage(_ hasProfileImage: Bool?) -> Builder {
            self.hasProfileImage = hasProfileImage
            return self
        }
        
        func updatedAt(_ updatedAt: Int?) -> Builder {
            self.updatedAt = updatedAt
            return self
        }
        
        func sdkClientInfo(_ sdkClientInfo: SDKClientInfo?) -> Builder {
            self.sdkClientInfo = sdkClientInfo
            return self
        }
        
        func uuid(_ uuid: String) -> Builder {
            self.uuid = uuid
            return self
        }
        
        func roles(_ roles: [UserRole]) -> Builder{
            self.roles = roles
            return self
        }
        
        func build() -> Member {
            var member = Member()
            member.id = self.id
            member.userUniqueId = self.userUniqueId
            member.name = self.name
            member.imageUrl = self.imageUrl
            member.questionAnswers = self.questionAnswers
            member.state = self.state
            member.isGuest = self.isGuest
            member.customIntroText = self.customIntroText
            member.customClickText = self.customClickText
            member.memberSince = self.memberSince
            member.communityName = self.communityName
            member.isOwner = self.isOwner
            member.customTitle = self.customTitle
            member.menu = self.menu
            member.communityId = self.communityId
            member.chatroomId = self.chatroomId
            member.route = self.route
            member.attendingStatus = self.attendingStatus
            member.hasProfileImage = self.hasProfileImage
            member.updatedAt = self.updatedAt
            member.sdkClientInfo = self.sdkClientInfo
            member.uuid = self.uuid
            member.roles = self.roles
            return member
        }
    }
    
    func toBuilder() -> Builder {
        return Builder()
            .id(id ?? "")
            .userUniqueId(userUniqueId ?? "")
            .name(name ?? "")
            .imageUrl(imageUrl ?? "")
            .questionAnswers(questionAnswers)
            .state(state)
            .isGuest(isGuest)
            .customIntroText(customIntroText)
            .customClickText(customClickText)
            .memberSince(memberSince)
            .communityName(communityName)
            .isOwner(isOwner)
            .customTitle(customTitle)
            .menu(menu)
            .communityId(communityId)
            .chatroomId(chatroomId)
            .route(route)
            .attendingStatus(attendingStatus)
            .hasProfileImage(hasProfileImage)
            .updatedAt(updatedAt)
            .sdkClientInfo(sdkClientInfo)
            .uuid(uuid ?? "")
            .roles(roles ?? [])
    }
    
    public func communityManager() -> String? {
        switch state {
        case 1:
            return "Community manager"
        default:
            return nil
        }
    }
}
