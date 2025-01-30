//
//  _Cohort_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 09/01/24.
//

import Foundation

public struct Cohort: Decodable {
    public let id: Int?
    public let totalMembers: Int?
    public let name: String?
    public let members: [Member]?
    
    private enum CodingKeys: String, CodingKey {
        case id = "cohort_id"
        case totalMembers = "total_members"
        case name
        case members
    }
    
    public init(id: Int?, totalMembers: Int?, name: String?, members: [Member]?) {
        self.id = id
        self.totalMembers = totalMembers
        self.name = name
        self.members = members
    }
}

extension Cohort {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        totalMembers = try container.decodeIfPresent(Int.self, forKey: .totalMembers)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        members = try container.decodeIfPresent([Member].self, forKey: .members)
    }
}
