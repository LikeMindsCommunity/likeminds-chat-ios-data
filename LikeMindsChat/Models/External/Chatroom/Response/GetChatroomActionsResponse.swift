//
//  GetChatroomActionsResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation


struct GetChatroomActionsResponse: Decodable {
    var canAccessSecretChatroom: Bool
    var chatroomActions: [ChatroomAction]
    var participantCount: Int
    var placeHolder: String?
    
    enum CodingKeys: String, CodingKey {
        case canAccessSecretChatroom = "can_access_secret_chatroom"
        case chatroomActions = "chatroom_actions"
        case participantCount = "participant_count"
        case placeHolder = "placeholder"
    }
}

struct ChatroomAction: Decodable {
    var id: Int
    var title: String
    var route: String?
}
