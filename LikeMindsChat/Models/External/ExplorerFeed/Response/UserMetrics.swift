//
//  UserMetrics.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 17/01/24.
//

import Foundation

struct UserMetrics: Decodable {
    let firstLogin: String?
    let firstLoginEpoch: Int?
    let countCommunitiesJoined: Int?
    let nameCommunitiesJoined: String?
    let isAnyCommunityPromoter: Bool?
    let uniqueChatroomResponded: Int?
    let countChatroomCreated: Int?
    let countChatroomFollowed: Int?
    
    enum CodingKeys: String, CodingKey {
        case firstLogin = "first_login"
        case firstLoginEpoch = "first_login_epoch"
        case countCommunitiesJoined = "count_communities_joined"
        case nameCommunitiesJoined = "name_communities_joined"
        case isAnyCommunityPromoter = "is_any_community_promoter"
        case uniqueChatroomResponded = "unique_chatroom_responded"
        case countChatroomCreated = "count_chatroom_created"
        case countChatroomFollowed = "count_chatroom_followed"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstLogin = try container.decode(String.self, forKey: .firstLogin)
        firstLoginEpoch = try container.decode(Int.self, forKey: .firstLoginEpoch)
        countCommunitiesJoined = try container.decode(Int.self, forKey: .countCommunitiesJoined)
        nameCommunitiesJoined = try container.decodeIfPresent(String.self, forKey: .nameCommunitiesJoined)
        isAnyCommunityPromoter = try container.decode(Bool.self, forKey: .isAnyCommunityPromoter)
        uniqueChatroomResponded = try container.decode(Int.self, forKey: .uniqueChatroomResponded)
        countChatroomCreated = try container.decode(Int.self, forKey: .countChatroomCreated)
        countChatroomFollowed = try container.decode(Int.self, forKey: .countChatroomFollowed)
    }
}

