//
//  DecodeUrlRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 17/01/24.
//

import Foundation

class DecodeUrlRequest: Encodable {
    let url: String
    
    private init(url: String) {
        self.url = url
    }
    
    class Builder {
        private var url: String = ""
        
        func url(_ url: String) -> Builder {
            self.url = url
            return self
        }
        
        func build() -> DecodeUrlRequest {
            return DecodeUrlRequest(url: url)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().url(url)
    }
}
