//
//  SearchChatroomRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 18/01/24.
//

import Foundation

class SearchChatroomRequest: Encodable {
    private var search: String = ""
    private var followStatus: Bool = false
    private var page: Int = 1
    private var pageSize: Int = 10
    private var searchType: String = ""
    
    private init() {}
    
    private enum CodingKeys: String, CodingKey {
        case search
        case followStatus = "follow_status"
        case page
        case pageSize = "page_size"
        case searchType = "search_type"
    }
    
    class Builder {
        private var request: SearchChatroomRequest
        
        init() {
            request = SearchChatroomRequest()
        }
        
        func setSearch(_ search: String) -> Builder {
            request.search = search
            return self
        }
        
        func setFollowStatus(_ followStatus: Bool) -> Builder {
            request.followStatus = followStatus
            return self
        }
        
        func setPage(_ page: Int) -> Builder {
            request.page = page
            return self
        }
        
        func setPageSize(_ pageSize: Int) -> Builder {
            request.pageSize = pageSize
            return self
        }
        
        func setSearchType(_ searchType: String) -> Builder {
            request.searchType = searchType
            return self
        }
        
        func build() -> SearchChatroomRequest {
            return request
        }
    }
    
    func toBuilder() -> Builder {
        return Builder()
            .setSearch(search)
            .setFollowStatus(followStatus)
            .setPage(page)
            .setPageSize(pageSize)
            .setSearchType(searchType)
    }
}
