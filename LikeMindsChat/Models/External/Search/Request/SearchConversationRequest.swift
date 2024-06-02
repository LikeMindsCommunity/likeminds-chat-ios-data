//
//  SearchConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 18/01/24.
//

import Foundation

public class SearchConversationRequest: Encodable {
    let search: String
    let followStatus: Bool
    let page: Int
    let pageSize: Int
    
    private init(search: String, followStatus: Bool, page: Int, pageSize: Int) {
        self.search = search
        self.followStatus = followStatus
        self.page = page
        self.pageSize = pageSize
    }
    
    private enum CodingKeys: String, CodingKey {
        case search
        case followStatus = "follow_status"
        case page
        case pageSize = "page_size"
    }
    
    public static func builder() -> Builder { Builder() }
    
    public class Builder {
        private var search: String = ""
        private var followStatus: Bool = false
        private var page: Int = 1
        private var pageSize: Int = 10
        
        public func search(_ search: String) -> Builder {
            self.search = search
            return self
        }
        
        public func followStatus(_ followStatus: Bool) -> Builder {
            self.followStatus = followStatus
            return self
        }
        
        public func page(_ page: Int) -> Builder {
            self.page = page
            return self
        }
        
        public func pageSize(_ pageSize: Int) -> Builder {
            self.pageSize = pageSize
            return self
        }
        
        public func build() -> SearchConversationRequest {
            return SearchConversationRequest(
                search: search,
                followStatus: followStatus,
                page: page,
                pageSize: pageSize
            )
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder()
            .search(search)
            .followStatus(followStatus)
            .page(page)
            .pageSize(pageSize)
    }
}
