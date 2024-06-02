//
//  MemberRight.swift
//  LMFeed
//
//  Created by Pushpendra Singh on 26/02/23.
//

import Foundation


public enum MemberRightState: Int, Codable, CaseIterableDefaultsLast {
    case unknown = -1
    case createChatRooms = 0
    case createPolls = 1
    case createEvents = 2
    case respondsInChatRoom = 3
    case inviteMemberFromPrivateLink = 4
    case autoApproveCreatedChatroom = 5
    case createSecretChatRoom = 6
    case directMessage = 7
    case noClearYet = 8
    case createPost = 9
    case commentOrReplyOnPost = 10
}

public enum ManagerRightState: Int, Codable, CaseIterableDefaultsLast {
    case unknown = -1
    case moderateChatRooms = 0
    case moderateMembers = 1
    case editCommunityDetails = 2
    case viewMemberContactInfo = 3
    case addCommunityManager = 4
    case moderateDMSetting = 5
    case moderateFeedAndComment = 6
}

// MARK: - MemberRight
public struct MemberRight: Codable {
    public let id: Int?
    public let isLocked, isSelected: Bool?
    public let state: MemberRightState?
    public let title: String?
    public let subTitle: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case isLocked = "is_locked"
        case isSelected = "is_selected"
        case state, title
        case subTitle = "sub_title"
    }
}

// MARK: - MemberRight
public struct ManagerRight: Codable {
    public let id: Int?
    public let isLocked, isSelected: Bool?
    public let state: ManagerRightState?
    public let title: String?
    public let subTitle: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case isLocked = "is_locked"
        case isSelected = "is_selected"
        case state, title
        case subTitle = "sub_title"
    }
}
