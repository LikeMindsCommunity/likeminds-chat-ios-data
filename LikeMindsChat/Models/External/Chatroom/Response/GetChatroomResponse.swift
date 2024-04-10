//
//  GetChatroomResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

public struct GetChatroomResponse: Decodable {
    public var chatroom: Chatroom?
    enum CodingKeys: CodingKey {
        case chatroom
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.chatroom = try container.decodeIfPresent(Chatroom.self, forKey: .chatroom)
    }
    
    init(chatroom: Chatroom? = nil) {
        self.chatroom = chatroom
    }
}
