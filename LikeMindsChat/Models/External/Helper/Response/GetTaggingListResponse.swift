//
//  GetTaggingListResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 17/01/24.
//

import Foundation

public struct GetTaggingListResponse: Decodable {
    public let groupTags: [GroupTag]?
    public let chatroomParticipants: [Member]?
    public let communityMembers: [Member]?
    
    private enum CodingKeys: String, CodingKey {
        case groupTags = "group_tags"
        case chatroomParticipants = "chatroom_participants"
        case communityMembers = "community_members"
    }
}

public struct GroupTag: Decodable {
    public let description: String?
    public let name: String?
    public let route: String?
    public let tag: String?
    public let imageUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case description
        case name
        case route
        case tag
        case imageUrl = "image_url"
    }
}
