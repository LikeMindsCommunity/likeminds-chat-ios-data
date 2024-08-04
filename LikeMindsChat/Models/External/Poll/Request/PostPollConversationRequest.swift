//
//  PostPollConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public class PostPollConversationRequest: Encodable {
    public private(set) var chatroomId: String
    public private(set) var text: String
    public private(set) var repliedConversationId: String?
    public private(set) var polls: [Poll]
    public private(set) var pollType: Int
    public private(set) var multipleSelectState: Int?
    public private(set) var multipleSelectNo: Int?
    public private(set) var isAnonymous: Bool
    public private(set) var allowAddOption: Bool
    public private(set) var expiryTime: Int
    public private(set) var temporaryId: String?
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id"
        case text
        case temporaryId = "temporary_id"
        case repliedConversationId = "replied_conversation_id"
        case multipleSelectNo = "multiple_select_no"
        case polls
        case pollType = "poll_type"
        case multipleSelectState = "multiple_select_state"
        case expiryTime = "expiry_time"
        case allowAddOption = "allow_add_option"
        case isAnonymous = "is_anonymous"
    }
    
    private init(chatroomId: String, text: String, repliedConversationId: String?, polls: [Poll], pollType: Int, multipleSelectState: Int?, multipleSelectNo: Int?, isAnonymous: Bool, allowAddOption: Bool, expiryTime: Int, temporaryId: String?) {
        self.chatroomId = chatroomId
        self.text = text
        self.repliedConversationId = repliedConversationId
        self.polls = polls
        self.pollType = pollType
        self.multipleSelectState = multipleSelectState
        self.multipleSelectNo = multipleSelectNo
        self.isAnonymous = isAnonymous
        self.allowAddOption = allowAddOption
        self.expiryTime = expiryTime
        self.temporaryId = temporaryId
    }
    
    public static func builder() -> Builder {
        return Builder()
    }
    
    public class Builder {
        private var chatroomId: String = ""
        private var text: String = ""
        private var repliedConversationId: String? = nil
        private var polls: [Poll] = []
        private var pollType: Int = -1
        private var multipleSelectState: Int? = nil
        private var multipleSelectNo: Int? = nil
        private var isAnonymous: Bool = false
        private var allowAddOption: Bool = false
        private var expiryTime: Int = -1
        private var temporaryId: String? = nil
        
        public func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func text(_ text: String) -> Builder {
            self.text = text
            return self
        }
        
        public func repliedConversationId(_ repliedConversationId: String?) -> Builder {
            self.repliedConversationId = repliedConversationId
            return self
        }
        
        public func polls(_ polls: [Poll]) -> Builder {
            self.polls = polls
            return self
        }
        
        public func pollType(_ pollType: Int) -> Builder {
            self.pollType = pollType
            return self
        }
        
        public func multipleSelectState(_ multipleSelectState: Int?) -> Builder {
            self.multipleSelectState = multipleSelectState
            return self
        }
        
        public func multipleSelectNo(_ multipleSelectNo: Int?) -> Builder {
            self.multipleSelectNo = multipleSelectNo
            return self
        }
        
        public func isAnonymous(_ isAnonymous: Bool) -> Builder {
            self.isAnonymous = isAnonymous
            return self
        }
        
        public func allowAddOption(_ allowAddOption: Bool) -> Builder {
            self.allowAddOption = allowAddOption
            return self
        }
        
        public func expiryTime(_ expiryTime: Int) -> Builder {
            self.expiryTime = expiryTime
            return self
        }
        
        public func temporaryId(_ temporaryId: String?) -> Builder {
            self.temporaryId = temporaryId
            return self
        }
        
        public func build() -> PostPollConversationRequest {
            return PostPollConversationRequest(
                chatroomId: chatroomId,
                text: text,
                repliedConversationId: repliedConversationId,
                polls: polls,
                pollType: pollType,
                multipleSelectState: multipleSelectState,
                multipleSelectNo: multipleSelectNo,
                isAnonymous: isAnonymous,
                allowAddOption: allowAddOption,
                expiryTime: expiryTime,
                temporaryId: temporaryId
            )
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder()
            .chatroomId(chatroomId)
            .text(text)
            .repliedConversationId(repliedConversationId)
            .polls(polls)
            .pollType(pollType)
            .multipleSelectState(multipleSelectState)
            .multipleSelectNo(multipleSelectNo)
            .isAnonymous(isAnonymous)
            .allowAddOption(allowAddOption)
            .expiryTime(expiryTime)
            .temporaryId(temporaryId)
    }
}
