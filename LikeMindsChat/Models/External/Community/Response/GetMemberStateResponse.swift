//
//  MemberStateResponse.swift
//  LMChat
//
//  Created by Pushpendra Singh on 26/02/23.
//

import Foundation

public enum MemberState:Int, Codable {
    case admin = 1
    case member = 4
}

// MARK: - MemberStateResponse
public struct GetMemberStateResponse: Codable {
    public let createdAt: String?
    public let editRequired: Bool?
    public let member: User?
    public let managerRights: [ManagerRight]?
    public let memberRights: [MemberRight]?
    public let state: Int?
    public let toolState: Int?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case editRequired = "edit_required"
        case member
        case memberRights = "member_rights"
        case managerRights = "manager_rights"
        case state
        case toolState = "tool_state"
    }
}
