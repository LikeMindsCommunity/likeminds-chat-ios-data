//
//  _SyncConversationResponse_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 02/01/24.
//

import Foundation

struct _SyncConversationResponse_: Decodable {
    let chatRoomMeta: [String: _Chatroom_]?
    let communityMeta: [String: Community]?
    let conversationAttachmentsMeta: [String: [Attachment]]?
    let conversationPollMeta: [String: [Poll]]?
    let conversations: [_Conversation_]?
    let userMeta: [String: Member]?
    let chatroomReactionsMeta: [String: ReactionMeta]?
    let conversationReactionsMeta: [String: ReactionMeta]?
    
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
