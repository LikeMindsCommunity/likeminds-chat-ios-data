//
//  Poll.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class Poll {
    let id: String?
    let text: String
    let isSelected: Bool?
    let percentage: Int?
    let subText: String?
    let noVotes: Int?
    let member: Member?
    let userId: String?
    
    private init(id: String?, text: String, isSelected: Bool?, percentage: Int?, subText: String?, noVotes: Int?, member: Member?, userId: String?) {
        self.id = id
        self.text = text
        self.isSelected = isSelected
        self.percentage = percentage
        self.subText = subText
        self.noVotes = noVotes
        self.member = member
        self.userId = userId
    }
    
    class Builder {
        private var id: String?
        private var text: String = ""
        private var isSelected: Bool? = nil
        private var percentage: Int? = nil
        private var subText: String? = nil
        private var noVotes: Int? = nil
        private var member: Member? = nil
        private var userId: String? = nil
        
        func id(_ id: String?) -> Builder {
            self.id = id
            return self
        }
        
        func text(_ text: String) -> Builder {
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
        
        func build() -> Poll {
            return Poll(
                id: id,
                text: text,
                isSelected: isSelected,
                percentage: percentage,
                subText: subText,
                noVotes: noVotes,
                member: member,
                userId: userId
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
            .member(member)
            .userId(userId)
    }
}
