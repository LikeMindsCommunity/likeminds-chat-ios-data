//
//  GetChatroomRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

public class GetChatroomRequest: Encodable {
    public let chatroomId: String
    
    private init(chatroomId: String) {
        self.chatroomId = chatroomId
    }
    
    public class Builder {
        private var chatroomId: String = ""
        
        public init() {}
        
        public func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func build() -> GetChatroomRequest {
            return GetChatroomRequest(chatroomId: chatroomId)
        }
    }
    
    public  func toBuilder() -> Builder {
        return Builder().chatroomId(chatroomId)
    }
}
