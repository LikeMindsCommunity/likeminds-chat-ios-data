//
//  GetTaggingListResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 17/01/24.
//

import Foundation

struct GetTaggingListResponse: Decodable {
    let groupTags: [GroupTag]?
    let chatroomParticipants: [Member]?
    let communityMembers: [Member]?
    
    private enum CodingKeys: String, CodingKey {
        case groupTags = "group_tags"
        case chatroomParticipants = "chatroom_participants"
        case communityMembers = "community_members"
    }
}

struct GroupTag: Decodable {
    let description: String?
    let name: String?
    let route: String?
    let tag: String?
    let imageUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case description
        case name
        case route
        case tag
        case imageUrl = "image_url"
    }
}



