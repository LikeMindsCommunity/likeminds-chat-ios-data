//
//  PostReportRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 18/01/24.
//

import Foundation

class PostReportRequest: Encodable {
    private var tagId: Int = -1
    private var reason: String? = nil
    private var uuid: String? = nil
    private var reportedConversationId: String? = nil
    private var reportedChatroomId: String? = nil
    private var reportedLink: String? = nil
    
    private enum CodingKeys: String, CodingKey {
        case tagId = "tag_id"
        case reason
        case uuid
        case reportedConversationId = "conversation_id"
        case reportedChatroomId = "collabcard_id"
        case reportedLink = "link"
    }
    
    class Builder {
        
        private var tagId: Int = -1
        private var reason: String? = nil
        private var uuid: String? = nil
        private var reportedConversationId: String? = nil
        private var reportedChatroomId: String? = nil
        private var reportedLink: String? = nil
        
        init(tagId: Int) {
            self.tagId = tagId
        }
        
        func reason(_ reason: String?) -> Self {
            self.reason = reason
            return self
        }
        
        func uuid(_ uuid: String?) -> Self {
            self.uuid = uuid
            return self
        }
        
        func reportedConversationId(_ reportedConversationId: String?) -> Self {
            self.reportedConversationId = reportedConversationId
            return self
        }
        
        func reportedChatroomId(_ reportedChatroomId: String?) -> Self {
            self.reportedChatroomId = reportedChatroomId
            return self
        }
        
        func reportedLink(_ reportedLink: String?) -> Self {
            self.reportedLink = reportedLink
            return self
        }
        
        func build() -> PostReportRequest {
            return PostReportRequest(
        }
    }
    
    func toBuilder() -> Builder {
        return Builder(tagId: tagId)
    }
}
