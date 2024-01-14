//
//  ShareChatroomUrlRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

class ShareChatroomUrlRequest {
    private let chatroomId: String
    private let domain: String
    
    private init(chatroomId: String, domain: String) {
        self.chatroomId = chatroomId
        self.domain = domain
    }
    
    class Builder {
        private var chatroomId: String = ""
        private var domain: String = ""
        
        func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func domain(_ domain: String) -> Builder {
            self.domain = domain
            return self
        }
        
        func build() -> ShareChatroomUrlRequest {
            return ShareChatroomUrlRequest(chatroomId: chatroomId, domain: domain)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().chatroomId(chatroomId).domain(domain)
    }
}
