//
//  CheckDMStatusRequest.swift
//  CollabMates
//
//  Created by Pushpendra Singh on 07/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

public enum DMStatusRequestFrom: String {
    case dmFeed = "dm_feed_v2"
    case chatroom = "chatroom"
    case groupChannel = "group_channel"
    case memberProfile = "member_profile"
}

public class CheckDMStatusRequest: Encodable {
    
    var requestFrom: String?
    var uuid: String?
    var chatroomId: Int?
    
    /// Initiate method
    private init() {}
    
    public static func builder() -> CheckDMStatusRequest {
        return CheckDMStatusRequest()
    }
    
    public func build() -> CheckDMStatusRequest {
        return self
    }
    
    enum CodingKeys: String, CodingKey {
        case requestFrom = "req_from",
             uuid,
             chatroomId = "chatroom_id"
    }
    
    public func requestFrom(_ requestFrom: String) -> CheckDMStatusRequest {
        self.requestFrom = requestFrom
        return self
    }
    
    public func uuid(_ uuid: String) -> CheckDMStatusRequest {
        self.uuid = uuid
        return self
    }
    
    public func chatroomId(_ chatroomId: Int) -> CheckDMStatusRequest {
        self.chatroomId = chatroomId
        return self
    }
}
