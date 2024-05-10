//
//  FollowChatroomRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

public class FollowChatroomRequest: Encodable {
    let chatroomId: String
    let uuid: String
    let value: Bool
    
    private init(chatroomId: String, uuid: String, value: Bool) {
        self.chatroomId = chatroomId
        self.uuid = uuid
        self.value = value
    }
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
        case uuid, value
    }
    
    public static func builder() -> Builder {
        Builder()
    }
    
    public class Builder {
        private var chatroomId: String = ""
        private var uuid: String = ""
        private var value: Bool = false
        
        public func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func uuid(_ uuid: String) -> Builder {
            self.uuid = uuid
            return self
        }
        
        public func value(_ value: Bool) -> Builder {
            self.value = value
            return self
        }
        
        public func build() -> FollowChatroomRequest {
            return FollowChatroomRequest(chatroomId: chatroomId, uuid: uuid, value: value)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder().chatroomId(chatroomId)
            .uuid(uuid)
            .value(value)
    }
}
