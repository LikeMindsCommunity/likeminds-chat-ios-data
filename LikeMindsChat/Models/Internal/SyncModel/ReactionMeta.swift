//
//  _ReactionMeta_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 02/01/24.
//

import Foundation

struct ReactionMeta: Decodable {
    
     var id: Int?
     var reaction: String?
     var chatroomId: Int?
     var conversationId: Int?
     var userId: Int?
     var member: Member?
    
    enum CodingKeys: String, CodingKey {
        case id, reaction, member
        case chatroomId = "chatroom_id",
             conversationId = "conversation_id",
             userId = "user_id"       
    }
}
