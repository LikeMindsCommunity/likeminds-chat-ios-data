//
//  UpdateTemporaryConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class UpdateTemporaryConversationRequest {
    private let conversationId: String
    private let localSavedEpoch: Int64
    
    private init(conversationId: String, localSavedEpoch: Int64) {
        self.conversationId = conversationId
        self.localSavedEpoch = localSavedEpoch
    }
    
    class Builder {
        private var conversationId: String = ""
        private var localSavedEpoch: Int64 = -1
        
        func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        func localSavedEpoch(_ localSavedEpoch: Int64) -> Builder {
            self.localSavedEpoch = localSavedEpoch
            return self
        }
        
        func build() -> UpdateTemporaryConversationRequest {
            return UpdateTemporaryConversationRequest(conversationId: conversationId, localSavedEpoch: localSavedEpoch)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder().conversationId(conversationId).localSavedEpoch(localSavedEpoch)
    }
}
