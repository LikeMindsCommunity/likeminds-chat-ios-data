//
//  GetExploreFeedResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 12/07/23.
//

import Foundation

public struct GetExploreFeedResponse: Decodable {
    var chatrooms: [_Chatroom_]?
    public var pinnedChatroomCount: Int?
    public var exploreChatrooms: [Chatroom] {
        return (chatrooms ?? []).compactMap({ chatroom in
            return ModelConverter.shared.convertChatroom(chatroom: chatroom)
        })
    }
}
