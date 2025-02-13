//
//  SearchChatroomResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 19/01/24.
//

import Foundation

/// Represents the response received after performing a search for chatrooms.
/// Contains a list of chatrooms that match the search criteria.
public struct SearchChatroomResponse: Decodable {

    // MARK: - Properties

    /// A list of chatrooms matching the search criteria.
    /// Each chatroom is represented by a `SearchChatroom` object.
    public let conversations: [SearchChatroom]

    // MARK: - Coding Keys

    /// Maps the `conversations` property to the `chatrooms` key in the JSON response.
    private enum CodingKeys: String, CodingKey {
        case conversations = "chatrooms"
    }
}

/// Represents an individual chatroom in the search results.
public struct SearchChatroom: Decodable {

    // MARK: - Properties

    /// A list of attachments associated with the chatroom.
    public let attachments: [Attachment]

    /// Indicates whether the user is attending the chatroom.
    public let attendingStatus: Bool

    /// The chatroom object containing detailed chatroom information.
    public let chatroom: _Chatroom_

    /// The community to which the chatroom belongs.
    public let community: Community

    /// Indicates whether the user is following the chatroom.
    public let followStatus: Bool

    /// The unique identifier of the chatroom.
    public let id: Int

    /// Indicates whether the user is a guest in the chatroom.
    public let isGuest: Bool

    /// Indicates whether the chatroom is tagged for the user.
    public let isTagged: Bool

    /// The member object representing the user in the chatroom.
    public let member: Member

    /// Indicates whether the chatroom is muted for the user.
    public let muteStatus: Bool

    /// Indicates whether the user has left a secret chatroom.
    public let secretChatroomLeft: Bool

    /// The state of the chatroom.
    /// Typically used to denote whether the chatroom is active, archived, or in another state.
    public let state: Int

    /// The timestamp (in seconds since the Unix epoch) when the chatroom was last updated.
    public let updatedAt: TimeInterval

    /// Indicates whether the chatroom is disabled.
    /// This value is optional and may be `nil` if the chatroom's disabled status is not known.
    public let isDisabled: Bool?

    // MARK: - Coding Keys

    /// Maps the properties to their respective keys in the JSON response.
    private enum CodingKeys: String, CodingKey {
        case attachments
        case attendingStatus = "attending_status"
        case chatroom
        case community
        case followStatus = "follow_status"
        case id
        case isGuest = "is_guest"
        case isTagged = "is_tagged"
        case member
        case muteStatus = "mute_status"
        case secretChatroomLeft = "secret_chatroom_left"
        case state
        case updatedAt = "updated_at"
        case isDisabled = "is_disabled"
    }
}
