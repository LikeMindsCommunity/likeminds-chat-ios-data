//
//  PollRO.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 01/01/24.
//

import Foundation
import RealmSwift

class PollRO: EmbeddedObject {
    @Persisted var id: String = ""
    @Persisted var text: String = ""
    @Persisted var subText: String?
    @Persisted var isSelected: Bool?
    @Persisted var percentage: Double?
    @Persisted var noVotes: Int?
    @Persisted var member: MemberRO?
}
