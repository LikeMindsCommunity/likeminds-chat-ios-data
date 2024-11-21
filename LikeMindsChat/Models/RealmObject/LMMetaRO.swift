//
//  LMMetaRO.swift
//  Pods
//
//  Created by Anurag Tyagi on 20/11/24.
//

import Foundation
import RealmSwift

class LMMetaRO: EmbeddedObject {
    @Persisted var pollAnswerText: String?
    @Persisted var isShowResult: Bool?
    @Persisted var voteCount: Int?
    @Persisted var options: List<PollOptionRO>  // Assuming PollOptionRO is the Realm version of PollOption
}

class PollOptionRO: EmbeddedObject {
    @Persisted var id: String?
    @Persisted var text: String?
    @Persisted var isSelected: Bool
    @Persisted var percentage: Double
    @Persisted var uuid: String?
    @Persisted var voteCount: Int
}
