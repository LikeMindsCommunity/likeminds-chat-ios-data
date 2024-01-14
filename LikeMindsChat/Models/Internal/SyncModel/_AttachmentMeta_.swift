//
//  _AttachmentMeta_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 09/01/24.
//

import Foundation

struct _AttachmentMeta_: Decodable {
    let numberOfPage: Int?
    let size: Int64?
    let duration: Int?
    
    private enum CodingKeys: String, CodingKey {
        case numberOfPage = "number_of_page"
        case size
        case duration
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        numberOfPage = try container.decodeIfPresent(Int.self, forKey: .numberOfPage)
        size = try container.decodeIfPresent(Int64.self, forKey: .size)
        duration = try container.decodeIfPresent(Int.self, forKey: .duration)
    }
}
