//
//  FollowChatroomRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

class FollowChatroomRequest {
    private let chatroomId: String
    private let uuid: String
    private let value: Bool
    
    private init(chatroomId: String, uuid: String, value: Bool) {
        self.chatroomId = chatroomId
        self.uuid = uuid
        self.value = value
    }
    
    class Builder {
        private var chatroomId: String = ""
        private var uuid: String = ""
        private var value: Bool = false
        
        func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func uuid(_ uuid: String) -> Builder {
            self.uuid = uuid
            return self
        }
        
        func value(_ value: Bool) -> Builder {
            self.value = value
            return self
        }
        
        func build() -> FollowChatroomRequest {
            return FollowChatroomRequest(chatroomId: chatroomId, uuid: uuid, value: value)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().chatroomId(chatroomId)
            .uuid(uuid)
            .value(value)
    }
}
