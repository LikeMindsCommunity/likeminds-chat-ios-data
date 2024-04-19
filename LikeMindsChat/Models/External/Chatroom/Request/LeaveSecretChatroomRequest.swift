//
//  LeaveSecretChatroomRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation


public class LeaveSecretChatroomRequest: Encodable {
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
    
    public static func builder() -> Builder {
        Builder()
    }
    
    public class Builder {
        private var chatroomId: String = ""
        private var isSecret: Bool = true
        
        public func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func isSecret(_ isSecret: Bool) -> Builder {
            self.isSecret = isSecret
            return self
        }
        
        public func build() -> LeaveSecretChatroomRequest {
            return LeaveSecretChatroomRequest(chatroomId: chatroomId, isSecret: isSecret)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder()
            .isSecret(isSecret)
            .chatroomId(chatroomId)
    }
}
