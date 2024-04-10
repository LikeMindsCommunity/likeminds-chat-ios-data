//
//  DecodeUrlResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 17/01/24.
//

import Foundation

public struct DecodeUrlResponse: Decodable {
    public let ogTags: LinkOGTags
    
    private enum CodingKeys: String, CodingKey {
        case ogTags = "og_tags"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        ogTags = try container.decode(LinkOGTags.self, forKey: .ogTags)
    }
}
