//
//  _SyncConversationResponse_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 02/01/24.
//

import Foundation

struct _SyncConversationResponse_: Decodable {
    let chatRoomMeta: [_Chatroom_]?
    let communityMeta: [String: _Community_]?
    let conversationAttachmentsMeta: [String: [_Attachment_]]?
    let conversationPollMeta: [String: [_Poll_]]?
    let conversations: [_Conversation_]?
    let userMeta: [String: _Member_]?
    let chatroomReactionsMeta: [String: _ReactionMeta_]?
    let conversationReactionsMeta: [String: _ReactionMeta_]?
    
    enum CodingKeys: String, CodingKey {
        case chatRoomMeta = "chatrooms_meta",
             communityMeta = "community_meta",
             conversationAttachmentsMeta = "conv_attachments_meta",
             conversationPollMeta = "conv_polls_meta",
             conversations = "conversations_data",
             userMeta = "user_meta",
             chatroomReactionsMeta = "chatroom_reactions_meta",
             conversationReactionsMeta = "conv_reactions_meta"
    }
}
