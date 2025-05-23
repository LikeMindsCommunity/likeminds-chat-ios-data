//
//  ReactionRO.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 01/01/24.
//

import Foundation
import RealmSwift

class ReactionRO: EmbeddedObject {
    @Persisted var member: MemberRO?
    @Persisted var reaction: String?
}
