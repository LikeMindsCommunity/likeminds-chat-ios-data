//
//  UpdateConversationUploadWorkerUUIDRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class UpdateConversationUploadWorkerUUIDRequest {
    private let conversationId: String
    private let uuid: String
    
    private init(conversationId: String, uuid: String) {
        self.conversationId = conversationId
        self.uuid = uuid
    }
    
    class Builder {
        private var conversationId: String = ""
        private var uuid: String = ""
        
        func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        func uuid(_ uuid: String) -> Builder {
            self.uuid = uuid
            return self
        }
        
        func build() -> UpdateConversationUploadWorkerUUIDRequest {
            return UpdateConversationUploadWorkerUUIDRequest(conversationId: conversationId, uuid: uuid)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().uuid(uuid).conversationId(conversationId)
    }
}
