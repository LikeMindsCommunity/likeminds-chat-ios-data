//
//  _Reaction_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 09/01/24.
//

import Foundation

public class Reaction: Decodable {
    public let member: Member?
    public let reaction: String
    
    private enum CodingKeys: String, CodingKey {
        case member
        case reaction
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        member = try container.decodeIfPresent(Member.self, forKey: .member)
        reaction = try container.decode(String.self, forKey: .reaction)
    }
    
    public static func builder() -> Builder {
        Builder()
    }
    
    private init(member: Member?, reaction: String) {
        self.member = member
        self.reaction = reaction
    }
    
    public class Builder {
        private var member: Member?
        private var reaction: String = ""
        
        public func member(_ member: Member?) -> Builder {
            self.member = member
            return self
        }
        
        public func reaction(_ reaction: String) -> Builder {
            self.reaction = reaction
            return self
        }
        
        public func build() -> Reaction {
            return Reaction(member: member, reaction: reaction)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder().reaction(reaction).member(member)
    }
}
