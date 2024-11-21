//
//  GetConversationsResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public struct GetConversationsResponse: Decodable {
    public var conversations: [Conversation]?
    public var count: Int?
    public var widgets: [String: LMWidget]?
}
