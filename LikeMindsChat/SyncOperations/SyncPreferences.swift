//
//  SyncPreferences.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 10/01/24.
//

import Foundation

class BasePreferences {
    
    let userDefault = UserDefaults.standard
    
    func setValue(_ value: Any, forKey key: String) {
        userDefault.setValue(value, forKey: key)
        userDefault.synchronize()
    }
    
    func getValue(forKey key: String) -> Any? {
        userDefault.value(forKey: key)
    }

}

class SyncPreferences: BasePreferences {
    
    static let shared = SyncPreferences()
    private let syncChatroomTimeStamp = "syncChatroomTimeStamp"
    private let syncConversationTimeStamp = "syncConversationTimeStamp"
    
    private override init() {}
    
    func setTimestampForSyncChatroom(time: Int) {
        setValue(time, forKey: syncChatroomTimeStamp)
    }
    
    func getTimestampForSyncChatroom() -> Int {
        return (getValue(forKey: syncChatroomTimeStamp) as? Int) ?? 0
    }
    
    func setTimestampForSyncConversation(time: Int) {
        setValue(time, forKey: syncConversationTimeStamp)
    }
    
    func getTimestampForSyncConversation() -> Int {
        return (getValue(forKey: syncChatroomTimeStamp) as? Int) ?? 0
    }
    
}

class SDKPreferences: BasePreferences {
    
    static let shared = SDKPreferences()
    private let communityIDKey = "CommunityId_key"
    
    private override init() {}
    
    func setCommunityId(communityId: String) {
        setValue(communityId, forKey: communityIDKey)
    }
    
    func getCommunityId() -> String? {
        return getValue(forKey: communityIDKey) as? String
    }
    
}

class UserPreferences: BasePreferences {
    
    static let shared = UserPreferences()
    private let lmUUID = "lm_uuid_key"
    private let lmMemberId = "lm_memberid_key"
    private let clientUUID = "client_uuid_key"
    
    private override init() {}
    
    func setLMMemberId(_ lmMemberID: String) {
        setValue(lmMemberID, forKey: lmMemberId)
    }
    
    func setLMUUID(_ lmuuid: String) {
        setValue(lmuuid, forKey: lmUUID)
    }
    
    func setClientUUID(_ clientUUid: String) {
        setValue(clientUUid, forKey: clientUUID)
    }
    
    func getLMMemberId() -> String? {
        return getValue(forKey: lmMemberId) as? String
    }
    
    func getClientUUID() -> String? {
        return getValue(forKey: clientUUID) as? String
    }
    
    func getLMUUID() -> String? {
        return getValue(forKey: lmUUID) as? String
    }
    
}


