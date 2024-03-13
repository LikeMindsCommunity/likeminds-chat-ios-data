//
//  GetReportTagsRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 18/01/24.
//

import Foundation

public class GetReportTagsRequest {
    
    var type: Int = 0
    
    init(type: Int) {
        self.type = type
    }
    
    public static func builder() -> Builder {
        return Builder()
    }
    
    public class Builder {
        private var type: Int = 0
        
        public func type(_ type: Int) -> Builder {
            self.type = type
            return self
        }
        
        public func build() -> GetReportTagsRequest {
            return GetReportTagsRequest(type: type)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder().type(type)
    }
}
