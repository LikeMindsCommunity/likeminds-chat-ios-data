//
//  PostPollConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class PostPollConversationRequest {
    let chatroomId: String
    let text: String
    let repliedConversationId: String?
    let polls: [Poll]
    let pollType: Int
    let multipleSelectState: Int?
    let multipleSelectNo: Int?
    let isAnonymous: Bool
    let allowAddOption: Bool
    let expiryTime: Int64
    let temporaryId: String?
    
    private init(chatroomId: String, text: String, repliedConversationId: String?, polls: [Poll], pollType: Int, multipleSelectState: Int?, multipleSelectNo: Int?, isAnonymous: Bool, allowAddOption: Bool, expiryTime: Int64, temporaryId: String?) {
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
    
    class Builder {
        private var chatroomId: String = ""
        private var text: String = ""
        private var repliedConversationId: String? = nil
        private var polls: [Poll] = []
        private var pollType: Int = -1
        private var multipleSelectState: Int? = nil
        private var multipleSelectNo: Int? = nil
        private var isAnonymous: Bool = false
        private var allowAddOption: Bool = false
        private var expiryTime: Int64 = -1
        private var temporaryId: String? = nil
        
        func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func text(_ text: String) -> Builder {
            self.text = text
            return self
        }
        
        func repliedConversationId(_ repliedConversationId: String?) -> Builder {
            self.repliedConversationId = repliedConversationId
            return self
        }
        
        func polls(_ polls: [Poll]) -> Builder {
            self.polls = polls
            return self
        }
        
        func pollType(_ pollType: Int) -> Builder {
            self.pollType = pollType
            return self
        }
        
        func multipleSelectState(_ multipleSelectState: Int?) -> Builder {
            self.multipleSelectState = multipleSelectState
            return self
        }
        
        func multipleSelectNo(_ multipleSelectNo: Int?) -> Builder {
            self.multipleSelectNo = multipleSelectNo
            return self
        }
        
        func isAnonymous(_ isAnonymous: Bool) -> Builder {
            self.isAnonymous = isAnonymous
            return self
        }
        
        func allowAddOption(_ allowAddOption: Bool) -> Builder {
            self.allowAddOption = allowAddOption
            return self
        }
        
        func expiryTime(_ expiryTime: Int64) -> Builder {
            self.expiryTime = expiryTime
            return self
        }
        
        func temporaryId(_ temporaryId: String?) -> Builder {
            self.temporaryId = temporaryId
            return self
        }
        
        func build() -> PostPollConversationRequest {
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
    
    func toBuilder() -> Builder {
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
