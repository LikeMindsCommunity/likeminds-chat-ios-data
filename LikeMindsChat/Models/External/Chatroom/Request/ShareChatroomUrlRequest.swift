//
//  ShareChatroomUrlRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

public class ShareChatroomUrlRequest {
    private let chatroomId: String
    private let domain: String
    
    private init(chatroomId: String, domain: String) {
        self.chatroomId = chatroomId
        self.domain = domain
    }
    
    public static func builder() -> Builder {
        Builder()
    }
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
        case domain
    }
    
    public class Builder {
        private var chatroomId: String = ""
        private var domain: String = ""
        
        public func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func domain(_ domain: String) -> Builder {
            self.domain = domain
            return self
        }
        
        public func build() -> ShareChatroomUrlRequest {
            return ShareChatroomUrlRequest(chatroomId: chatroomId, domain: domain)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder().chatroomId(chatroomId).domain(domain)
    }
}
