//
//  ConfigResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 17/01/24.
//

import Foundation

public struct ConfigResponse: Decodable {
    let access: Bool?
    let enableAudio: Bool?
    let enableGifs: Bool?
    let enableVoiceNote: Bool?
    let enableMicroPolls: Bool?
    let userDetails: UserDetail?
    
    private enum CodingKeys: String, CodingKey {
        case access
        case enableAudio = "enable_audio"
        case enableGifs = "enable_gif"
        case enableVoiceNote = "enable_voice_notes"
        case enableMicroPolls = "micro_polls_enabled"
        case userDetails = "user_detail"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        access = try container.decode(Bool.self, forKey: .access)
        enableAudio = try container.decode(Bool.self, forKey: .enableAudio)
        enableGifs = try container.decode(Bool.self, forKey: .enableGifs)
        enableVoiceNote = try container.decode(Bool.self, forKey: .enableVoiceNote)
        enableMicroPolls = try container.decode(Bool.self, forKey: .enableMicroPolls)
        userDetails = try container.decode(UserDetail.self, forKey: .userDetails)
    }
}

struct UserDetail: Decodable {
    let member: _Member_?
    let userMetrics: UserMetrics?
    
    private enum CodingKeys: String, CodingKey {
        case member = "user"
        case userMetrics = "user_metrics"
    }
}
