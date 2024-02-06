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
    
    private init(member: Member?, reaction: String) {
        self.member = member
        self.reaction = reaction
    }
    
    class Builder {
        private var member: Member?
        private var reaction: String = ""
        
        func member(_ member: Member?) -> Builder {
            self.member = member
            return self
        }
        
        func reaction(_ reaction: String) -> Builder {
            self.reaction = reaction
            return self
        }
        
        func build() -> Reaction {
            return Reaction(member: member, reaction: reaction)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().reaction(reaction).member(member)
    }
}
