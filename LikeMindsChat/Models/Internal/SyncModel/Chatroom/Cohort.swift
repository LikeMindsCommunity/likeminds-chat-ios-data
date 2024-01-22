//
//  _Cohort_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 09/01/24.
//

import Foundation

struct Cohort: Decodable {
    let id: Int?
    let totalMembers: Int?
    let name: String?
    let members: [Member]?
    
    private enum CodingKeys: String, CodingKey {
        case id = "cohort_id"
        case totalMembers = "total_members"
        case name
        case members
    }
}

extension _Cohort_ {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        totalMembers = try container.decodeIfPresent(Int.self, forKey: .totalMembers)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        members = try container.decodeIfPresent([_Member_].self, forKey: .members)
    }
}
