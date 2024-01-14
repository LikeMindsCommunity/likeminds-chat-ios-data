//
//  GetMemberRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class GetMemberRequest {
    private let uuid: String
    
    private init(uuid: String) {
        self.uuid = uuid
    }
    
    class Builder {
        private var uuid: String = ""
        
        func uuid(_ uuid: String) -> Builder {
            self.uuid = uuid
            return self
        }
        
        func build() -> GetMemberRequest {
            return GetMemberRequest(uuid: uuid)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().uuid(uuid)
    }
}
