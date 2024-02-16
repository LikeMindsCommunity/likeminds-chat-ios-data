//
//  GetExploreFeedResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 12/07/23.
//

import Foundation

public struct GetExploreFeedResponse: Decodable {
     var chatrooms: [Chatroom]
     var pinnedChatroomCount: Int
}
