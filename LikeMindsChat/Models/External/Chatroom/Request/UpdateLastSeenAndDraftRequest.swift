//
//  UpdateLastSeenAndDraftRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

class UpdateLastSeenAndDraftRequest {
    private let chatroomId: String
    private let draft: String?
    
    private init(chatroomId: String, draft: String?) {
        self.chatroomId = chatroomId
        self.draft = draft
    }
    
    class Builder {
        private var chatroomId: String = ""
        private var draft: String?
        
        func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func draft(_ draft: String?) -> Builder {
            self.draft = draft
            return self
        }
        
        func build() -> UpdateLastSeenAndDraftRequest {
            return UpdateLastSeenAndDraftRequest(chatroomId: chatroomId, draft: draft)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().chatroomId(chatroomId).draft(draft)
    }
}
