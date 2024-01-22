//
//  GetChatroomActionsRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

class GetChatroomActionsRequest: Encodable {
    let chatroomId: String
    
    private init(chatroomId: String) {
        self.chatroomId = chatroomId
    }
    
    class Builder {
        private var chatroomId: String = ""
        
        func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func build() -> GetChatroomActionsRequest {
            return GetChatroomActionsRequest(chatroomId: chatroomId)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().chatroomId(chatroomId)
    }
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
    }
}
