//
//  GetParticipantsResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

public struct GetParticipantsResponse: Decodable {
    public var canEditParticipant: Bool?
    public var participants: [Member]?
    public var totalParticipantsCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case canEditParticipant = "can_edit_participant"
        case participants
        case totalParticipantsCount = "total_participants_count"
    }
}
