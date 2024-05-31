//
//  MarkReadChatroomRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

public class MarkReadChatroomRequest: Encodable {
    private let chatroomId: String
    
    private init(chatroomId: String) {
        self.chatroomId = chatroomId
    }
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
    }
    
    public static func builder() -> Builder {
        Builder()
    }
    
    public class Builder {
        private var chatroomId: String = ""
        
        public func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func build() -> MarkReadChatroomRequest {
            return MarkReadChatroomRequest(chatroomId: chatroomId)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder().chatroomId(chatroomId)
    }
}
