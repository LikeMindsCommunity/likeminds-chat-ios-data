//
//  SearchChatroomRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 18/01/24.
//

import Foundation

public class SearchChatroomRequest: Encodable {
    var search: String = ""
    var followStatus: Bool = false
    var page: Int = 1
    var pageSize: Int = 10
    var searchType: String = ""
    
    private init() {}
    
    private enum CodingKeys: String, CodingKey {
        case search
        case followStatus = "follow_status"
        case page
        case pageSize = "page_size"
        case searchType = "search_type"
    }
    
    public static func builder() -> Builder { Builder() }
    
    public class Builder {
        private var request: SearchChatroomRequest
        
        init() {
            request = SearchChatroomRequest()
        }
        
        public func search(_ search: String) -> Builder {
            request.search = search
            return self
        }
        
        public func followStatus(_ followStatus: Bool) -> Builder {
            request.followStatus = followStatus
            return self
        }
        
        public func page(_ page: Int) -> Builder {
            request.page = page
            return self
        }
        
        public func pageSize(_ pageSize: Int) -> Builder {
            request.pageSize = pageSize
            return self
        }
        
        public func searchType(_ searchType: String) -> Builder {
            request.searchType = searchType
            return self
        }
        
        public func build() -> SearchChatroomRequest {
            return request
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder()
            .search(search)
            .followStatus(followStatus)
            .page(page)
            .pageSize(pageSize)
            .searchType(searchType)
    }
}
