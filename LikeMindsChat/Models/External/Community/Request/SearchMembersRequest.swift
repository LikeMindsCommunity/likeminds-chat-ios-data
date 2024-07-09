//
//  SearchMembersRequest.swift
//  LikeMindsFeed
//
//  Created by Pushpendra Singh on 01/09/23.
//

import Foundation

public class SearchMembersRequest: Encodable {
    
    var page: Int = 1
    var pageSize: Int = 10
    var search: String?
    var searchType: String?
    var memberState: [Int]?
    var excludeSelfUser: Bool?
    
    /// Initiate method
    private init() {}
    
    public static func builder() -> SearchMembersRequest {
        return SearchMembersRequest()
    }
    
    public func build() -> SearchMembersRequest {
        return self
    }
    
    enum CodingKeys: String, CodingKey {
        case page, search
        case pageSize = "page_size"
        case searchType = "search_type"
        case memberState = "member_state"
    }
    
    public func page(_ page: Int) -> SearchMembersRequest {
        self.page = page
        return self
    }
    
    public func pageSize(_ pageSize: Int) -> SearchMembersRequest {
        self.pageSize = pageSize
        return self
    }
    
    public func search(_ search: String) -> SearchMembersRequest {
        self.search = search
        return self
    }
    
    public func searchType(_ searchType: String) -> SearchMembersRequest {
        self.searchType = searchType
        return self
    }
    
    public func memberState(_ memberState: [Int]?) -> SearchMembersRequest {
        self.memberState = memberState
        return self
    }
    
    public func excludeSelfUser(_ excludeSelfUser: Bool) -> SearchMembersRequest {
        self.excludeSelfUser = excludeSelfUser
        return self
    }
}
