//
//  SearchConversationResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 19/01/24.
//

import Foundation

struct SearchConversationResponse: Decodable {
    let conversations: [SearchConversation]
}

struct SearchConversation: Decodable {
    let answer: String
    let attachmentCount: Int
    let attachments: [Attachment]
    let attachmentsUploaded: Bool
    let chatroom: _Chatroom_
    let community: Community
    let createdAt: TimeInterval
    let id: Int
    let isDeleted: Bool
    let isEdited: Bool
    let lastUpdated: TimeInterval
    let member: Member
    let state: Int
    
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        answer = try container.decode(String.self, forKey: .answer)
        attachmentCount = try container.decode(Int.self, forKey: .attachmentCount)
        attachments = try container.decode([Attachment].self, forKey: .attachments)
        attachmentsUploaded = try container.decode(Bool.self, forKey: .attachmentsUploaded)
        chatroom = try container.decode(_Chatroom_.self, forKey: .chatroom)
        community = try container.decode(Community.self, forKey: .community)
        createdAt = try container.decode(TimeInterval.self, forKey: .createdAt)
        id = try container.decode(Int.self, forKey: .id)
        isDeleted = try container.decode(Bool.self, forKey: .isDeleted)
        isEdited = try container.decode(Bool.self, forKey: .isEdited)
        lastUpdated = try container.decode(TimeInterval.self, forKey: .lastUpdated)
        member = try container.decode(Member.self, forKey: .member)
        state = try container.decode(Int.self, forKey: .state)
    }
}
