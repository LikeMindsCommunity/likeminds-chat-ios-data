//
//  DirectMessageRespone.swift
//  CollabMates
//
//  Created by Pushpendra Singh on 03/09/21.
//  Copyright © 2021 CollabMates. All rights reserved.
//

import Foundation

public struct HomeDirectMessageModel: Decodable {
    public let success: Bool
    public let clicked, messaged, hideDMTab, isCM: Bool?
    public let unreadDMCount: Int?
    public let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case success, clicked, messaged
        case isCM = "is_cm"
        case unreadDMCount = "unread_dm_count"
        case errorMessage = "error_message"
        case hideDMTab = "hide_dm_tab"
    }
}

public struct FeedDirectMessageModel: Decodable {
    public let success: Bool
    public let disclaimer: Disclaimer?
    public let errorMessage: String?
    public let totalCMCommunitiesCount: Int?
    public let totalMemberCommunitiesCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case success, disclaimer
        case errorMessage = "error_message"
        case totalCMCommunitiesCount = "total_cm_communities_count"
        case totalMemberCommunitiesCount = "total_member_communities_count"
    }
}

public struct Disclaimer: Codable {
    public let title, subtitle, cta: String?
}

public struct ShowDirectMessageModel: Decodable {
    public let success: Bool
    public let showDM: Bool?
    public let errorMessage, cta: String?
    
    enum CodingKeys: String, CodingKey {
        case success, cta
        case showDM = "show_dm"
        case errorMessage = "error_message"
    }
}
