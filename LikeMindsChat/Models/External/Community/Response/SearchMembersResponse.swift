//
//  SearchMembersResponse.swift
//  LikeMindsFeed
//
//  Created by Pushpendra Singh on 01/09/23.
//

import Foundation

public struct SearchMembersResponse: Decodable {
    public let community: Community?
    public let members: [Member]?
    public let totalFilteredMembers, totalMembers, totalOnlyMembers, totalPendingMembers: Int?
    
    enum CodingKeys: String, CodingKey {
        case community, members
        case totalFilteredMembers = "total_filtered_members"
        case totalMembers = "total_members"
        case totalOnlyMembers = "total_only_members"
        case totalPendingMembers = "total_pending_members"
    }
}
