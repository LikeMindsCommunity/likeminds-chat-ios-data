//
//  LeaveSecretChatroomRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation


public class LeaveSecretChatroomRequest: Encodable {
    let chatroomId: String
    private let isSecret: Bool
    private let uuid: String
    
    private init(chatroomId: String, isSecret: Bool, uuid: String) {
        self.chatroomId = chatroomId
        self.isSecret = isSecret
        self.uuid = uuid
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
        private var uuid: String = ""
        
        public func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func uuid(_ uuid: String) -> Builder {
            self.uuid = uuid
            return self
        }
        
        public func isSecret(_ isSecret: Bool) -> Builder {
            self.isSecret = isSecret
            return self
        }
        
        public func build() -> LeaveSecretChatroomRequest {
            return LeaveSecretChatroomRequest(chatroomId: chatroomId, isSecret: isSecret, uuid: uuid)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder()
            .isSecret(isSecret)
            .chatroomId(chatroomId)
            .uuid(uuid)
    }
}
