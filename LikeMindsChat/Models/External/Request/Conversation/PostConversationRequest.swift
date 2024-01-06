//
//  PostConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 21/07/23.
//

import Foundation

public class PostConversationRequest: Encodable {
    var chatroomID, text: String?
    var pollType: Int?
    var allowAddOption: Bool?
    var expiryTime: Int?
    var polls: [Poll]?
    var attachmentsCount, repliedConversationID: Int?
    var internalLink: String?

    /// Initiate method
    private init() {}
    
    public static func builder() -> PostConversationRequest {
        return PostConversationRequest()
    }
    
    public func build() -> PostConversationRequest {
        return self
    }
    
    enum CodingKeys: String, CodingKey {
        case chatroomID = "chatroom_id"
        case text
        case pollType = "poll_type"
        case allowAddOption = "allow_add_option"
        case expiryTime = "expiry_time"
        case polls
        case attachmentsCount = "attachments_count"
        case repliedConversationID = "replied_conversation_id"
        case internalLink = "internal_link"
    }
}


// MARK: - Poll
public class Poll: Encodable {
    var text: String?
    
    /// Initiate method
    public init() {}
    
    public static func builder() -> Poll {
        return Poll()
    }
    
    public func build() -> Poll {
        return self
    }
    
    public func text(_ text: String) -> Poll {
        self.text = text
        return self
    }
}
