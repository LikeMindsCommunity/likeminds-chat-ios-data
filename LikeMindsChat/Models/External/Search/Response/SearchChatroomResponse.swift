//
//  SearchChatroomResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 19/01/24.
//

import Foundation

public struct SearchChatroomResponse: Decodable {
    public let conversations: [SearchChatroom]
    
    private enum CodingKeys: String, CodingKey {
        case conversations = "chatrooms"
    }
}

public struct SearchChatroom: Decodable {
    
    public let attachments: [Attachment]
    public let attendingStatus: Bool
    let chatroom: _Chatroom_
    public let community: Community
    public let followStatus: Bool
    public let id: Int
    public let isGuest: Bool
    public let isTagged: Bool
    public let member: Member
    public let muteStatus: Bool
    public let secretChatroomLeft: Bool
    public let state: Int
    public let updatedAt: TimeInterval
    public let isDisabled: Bool?
    
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
