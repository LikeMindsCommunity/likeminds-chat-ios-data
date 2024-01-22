//
//  GetChatroomRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

class GetChatroomRequest: Encodable {
    private let chatroomId: String
    
    private init(chatroomId: String) {
        self.chatroomId = chatroomId
    }
    
    class Builder {
        private var chatroomId: String = ""
        
        func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func build() -> GetChatroomRequest {
            return GetChatroomRequest(chatroomId: chatroomId)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().chatroomId(chatroomId)
    }
}
