//
//  MuteChatroomRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

public class MuteChatroomRequest: Encodable {
    let chatroomId: String
    let value: Bool
    
    private init(chatroomId: String, value: Bool) {
        self.chatroomId = chatroomId
        self.value = value
    }
    
    public static func builder() -> Builder {
        Builder()
    }
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
        case value
    }
    
    public class Builder {
        private var chatroomId: String = ""
        private var value: Bool = false
        
        public func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func value(_ value: Bool) -> Builder {
            self.value = value
            return self
        }
        
        public func build() -> MuteChatroomRequest {
            return MuteChatroomRequest(chatroomId: chatroomId, value: value)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder().chatroomId(chatroomId).value(value)
    }
}
