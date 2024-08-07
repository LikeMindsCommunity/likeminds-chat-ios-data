//
//  SyncPreferences.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 10/01/24.
//

import Foundation

public class BasePreferences {
    
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
    private let syncDMChatroomTimeStamp = "syncDMChatroomTimeStamp"
    private let syncConversationTimeStamp = "syncConversationTimeStamp"
    
    private override init() {}
    
    func setTimestampForSyncChatroom(time: Int) {
        setValue(time, forKey: syncChatroomTimeStamp)
    }
    
    func getTimestampForSyncChatroom() -> Int {
        return (getValue(forKey: syncChatroomTimeStamp) as? Int) ?? 0
    }
    
    func setTimestampForSyncDMChatroom(time: Int) {
        setValue(time, forKey: syncDMChatroomTimeStamp)
    }
    
    func getTimestampForSyncDMChatroom() -> Int {
        return (getValue(forKey: syncDMChatroomTimeStamp) as? Int) ?? 0
    }
    
    func setTimestampForSyncConversation(time: Int) {
        setValue(time, forKey: syncConversationTimeStamp)
    }
    
    func getTimestampForSyncConversation() -> Int {
        return (getValue(forKey: syncConversationTimeStamp) as? Int) ?? 0
    }
    
    public func clearData() {
        userDefault.removeObject(forKey: syncChatroomTimeStamp)
        userDefault.removeObject(forKey: syncDMChatroomTimeStamp)
        userDefault.removeObject(forKey: syncConversationTimeStamp)
        userDefault.synchronize()
    }
    
}

public class SDKPreferences: BasePreferences {
    
    public static let shared = SDKPreferences()
    private let communityIDKey = "CommunityId_key"
    private let lmApiKey = "lm_api_key"
    private let communityNameKey = "Community_name_key"
    
    private override init() {}
    
    func setApiKey(_ apiKey: String){
        setValue(apiKey, forKey: lmApiKey)
    }
    
    func setCommunityId(communityId: String) {
        setValue(communityId, forKey: communityIDKey)
    }
    
    public func getCommunityId() -> String? {
        return getValue(forKey: communityIDKey) as? String
    }
    
    public func getApiKey() -> String? {
        return getValue(forKey: lmApiKey) as? String
    }
    
    func setCommunityName(communityName: String) {
        setValue(communityName, forKey: communityNameKey)
    }
    
    public func getCommunityName() -> String? {
        return getValue(forKey: communityNameKey) as? String
    }
    
    public func clearData() {
        userDefault.removeObject(forKey: communityIDKey)
        userDefault.removeObject(forKey: communityNameKey)
        userDefault.synchronize()
    }
}

public class UserPreferences: BasePreferences {
    
    public static let shared = UserPreferences()
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
    
    public func getLMMemberId() -> String? {
        return getValue(forKey: lmMemberId) as? String
    }
    
    public func getClientUUID() -> String? {
        return getValue(forKey: clientUUID) as? String
    }
    
    public func getLMUUID() -> String? {
        return getValue(forKey: lmUUID) as? String
    }
    
    public func clearData() {
        userDefault.removeObject(forKey: lmUUID)
        userDefault.removeObject(forKey: lmMemberId)
        userDefault.removeObject(forKey: clientUUID)
        userDefault.synchronize()
    }
}


