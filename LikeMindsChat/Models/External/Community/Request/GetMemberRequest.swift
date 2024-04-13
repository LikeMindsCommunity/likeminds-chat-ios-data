//
//  GetMemberRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public class GetMemberRequest {
    let uuid: String
    
    private init(uuid: String) {
        self.uuid = uuid
    }
    public static func builder() -> Builder {
        return Builder()
    }
    public  class Builder {
        private var uuid: String = ""
        
        public func uuid(_ uuid: String) -> Builder {
            self.uuid = uuid
            return self
        }
        
        public func build() -> GetMemberRequest {
            return GetMemberRequest(uuid: uuid)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder().uuid(uuid)
    }
}
