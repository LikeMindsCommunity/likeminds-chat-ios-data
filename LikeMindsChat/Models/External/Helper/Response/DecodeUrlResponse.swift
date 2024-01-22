//
//  DecodeUrlResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 17/01/24.
//

import Foundation

struct DecodeUrlResponse: Decodable {
    let ogTags: LinkOGTags
    
    private enum CodingKeys: String, CodingKey {
        case ogTags = "og_tags"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        ogTags = try container.decode(LinkOGTags.self, forKey: .ogTags)
    }
}
