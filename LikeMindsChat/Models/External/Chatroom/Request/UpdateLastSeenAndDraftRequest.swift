//
//  UpdateLastSeenAndDraftRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

public class UpdateLastSeenAndDraftRequest {
    private let chatroomId: String
    private let draft: String?
    
    private init(chatroomId: String, draft: String?) {
        self.chatroomId = chatroomId
        self.draft = draft
    }
    
    public static func builder() -> Builder {
        Builder()
    }
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
        case draft
    }
    
   public class Builder {
        private var chatroomId: String = ""
        private var draft: String?
        
        public func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func draft(_ draft: String?) -> Builder {
            self.draft = draft
            return self
        }
        
        public func build() -> UpdateLastSeenAndDraftRequest {
            return UpdateLastSeenAndDraftRequest(chatroomId: chatroomId, draft: draft)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder().chatroomId(chatroomId).draft(draft)
    }
}
