//
//  _Reaction_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 09/01/24.
//

import Foundation

struct _Reaction_: Decodable {
    let member: _Member_?
    let reaction: String
    
    private enum CodingKeys: String, CodingKey {
        case member
        case reaction
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        member = try container.decodeIfPresent(_Member_.self, forKey: .member)
        reaction = try container.decode(String.self, forKey: .reaction)
    }
}
