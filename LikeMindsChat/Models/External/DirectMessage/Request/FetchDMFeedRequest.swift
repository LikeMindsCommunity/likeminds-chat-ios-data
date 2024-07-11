//
//  FetchDMFeedRequest.swift
//  CollabMates
//
//  Created by Pushpendra Singh on 07/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

public class FetchDMFeedRequest: Encodable {
    
    var page: Int = 1
    var pageSize: Int = 10
    var maxTimestamp: Int?
    var minTimestamp: Int?
    var chatroomTypes: [Int]?
    
    /// Initiate method
    private init() {}
    
    public static func builder() -> FetchDMFeedRequest {
        return FetchDMFeedRequest()
    }
    
    public func build() -> FetchDMFeedRequest {
        return self
    }
    
    enum CodingKeys: String, CodingKey {
        case page
        case pageSize = "page_size"
        case minTimestamp = "min_timestamp"
        case maxTimestamp = "max_timestamp"
        case chatroomTypes = "chatroom_types"
    }
    
    public func page(_ page: Int) -> FetchDMFeedRequest {
        self.page = page
        return self
    }
    
    public func pageSize(_ pageSize: Int) -> FetchDMFeedRequest {
        self.pageSize = pageSize
        return self
    }
    
    public func maxTimestamp(_ maxTimestamp: Int) -> FetchDMFeedRequest {
        self.maxTimestamp = maxTimestamp
        return self
    }
    
    public func minTimestamp(_ minTimestamp: Int) -> FetchDMFeedRequest {
        self.minTimestamp = minTimestamp
        return self
    }
    
    public func chatroomTypes(_ chatroomTypes: [Int]) -> FetchDMFeedRequest {
        self.chatroomTypes = chatroomTypes
        return self
    }
}
