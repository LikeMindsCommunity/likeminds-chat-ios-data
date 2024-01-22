//
//  LeaveSecretChatroomRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation


class LeaveSecretChatroomRequest: Encodable {
    private let chatroomId: String
    private let isSecret: Bool
    
    private init(chatroomId: String, isSecret: Bool) {
        self.chatroomId = chatroomId
        self.isSecret = isSecret
    }
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
        case isSecret = "is_secret"
    }
    
    class Builder {
        private var chatroomId: String = ""
        private var isSecret: Bool = true
        
        func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func isSecret(_ isSecret: Bool) -> Builder {
            self.isSecret = isSecret
            return self
        }
        
        func build() -> LeaveSecretChatroomRequest {
            return LeaveSecretChatroomRequest(chatroomId: chatroomId, isSecret: isSecret)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder()
            .isSecret(isSecret)
            .chatroomId(chatroomId)
    }
}
