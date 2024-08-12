//
//  LMMeta.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 24/07/24.
//

import Foundation

public struct LMMeta: Decodable {
    public let options: [PollOption]
    public let pollAnswerText: String?
    public let isShowResult: Bool?
    public let voteCount: Int?
    
    public enum CodingKeys: String, CodingKey {
        case options
        case pollAnswerText = "poll_answer_text"
        case isShowResult = "to_show_results"
        case voteCount = "voters_count"
    }
}
