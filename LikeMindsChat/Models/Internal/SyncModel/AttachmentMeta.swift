//
//  _AttachmentMeta_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 09/01/24.
//

import Foundation

public struct AttachmentMeta: Codable {
    public let numberOfPage: Int?
    public let size: Int64?
    public let duration: Int?
    
    private enum CodingKeys: String, CodingKey {
        case numberOfPage = "number_of_page"
        case size
        case duration
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        numberOfPage = try container.decodeIfPresent(Int.self, forKey: .numberOfPage)
        size = try container.decodeIfPresent(Int64.self, forKey: .size)
        duration = try container.decodeIfPresent(Int.self, forKey: .duration)
    }
    
    private init(numberOfPage: Int?, size: Int64?, duration: Int?) {
        self.numberOfPage = numberOfPage
        self.size = size
        self.duration = duration
    }
    
    class Builder {
        private var numberOfPage: Int?
        private var size: Int64?
        private var duration: Int?
        
        func numberOfPage(_ numberOfPage: Int?) -> Builder {
            self.numberOfPage = numberOfPage
            return self
        }
        
        func size(_ size: Int64?) -> Builder {
            self.size = size
            return self
        }
        
        func duration(_ duration: Int?) -> Builder {
            self.duration = duration
            return self
        }
        
        func build() -> AttachmentMeta {
            return AttachmentMeta(numberOfPage: numberOfPage, size: size, duration: duration)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder()
            .numberOfPage(numberOfPage)
            .size(size)
            .duration(duration)
    }
}
