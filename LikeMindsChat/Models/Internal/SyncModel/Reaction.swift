//
//  _Reaction_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 09/01/24.
//

import Foundation

struct Reaction: Decodable {
    let member: Member?
    let reaction: String
    
    private enum CodingKeys: String, CodingKey {
        case member
        case reaction
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        member = try container.decodeIfPresent(Member.self, forKey: .member)
        reaction = try container.decode(String.self, forKey: .reaction)
    }
}
