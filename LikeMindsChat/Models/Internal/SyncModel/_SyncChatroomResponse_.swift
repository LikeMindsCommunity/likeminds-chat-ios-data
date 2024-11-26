//
//  ChatRoomSyncNetworkModel.swift
//  CollabMates
//
//  Created by Devansh Mohata on 20/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

struct _SyncChatroomResponse_: Decodable {
    let cardAttachmentMeta: [String: [Attachment]]?
    let chatrooms: [_Chatroom_]?
    let communityMeta: [String: Community]?
    let conversationAttachementMeta: [String: [Attachment]]?
    let conversationPollMeta: [String: [Poll]]?
    let conversationMeta: [String: _Conversation_]?
    let userMeta: [String: Member]?
    let widgets: [String: Widget]?
    
    enum CodingKeys: String, CodingKey {
        case chatrooms = "chatrooms_data",
             communityMeta = "community_meta",
             conversationAttachementMeta = "conv_attachments_meta",
             conversationPollMeta = "conv_polls_meta",
             conversationMeta = "conversation_meta",
             cardAttachmentMeta = "card_attachments_meta",
             userMeta = "user_meta",
             widgets
    }
}
