//
//  MuteChatroomRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

class MuteChatroomRequest: Encodable {
    private let chatroomId: String
    private let value: Bool
    
    private init(chatroomId: String, value: Bool) {
        self.chatroomId = chatroomId
        self.value = value
    }
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
        case value
    }
    
    class Builder {
        private var chatroomId: String = ""
        private var value: Bool = false
        
        func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func value(_ value: Bool) -> Builder {
            self.value = value
            return self
        }
        
        func build() -> MuteChatroomRequest {
            return MuteChatroomRequest(chatroomId: chatroomId, value: value)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().chatroomId(chatroomId).value(value)
    }
}
