//
//  SendDMRequest.swift
//  CollabMates
//
//  Created by Pushpendra Singh on 10/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

public class SendDMRequest: Encodable {
    
    var chatRequestState: Int?
    var text: String?
    var chatroomId: String?
    
    /// Initiate method
    private init() {}
    
    public static func builder() -> SendDMRequest {
        return SendDMRequest()
    }
    
    public func build() -> SendDMRequest {
        return self
    }
    
    enum CodingKeys: String, CodingKey {
        case chatRequestState = "chat_request_state",
             text,
             chatroomId = "chatroom_id"
    }
    
    public func chatRequestState(_ chatRequestState: Int) -> SendDMRequest {
        self.chatRequestState = chatRequestState
        return self
    }
    
    public func text(_ text: String?) -> SendDMRequest {
        self.text = text
        return self
    }
    
    public func chatroomId(_ chatroomId: String) -> SendDMRequest {
        self.chatroomId = chatroomId
        return self
    }
}
