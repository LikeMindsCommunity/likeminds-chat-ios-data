//
//  SearchChatroomResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 19/01/24.
//

import Foundation

struct SearchChatroomResponse: Decodable {
    let conversations: [SearchChatroom]
    
    private enum CodingKeys: String, CodingKey {
        case conversations = "chatrooms"
    }
}

struct SearchChatroom: Decodable {
    
    let attachments: [_Attachment_]
    let attendingStatus: Bool
    let chatroom: _Chatroom_
    let community: _Community_
    let followStatus: Bool
    let id: Int
    let isGuest: Bool
    let isTagged: Bool
    let member: _Member_
    let muteStatus: Bool
    let secretChatroomLeft: Bool
    let state: Int
    let updatedAt: TimeInterval
    let isDisabled: Bool?
    
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
