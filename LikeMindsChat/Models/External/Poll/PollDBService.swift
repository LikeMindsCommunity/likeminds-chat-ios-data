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
        let realm = RealmManager.realmInstance()
        guard let conversationRO = ChatDBUtil.shared.getConversation(realm: realm, conversationId: conversationId),
        let pollOptionRO = ROConverter.convertPoll(realm: realm, communityId: SDKPreferences.shared.getCommunityId(), poll: poll, uuid: poll?.member?.sdkClientInfo?.uuid) else { return }
        realm.writeAsync {
            conversationRO.polls.append(pollOptionRO)
        }
    }
    
}
