//
//  EditChatroomTitleRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

public class EditChatroomTitleRequest: Encodable {
    private let chatroomId: String
    private let text: String
    
    private init(chatroomId: String, text: String) {
        self.chatroomId = chatroomId
        self.text = text
    }
    
    public static func builder() -> Builder {
        Builder()
    }
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
        case text
    }
    
    public class Builder {
        private var chatroomId: String = ""
        private var text: String = ""
        
        public func chatroomId(chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func text(text: String) -> Builder {
            self.text = text
            return self
        }
        
        public func build() -> EditChatroomTitleRequest {
            return EditChatroomTitleRequest(chatroomId: chatroomId, text: text)
        }
    }
}
