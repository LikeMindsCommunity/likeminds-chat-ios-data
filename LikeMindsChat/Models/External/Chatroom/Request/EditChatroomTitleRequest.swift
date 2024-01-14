//
//  EditChatroomTitleRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

class EditChatroomTitleRequest {
    private let chatroomId: String
    private let text: String
    
    private init(chatroomId: String, text: String) {
        self.chatroomId = chatroomId
        self.text = text
    }
    
    class Builder {
        private var chatroomId: String = ""
        private var text: String = ""
        
        func chatroomId(chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func text(text: String) -> Builder {
            self.text = text
            return self
        }
        
        func build() -> EditChatroomTitleRequest {
            return EditChatroomTitleRequest(chatroomId: chatroomId, text: text)
        }
    }
}
