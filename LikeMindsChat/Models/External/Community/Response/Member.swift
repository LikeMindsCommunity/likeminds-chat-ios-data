//
//  Member.swift
//  RealmRestSync
//
//  Created by Pushpendra Singh on 19/12/23.
//  Copyright © 2023 LikeMinds. All rights reserved.
//

import Foundation

struct Member {
    var id: String
    var userUniqueId: String
    var name: String
    var imageUrl: String
    var questionAnswers: [Question]?
    var state: Int?
    var isGuest: Bool
    var customIntroText: String?
    var customClickText: String?
    var memberSince: String?
    var communityName: String?
    var isOwner: Bool?
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
}
