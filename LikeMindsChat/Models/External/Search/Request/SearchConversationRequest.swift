//
//  SearchConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 18/01/24.
//

import Foundation

class SearchConversationRequest: Encodable {
    private let search: String
    private let followStatus: Bool
    private let page: Int
    private let pageSize: Int
    
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
    
    class Builder {
        private var search: String = ""
        private var followStatus: Bool = false
        private var page: Int = 1
        private var pageSize: Int = 10
        
        func search(_ search: String) -> Builder {
            self.search = search
            return self
        }
        
        func followStatus(_ followStatus: Bool) -> Builder {
            self.followStatus = followStatus
            return self
        }
        
        func page(_ page: Int) -> Builder {
            self.page = page
            return self
        }
        
        func pageSize(_ pageSize: Int) -> Builder {
            self.pageSize = pageSize
            return self
        }
        
        func build() -> SearchConversationRequest {
            return SearchConversationRequest(
                search: search,
                followStatus: followStatus,
                page: page,
                pageSize: pageSize
            )
        }
    }
    
    func toBuilder() -> Builder {
        return Builder()
            .search(search)
            .followStatus(followStatus)
            .page(page)
            .pageSize(pageSize)
    }
}
