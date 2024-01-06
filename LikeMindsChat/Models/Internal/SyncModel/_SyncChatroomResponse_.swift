//
//  ChatRoomSyncNetworkModel.swift
//  CollabMates
//
//  Created by Devansh Mohata on 20/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

struct _SyncChatroomResponse_: Decodable {
    let cardAttachmentMeta: [String: [_Attachment_]]?
    let chatRoomData: [_Chatroom_]?
    let communityMeta: [String: _Community_]?
    let conversationAttachementMeta: [String: [_ConversationAttachment_]]?
    let conversationPollMeta: [String: [_Poll_]]?
    let conversationMeta: [String: _Conversation_]?
    let userMeta: [String: _Member_]?
    
    enum CodingKeys: String, CodingKey {
        case chatRoomData = "chatrooms_data",
             communityMeta = "community_meta",
             conversationAttachementMeta = "conv_attachments_meta",
             conversationPollMeta = "conv_polls_meta",
             conversationMeta = "conversation_meta",
             cardAttachmentMeta = "card_attachments_meta",
             userMeta = "user_meta"
    }
}
