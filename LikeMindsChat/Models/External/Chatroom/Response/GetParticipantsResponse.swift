//
//  GetParticipantsResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

struct GetParticipantsResponse: Decodable {
    var canEditParticipant: Bool
    var participants: [Member]
    var totalParticipantsCount: Int
}
