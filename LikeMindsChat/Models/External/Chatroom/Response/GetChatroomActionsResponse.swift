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
}

struct ChatroomAction: Decodable {
    var id: Int
    var title: String
    var route: String?
}
