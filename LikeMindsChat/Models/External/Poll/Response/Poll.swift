//
//  Poll.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public class Poll: Codable {
    public let id: String?
    public let text: String?
    public let isSelected: Bool?
    public let percentage: Int?
    public let subText: String?
    public let noVotes: Int?
//    public let member: Member?
    public let userId: String?
    public let conversationId: String?
    
    private init(id: String?, text: String?, isSelected: Bool?, percentage: Int?, subText: String?, noVotes: Int?, member: Member?, userId: String?, conversationId: String?) {
        self.id = id
        self.text = text
        self.isSelected = isSelected
        self.percentage = percentage
        self.subText = subText
        self.noVotes = noVotes
//        self.member = member
        self.userId = userId
        self.conversationId = conversationId
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIntToStringIfPresent(forKey: .id)
        text = try container.decodeIfPresent(String.self, forKey: .text)
        isSelected = try container.decodeIfPresent(Bool.self, forKey: .isSelected)
        percentage = try container.decodeIfPresent(Int.self, forKey: .percentage)
        subText = try container.decodeIfPresent(String.self, forKey: .subText)
        noVotes = try container.decodeIfPresent(Int.self, forKey: .noVotes)
        userId = try container.decodeIntToStringIfPresent(forKey: .userId)
        conversationId = try container.decodeIntToStringIfPresent(forKey: .conversationId)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case text
        case isSelected = "is_selected"
        case percentage
        case subText = "sub_text"
        case noVotes = "no_votes"
//        case member
        case userId = "user_id"
        case conversationId = "conversation_id"
    }
    
    class Builder {
        private var id: String?
        private var text: String?
        private var isSelected: Bool? = nil
        private var percentage: Int? = nil
        private var subText: String? = nil
        private var noVotes: Int? = nil
        private var member: Member? = nil
        private var userId: String? = nil
        private var conversationId: String?
        
        func id(_ id: String?) -> Builder {
            self.id = id
            return self
        }
        
        func text(_ text: String?) -> Builder {
            self.text = text
            return self
        }
        
        func isSelected(_ isSelected: Bool?) -> Builder {
            self.isSelected = isSelected
            return self
        }
        
        func percentage(_ percentage: Int?) -> Builder {
            self.percentage = percentage
            return self
        }
        
        func subText(_ subText: String?) -> Builder {
            self.subText = subText
            return self
        }
        
        func noVotes(_ noVotes: Int?) -> Builder {
            self.noVotes = noVotes
            return self
        }
        
        func member(_ member: Member?) -> Builder {
            self.member = member
            return self
        }
        
        func userId(_ userId: String?) -> Builder {
            self.userId = userId
            return self
        }
        
        func conversationId(_ conversationId: String?) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        func build() -> Poll {
            return Poll(
                id: id,
                text: text,
                isSelected: isSelected,
                percentage: percentage,
                subText: subText,
                noVotes: noVotes,
                member: member,
                userId: userId,
                conversationId: conversationId
            )
        }
    }
    
    func toBuilder() -> Builder {
        return Builder()
            .id(id)
            .text(text)
            .isSelected(isSelected)
            .percentage(percentage)
            .subText(subText)
            .noVotes(noVotes)
//            .member(member)
            .userId(userId)
            .conversationId(conversationId)
    }
}

