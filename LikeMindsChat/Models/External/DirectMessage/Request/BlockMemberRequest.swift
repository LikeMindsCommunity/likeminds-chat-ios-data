//
//  BlockMemberRequest.swift
//  CollabMates
//
//  Created by Pushpendra Singh on 10/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

public class BlockMemberRequest: Encodable {
    
    public enum BlockState: Int {
        case block = 0
        case unblock = 1
    }
    
    var status: Int?
    var chatroomId: String?
    
    /// Initiate method
    private init() {}
    
    public static func builder() -> BlockMemberRequest {
        return BlockMemberRequest()
    }
    
    public func build() -> BlockMemberRequest {
        return self
    }
    
    enum CodingKeys: String, CodingKey {
        case status,
             chatroomId = "chatroom_id"
    }
    
    public func status(_ status: BlockState) -> BlockMemberRequest {
        self.status = status.rawValue
        return self
    }
    
    public func chatroomId(_ chatroomId: String) -> BlockMemberRequest {
        self.chatroomId = chatroomId
        return self
    }
}
