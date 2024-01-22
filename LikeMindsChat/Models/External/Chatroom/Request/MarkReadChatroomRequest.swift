//
//  MarkReadChatroomRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

class MarkReadChatroomRequest: Encodable {
    private let chatroomId: String
    
    private init(chatroomId: String) {
        self.chatroomId = chatroomId
    }
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
    }
    
    class Builder {
        private var chatroomId: String = ""
        
        func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func build() -> MarkReadChatroomRequest {
            return MarkReadChatroomRequest(chatroomId: chatroomId)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().chatroomId(chatroomId)
    }
}
