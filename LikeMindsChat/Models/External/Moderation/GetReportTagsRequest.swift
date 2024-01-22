//
//  GetReportTagsRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 18/01/24.
//

import Foundation

class GetReportTagsRequest {
    private var type: Int = 0
    
    init(type: Int) {
        self.type = type
    }
    
    class Builder {
        private var type: Int = 0
        
        func type(type: Int) -> Builder {
            self.type = type
            return self
        }
        
        func build() -> GetReportTagsRequest {
            return GetReportTagsRequest(type: type)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().type(type: type)
    }
}
