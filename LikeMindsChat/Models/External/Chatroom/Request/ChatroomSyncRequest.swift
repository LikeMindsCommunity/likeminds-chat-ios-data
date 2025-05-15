//
//  ChatroomSyncRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 01/01/24.
//

import Foundation

public class ChatroomSyncRequest: Encodable {
    
    var page: Int = 1
    var pageSize: Int = 10
    var maxTimestamp: Int = Int(Date().timeIntervalSince1970)
    var minTimestamp: Int = .zero
    var chatroomTypes: [Int] = []
    var isLocalDB: Bool = true
    
    /// Initiate method
    private init() {}
    
    public static func builder() -> ChatroomSyncRequest {
        return ChatroomSyncRequest()
    }
    
    public func build() -> ChatroomSyncRequest {
        return self
    }
    
    enum CodingKeys: String, CodingKey {
        case page
        case pageSize = "page_size"
        case minTimestamp = "min_timestamp"
        case maxTimestamp = "max_timestamp"
        case chatroomTypes = "chatroom_types"
        case isLocalDB = "is_local_db"
    }
    
    public func page(_ page: Int) -> ChatroomSyncRequest {
        self.page = page
        return self
    }
    
    public func pageSize(_ pageSize: Int) -> ChatroomSyncRequest {
        self.pageSize = pageSize
        return self
    }
    
    public func maxTimestamp(_ maxTimestamp: Int) -> ChatroomSyncRequest {
        self.maxTimestamp = maxTimestamp
        return self
    }
    
    public func minTimestamp(_ minTimestamp: Int) -> ChatroomSyncRequest {
        self.minTimestamp = minTimestamp
        return self
    }
    
    public func chatroomTypes(_ chatroomTypes: [Int]) -> ChatroomSyncRequest {
        self.chatroomTypes = chatroomTypes
        return self
    }
    
    public func isLocalDB(_ isLocalDB: Bool) -> ChatroomSyncRequest {
        self.isLocalDB = isLocalDB
        return self
    }
}
