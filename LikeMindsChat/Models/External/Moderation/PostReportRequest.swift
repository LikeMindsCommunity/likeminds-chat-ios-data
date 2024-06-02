//
//  PostReportRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 18/01/24.
//

import Foundation

public class PostReportRequest: Encodable {
    private var tagId: Int = -1
    private var reason: String? = nil
    private var uuid: String? = nil
    private var reportedConversationId: String? = nil
    private var reportedChatroomId: String? = nil
    private var reportedLink: String? = nil
    
    init(tagId: Int, reason: String? = nil, uuid: String? = nil, reportedConversationId: String? = nil, reportedChatroomId: String? = nil, reportedLink: String? = nil) {
        self.tagId = tagId
        self.reason = reason
        self.uuid = uuid
        self.reportedConversationId = reportedConversationId
        self.reportedChatroomId = reportedChatroomId
        self.reportedLink = reportedLink
    }
    
    private enum CodingKeys: String, CodingKey {
        case tagId = "tag_id"
        case reason
        case uuid
        case reportedConversationId = "conversation_id"
        case reportedChatroomId = "collabcard_id"
        case reportedLink = "link"
    }
    
    public static func builder(tagId: Int) -> Builder {
        return Builder(tagId: tagId)
    }
    
    public class Builder {
        
        private var tagId: Int = -1
        private var reason: String? = nil
        private var uuid: String? = nil
        private var reportedConversationId: String? = nil
        private var reportedChatroomId: String? = nil
        private var reportedLink: String? = nil
        
        init(tagId: Int) {
            self.tagId = tagId
        }
        
        public func reason(_ reason: String?) -> Builder {
            self.reason = reason
            return self
        }
        
        public func uuid(_ uuid: String?) -> Builder {
            self.uuid = uuid
            return self
        }
        
        public func reportedConversationId(_ reportedConversationId: String?) -> Builder {
            self.reportedConversationId = reportedConversationId
            return self
        }
        
        public func reportedChatroomId(_ reportedChatroomId: String?) -> Builder {
            self.reportedChatroomId = reportedChatroomId
            return self
        }
        
        public func reportedLink(_ reportedLink: String?) -> Builder {
            self.reportedLink = reportedLink
            return self
        }
        
        public func build() -> PostReportRequest {
            return PostReportRequest(tagId: self.tagId, reason: self.reason, uuid: self.uuid, reportedConversationId: self.reportedConversationId, reportedChatroomId: self.reportedChatroomId, reportedLink: self.reportedLink)
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder(tagId: tagId)
            .reason(reason)
            .uuid(uuid)
            .reportedChatroomId(reportedChatroomId)
            .reportedConversationId(reportedConversationId)
            .reportedLink(reportedLink)
    }
}

public enum ReportEntityType: String {
    case chatroom
    case message
    case member
}
