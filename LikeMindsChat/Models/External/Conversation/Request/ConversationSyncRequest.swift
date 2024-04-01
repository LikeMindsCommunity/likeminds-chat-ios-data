//
//  GetConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 21/07/23.
//

import Foundation

public class ConversationSyncRequest: Encodable {
    var chatroomId: String?
    var page: Int = 1
    var pageSize: Int = 50
    var minTimestamp: Int?
    var maxTimestamp: Int?
    
    /// Initiate method
    private init() {}
    
    public static func builder() -> ConversationSyncRequest {
        return ConversationSyncRequest()
    }
    
    public func build() -> ConversationSyncRequest {
        return self
    }
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
        case minTimestamp = "min_timestamp"
        case maxTimestamp = "max_timestamp"
        case page
        case pageSize = "page_size"
    }
    
    public func chatroomId(_ chatroomId: String) -> ConversationSyncRequest {
        self.chatroomId = chatroomId
        return self
    }
    
    public func page(_ page: Int) -> ConversationSyncRequest {
        self.page = page
        return self
    }
    
    public func pageSize(_ pageSize: Int) -> ConversationSyncRequest {
        self.pageSize = pageSize
        return self
    }
    
    public func minTimestamp(_ minTimestamp: Int) -> ConversationSyncRequest {
        self.minTimestamp = minTimestamp
        return self
    }
    
    public func maxTimestamp(_ maxTimestamp: Int) -> ConversationSyncRequest {
        self.maxTimestamp = maxTimestamp
        return self
    }
}
