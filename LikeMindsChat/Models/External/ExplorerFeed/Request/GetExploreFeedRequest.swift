//
//  GetExploreFeedRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 12/07/23.
//

import Foundation

public class GetExploreFeedRequest {
    private let orderType: Int
    private let isPinned: Bool?
    private let page: Int
    
    private init(orderType: Int, isPinned: Bool?, page: Int) {
        self.orderType = orderType
        self.isPinned = isPinned
        self.page = page
    }
    
    public class Builder {
        private var orderType: Int = -1
        private var isPinned: Bool? = nil
        private var page: Int = 1
        
        public func orderType(_ orderType: Int) -> Builder {
            self.orderType = orderType
            return self
        }
        
        public func isPinned(_ isPinned: Bool?) -> Builder {
            self.isPinned = isPinned
            return self
        }
        
        public func page(_ page: Int) -> Builder {
            self.page = page
            return self
        }
        
        public func build() -> GetExploreFeedRequest {
            return GetExploreFeedRequest(
                orderType: orderType,
                isPinned: isPinned,
                page: page
            )
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder()
            .orderType(orderType)
            .isPinned(isPinned)
            .page(page)
    }
}
