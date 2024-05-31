//
//  GetHomeFeedRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 12/07/23.
//

import Foundation

public class GetHomeFeedRequest: Encodable {
    var page: Int = 1
    var pageSize: Int = 10
    var minTimestamp: Int?
    var maxTimestamp: Int?
    
    /// Initiate method
    private init() {}
    
    public static func builder() -> GetHomeFeedRequest {
        return GetHomeFeedRequest()
    }
    
    public func build() -> GetHomeFeedRequest {
        return self
    }
    
    enum CodingKeys: String, CodingKey {
        case minTimestamp = "min_timestamp"
        case maxTimestamp = "max_timestamp"
        case page
        case pageSize = "page_size"
    }
    
    public func page(_ page: Int) -> GetHomeFeedRequest {
        self.page = page
        return self
    }
    
    public func pageSize(_ pageSize: Int) -> GetHomeFeedRequest {
        self.pageSize = pageSize
        return self
    }
    
    public func minTimestamp(_ minTimestamp: Int) -> GetHomeFeedRequest {
        self.minTimestamp = minTimestamp
        return self
    }
    
    public func maxTimestamp(_ maxTimestamp: Int) -> GetHomeFeedRequest {
        self.maxTimestamp = maxTimestamp
        return self
    }
}

