//
//  DeleteConversationsResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public struct DeleteConversationsResponse: Decodable {
    public var conversations: [Conversation]
}
