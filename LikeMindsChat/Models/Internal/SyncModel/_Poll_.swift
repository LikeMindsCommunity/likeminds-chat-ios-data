//
//  ConversationPollOptionMetaNetworkModel.swift
//  CollabMates
//
//  Created by Devansh Mohata on 20/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

struct _Poll_: Decodable {
    let conversationID: Int?
    let count: Int?
    let id: Int?
    let isSelected: Bool?
    let voteCount: Int?
    let percentage: Double?
    let text: String?
    let userID: Int?
    
    enum CodingKeys: String, CodingKey {
        case conversationID = "conversation_id",
             isSelected = "is_selected",
             voteCount = "no_votes",
             userID = "user_id"
        case count,
             id,
             percentage,
             text
    }
}
