//
//  CommunityMetaNetworkModel.swift
//  CollabMates
//
//  Created by Devansh Mohata on 20/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

// MARK: Community
/// Represents a community in the CollabMates application.
///
/// The `Community` struct encapsulates metadata about a community including its identifier, image URL,
/// name, member count, purpose, subtype and type identifiers, last update time, auto-approval and DM tab
/// settings, as well as arrays of community settings and rights.
///
/// - Properties:
///    - id: The unique identifier of the community.
///    - imageURL: The URL string for the community's image.
///    - name: The name of the community.
///    - membersCount: The total number of members in the community.
///    - purpose: A description of the community's purpose.
///    - subType: An integer representing a subtype classification for the community.
///    - type: An integer representing the type of the community.
///    - updatedAt: A timestamp representing the last update time.
///    - autoApproval: A Boolean value indicating whether new members are automatically approved.
///    - hideDMTab: A Boolean value indicating whether the direct message tab is hidden.
///    - communitySettings: An array of settings applicable to the community.
///    - communitySettingRights: An array of rights associated with the community settings.
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

        case imageURL = "image_url"
        case
            subType = "sub_type"
        case
            membersCount = "members_count"
        case
            updatedAt = "updated_at"
        case
            communitySettings = "community_settings"
        case
            communitySettingRights = "community_setting_rights"
        case
            autoApproval = "auto_approval"
        case
            hideDMTab = "hide_dm_tab"
    }
}

// MARK: CommnitySetting
/// Represents a setting within a community.
///
/// The `CommunitySetting` struct defines a configurable option available within a community, such as post
/// approval, direct messaging settings, and chatroom configurations.
///
/// - Properties:
///    - title: The display title of the setting.
///    - type: A string representing the setting's type.
///    - subTitle: A subtitle or description for the setting.
///    - enabled: A Boolean indicating whether the setting is enabled.
///    - enabledBy: An integer identifier for the entity (or user) that enabled the setting.
///
/// Additionally, the nested `SettingType` enumeration defines the possible types of settings available.
public struct CommunitySetting: Decodable {

    /**
     The various types of community settings supported by the application.

     The raw values correspond to the string representations provided by the API.
     */
    public enum SettingType: String {
        case postApprovalNeeded = "post_approval_needed"
        case enableDMWithoutConnectionRequest =
            "enable_dm_without_connection_request"
        case directMessageSetting = "direct_messages_setting"
        case introRoom = "intro_room"
        case feed = "feed"
        case directMessageWithGroupMessage =
            "direct_messages_with_group_messages"
        case chatrooms = "chatrooms"
        case createIntroRooms = "create_intro_rooms"
        case secretGroupInvite = "secret_chatrooms_invite"
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

// MARK: CommunitySettingRight
/// Represents the rights associated with a particular community setting.
///
/// The `CommunitySettingRight` struct provides information about the access rights for a given community
/// setting, including whether the right is locked or selected, its current state, and descriptive texts.
///
/// - Properties:
///    - id: The unique identifier of the community setting right.
///    - isLocked: A Boolean indicating if the right is locked.
///    - isSelected: A Boolean indicating if the right is currently selected.
///    - state: An integer representing the state of the right.
///    - title: The title for the setting right.
///    - subTitle: A subtitle or additional description for the setting right.
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
