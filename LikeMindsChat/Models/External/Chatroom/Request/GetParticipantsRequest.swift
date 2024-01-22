//
//  GetParticipantsRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

class GetParticipantsRequest: Encodable {
    private var isChatroomSecret: Bool = false
    private var chatroomId: String = ""
    private var participantName: String? = nil
    private var page: Int = 1
    private var pageSize: Int = 10
    
    private init() {}
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
        case isChatroomSecret = "is_chatroom_secret"
        case page
        case pageSize = "page_size"
        case participantName = "participant_name"
    }
    
    static func builder() -> Builder {
        return Builder()
    }
    
    class Builder {
        private var request: GetParticipantsRequest
        
        init() {
            request = GetParticipantsRequest()
        }
        
        func isChatroomSecret(_ isChatroomSecret: Bool) -> Builder {
            request.isChatroomSecret = isChatroomSecret
            return self
        }
        
        func chatroomId(_ chatroomId: String) -> Builder {
            request.chatroomId = chatroomId
            return self
        }
        
        func participantName(_ participantName: String?) -> Builder {
            request.participantName = participantName
            return self
        }
        
        func page(_ page: Int) -> Builder {
            request.page = page
            return self
        }
        
        func pageSize(_ pageSize: Int) -> Builder {
            request.pageSize = pageSize
            return self
        }
        
        func build() -> GetParticipantsRequest {
            return request
        }
    }
    
    func toBuilder() -> Builder {
        return Builder()
            .isChatroomSecret(isChatroomSecret)
            .chatroomId(chatroomId)
            .participantName(participantName)
            .page(page)
            .pageSize(pageSize)
    }
}
