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

    // Converts LMMeta to a dictionary
    public func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]

        dict["options"] = options.map { $0.toDictionary() }  // Assuming PollOption has a toDictionary method
        dict["poll_answer_text"] = pollAnswerText
        dict["to_show_results"] = isShowResult
        dict["voters_count"] = voteCount

        return dict
    }
}
