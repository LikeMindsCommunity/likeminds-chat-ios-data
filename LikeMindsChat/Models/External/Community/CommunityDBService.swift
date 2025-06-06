//
//  CommunityDBService.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 12/04/24.
//

import Foundation
import RealmSwift

class CommunityDBService {
    
    static let shared = CommunityDBService()
    
    func getMember(uuid: String) -> MemberRO? {
        guard let communityId = SDKPreferences.shared.getCommunityId() else { return nil }
        return ChatDBUtil.shared.getMember(realm: LMDBManager.lmDBInstance(), communityId: communityId, uuid: uuid)
    }
    
    func getUser() -> UserRO? {
        guard let communityId = SDKPreferences.shared.getCommunityId() else { return nil }
        return ChatDBUtil.shared.getLoggedInUser(realm: LMDBManager.lmDBInstance())
    }
    
}
