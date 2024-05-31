//
//  DecodeUrlRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 17/01/24.
//

import Foundation

public class DecodeUrlRequest: Encodable {
    let url: String
    
    private init(url: String) {
        self.url = url
    }
    public static func builder() -> Builder {
        return Builder()
    }
    public class Builder {
        private var url: String = ""
        
        public func url(_ url: String) -> Builder {
            self.url = url
            return self
        }
        
        public func build() -> DecodeUrlRequest {
            return DecodeUrlRequest(url: url)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder().url(url)
    }
}
