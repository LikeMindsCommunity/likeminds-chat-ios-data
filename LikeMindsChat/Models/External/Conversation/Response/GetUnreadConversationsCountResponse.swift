//
//  GetUnreadConversationsCountResponse.swift
//  LikeMindsChat
//
//  Created by Arpit Verma on 18/06/25.
//

import Foundation

/// Response model containing counts of unread conversations for different chatroom types
public struct GetUnreadConversationsCountResponse: Decodable {
    
    // MARK: - Properties
    
    /// Number of unread conversations in group chatrooms
    public let unreadGroupChatroomConversations: Int
    
    /// Number of unread conversations in direct message chatrooms
    public let unreadDMChatroomConversations: Int
    
    enum CodingKeys: String, CodingKey {
        case unreadGroupChatroomConversations = "unread_group_chatroom_conversations"
        case unreadDMChatroomConversations = "unread_dm_chatroom_conversations"
    }
} 