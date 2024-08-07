//
//  GetAllMembersRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 01/09/23.
//

import Foundation

public class GetAllMembersRequest: Encodable {
    
    public enum MemberTypes: CustomStringConvertible {
        case admin,
             member
        public var description: String {
            switch self {
            case .admin:
                return "admin"
            case .member:
                return "member"
            }
        }
    }
    
    var page: Int = 1
    var pageSize: Int = 10
    var memberState: Int?
    var filterMemberRoles: [String] = []
    var excludeSelfUser: Bool?
    
    /// Initiate method
    private init() {}
    
    public static func builder() -> GetAllMembersRequest {
        return GetAllMembersRequest()
    }
    
    public func build() -> GetAllMembersRequest {
        return self
    }
    
    enum CodingKeys: String, CodingKey {
        case page
        case pageSize = "page_size"
        case memberState = "member_state"
    }
    
    public func page(_ page: Int) -> GetAllMembersRequest {
        self.page = page
        return self
    }
    
    public func pageSize(_ pageSize: Int) -> GetAllMembersRequest {
        self.pageSize = pageSize
        return self
    }
    
    public func memberState(_ memberState: Int?) -> GetAllMembersRequest {
        self.memberState = memberState
        return self
    }
    
    public func filterMemberRoles(_ memberRoles: [MemberTypes]) -> GetAllMembersRequest {
        self.filterMemberRoles = memberRoles.map { $0.description }
        return self
    }
    
    public func excludeSelfUser(_ excludeSelfUser: Bool) -> GetAllMembersRequest {
        self.excludeSelfUser = excludeSelfUser
        return self
    }
}
