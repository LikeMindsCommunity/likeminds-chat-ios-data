//
//  CommunityMetaNetworkModel.swift
//  CollabMates
//
//  Created by Devansh Mohata on 20/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

public struct Community: Decodable {
    public let id: Int?
    public let imageURL: String?
    public let name: String?
    public let membersCount: Int?
    public let purpose: String?
    public let subType: Int?
    public let type: Int?
    public let updatedAt: Int?
    public let autoApproval: Bool?
    public let hideDMTab: Bool?
    public let communitySettings: [CommunitySetting]?
    public let communitySettingRights: [CommunitySettingRight]?
    
    enum CodingKeys: String, CodingKey {
        case id,
             type,
             name,
             purpose
        
        case imageURL = "image_url",
             subType = "sub_type",
             membersCount = "members_count",
             updatedAt = "updated_at",
             communitySettings = "community_settings",
             communitySettingRights = "community_setting_rights",
             autoApproval = "auto_approval",
             hideDMTab = "hide_dm_tab"
        
    }
}

public struct CommunitySetting: Decodable {
    
    public enum SettingType: String {
        case postApprovalNeeded = "post_approval_needed"
        case enableDMWithoutConnectionRequest = "enable_dm_without_connection_request"
        case directMessageSetting = "direct_messages_setting"
        case introRoom = "intro_room"
        case feed = "feed"
        case directMessageWithGroupMessage = "direct_messages_with_group_messages"
        case chatrooms = "chatrooms"
        case createIntroRooms = "create_intro_rooms"
        case secretGroupInvite = "secret_groups_invite"
        case postGroups = "post_groups"
    }
    
    public let title: String?
    public let type: String?
    public let subTitle: String?
    public let enabled: Bool?
    public let enabledBy: Int?
    
    enum CodingKeys: String, CodingKey {
        case title = "setting_title"
        case subTitle = "setting_sub_title"
        case enabled
        case type = "setting_type"
        case enabledBy = "enabled_by"
    }
}

public struct CommunitySettingRight: Decodable {
    
    public let id: Int?
    public let isLocked, isSelected: Bool?
    public let state: Int?
    public let title, subTitle: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case isLocked = "is_locked"
        case isSelected = "is_selected"
        case state, title
        case subTitle = "sub_title"
    }
}
