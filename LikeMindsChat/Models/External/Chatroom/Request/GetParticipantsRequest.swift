//
//  GetParticipantsRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

public class GetParticipantsRequest: Encodable {
    var isChatroomSecret: Bool = false
    var chatroomId: String = ""
    var participantName: String? = nil
    var page: Int = 1
    var pageSize: Int = 20
    
    private init() {}
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
        case isChatroomSecret = "is_chatroom_secret"
        case page
        case pageSize = "page_size"
        case participantName = "participant_name"
    }
    
    public static func builder() -> Builder {
        return Builder()
    }
    
    public class Builder {
        private var request: GetParticipantsRequest
        
        init() {
            request = GetParticipantsRequest()
        }
        
        public func isChatroomSecret(_ isChatroomSecret: Bool) -> Builder {
            request.isChatroomSecret = isChatroomSecret
            return self
        }
        
        public func chatroomId(_ chatroomId: String) -> Builder {
            request.chatroomId = chatroomId
            return self
        }
        
        public func participantName(_ participantName: String?) -> Builder {
            request.participantName = participantName
            return self
        }
        
        public func page(_ page: Int) -> Builder {
            request.page = page
            return self
        }
        
        public func pageSize(_ pageSize: Int) -> Builder {
            request.pageSize = pageSize
            return self
        }
        
        public func build() -> GetParticipantsRequest {
            return request
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder()
            .isChatroomSecret(isChatroomSecret)
            .chatroomId(chatroomId)
            .participantName(participantName)
            .page(page)
            .pageSize(pageSize)
    }
}
