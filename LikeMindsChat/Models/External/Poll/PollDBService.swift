//
//  PollDBService.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 05/08/24.
//

import Foundation
import RealmSwift

class PollDBService {
    
    static let shared = PollDBService()
    
    func updateNewPollOption(poll: Poll?, conversationId: String) {
        let realm = LMDBManager.lmDBInstance()
        guard let conversationRO = ChatDBUtil.shared.getConversation(realm: realm, conversationId: conversationId),
        let pollOptionRO = ROConverter.convertPoll(realm: realm, communityId: SDKPreferences.shared.getCommunityId(), poll: poll, uuid: poll?.member?.sdkClientInfo?.uuid) else { return }
        realm.writeAsync {
            conversationRO.polls.append(pollOptionRO)
        }
    }
    
    func updateConversationSubmitPolls(conversationId: String, polls: [Poll]) {
        let realm = LMDBManager.lmDBInstance()
        guard let conversationRO = ChatDBUtil.shared.getConversation(realm: realm, conversationId: conversationId) else { return }
        realm.writeAsync {
            conversationRO.polls.forEach { pollRo in
                if pollRo.isSelected == true {
                    pollRo.noVotes = (pollRo.noVotes ?? 1) - 1
                }
                pollRo.isSelected = false
            }
            let containsAnyVote = !(conversationRO.polls.filter({($0.noVotes ?? 0) > 0})).isEmpty
            polls.forEach { poll in
                if let pollRo = conversationRO.polls.first(where: {$0.id == poll.id}) {
                    pollRo.isSelected = poll.isSelected
                    pollRo.noVotes = poll.noVotes
                    pollRo.percentage = poll.percentage
                }
            }
            if !containsAnyVote {
                //This means the current user has voted as a first user.
                conversationRO.pollAnswerText = "1 member voted on this poll"
            }
        }
    }
    
}
