//
//  SearchConversationResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 19/01/24.
//

import Foundation

/// Represents the response received after performing a search for conversations.
/// Contains a list of conversations that match the search criteria.
public struct SearchConversationResponse: Decodable {

    // MARK: - Properties

    /// A list of conversations matching the search criteria.
    /// Each conversation is represented by a `SearchConversation` object.
    public let conversations: [SearchConversation]
}

/// Represents an individual conversation in the search results.
public struct SearchConversation: Decodable {

    // MARK: - Properties

    /// The main content or message of the conversation.
    public let answer: String

    /// The total number of attachments associated with the conversation.
    public let attachmentCount: Int

    /// A list of attachments associated with the conversation.
    public let attachments: [Attachment]

    /// Indicates whether all the attachments have been successfully uploaded.
    public let attachmentsUploaded: Bool

    /// The chatroom to which the conversation belongs.
    public let chatroom: _Chatroom_

    /// The community to which the conversation belongs.
    public let community: Community

    /// The timestamp (in seconds since the Unix epoch) when the conversation was created.
    public let createdAt: TimeInterval

    /// The unique identifier of the conversation.
    public let id: Int

    /// Indicates whether the conversation has been deleted.
    public let isDeleted: Bool

    /// Indicates whether the conversation has been edited.
    public let isEdited: Bool

    /// The timestamp (in seconds since the Unix epoch) when the conversation was last updated.
    public let lastUpdated: TimeInterval

    /// The member who created or owns the conversation.
    public let member: Member

    /// The state of the conversation.
    /// Typically used to denote whether the conversation is active, archived, or in another state.
    public let state: Int

    // MARK: - Coding Keys

    /// Maps the properties to their respective keys in the JSON response.
    private enum CodingKeys: String, CodingKey {
        case answer
        case attachmentCount = "attachment_count"
        case attachments
        case attachmentsUploaded = "attachments_uploaded"
        case chatroom
        case community
        case createdAt = "created_at"
        case id
        case isDeleted = "is_deleted"
        case isEdited = "is_edited"
        case lastUpdated = "last_updated"
        case member
        case state
    }

    // MARK: - Initializer

    /// Initializes a `SearchConversation` object by decoding its properties from a JSON decoder.
    ///
    /// - Parameter decoder: The `Decoder` instance to decode data from.
    /// - Throws: An error if any of the required properties cannot be decoded.
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        answer = try container.decode(String.self, forKey: .answer)
        attachmentCount = try container.decode(
            Int.self, forKey: .attachmentCount)
        attachments = try container.decode(
            [Attachment].self, forKey: .attachments)
        attachmentsUploaded = try container.decode(
            Bool.self, forKey: .attachmentsUploaded)
        chatroom = try container.decode(_Chatroom_.self, forKey: .chatroom)
        community = try container.decode(Community.self, forKey: .community)
        createdAt = try container.decode(TimeInterval.self, forKey: .createdAt)
        id = try container.decode(Int.self, forKey: .id)
        isDeleted = try container.decode(Bool.self, forKey: .isDeleted)
        isEdited = try container.decode(Bool.self, forKey: .isEdited)
        lastUpdated = try container.decode(
            TimeInterval.self, forKey: .lastUpdated)
        member = try container.decode(Member.self, forKey: .member)
        state = try container.decode(Int.self, forKey: .state)
    }
}
