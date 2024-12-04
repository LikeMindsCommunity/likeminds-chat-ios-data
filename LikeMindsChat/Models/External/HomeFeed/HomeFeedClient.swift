//
//  HomeFeedClient.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 24/01/24.
//

import Foundation
import RealmSwift
import FirebaseDatabase

protocol BaseClientProtocol: AnyObject {
    func addObserver(_ ob: RealmObjectChangeObserver)
    func removeObserver(_ ob: RealmObjectChangeObserver)
}

class HomeFeedClient {
    
    private var chatroomResultnotificationToken: NotificationToken?
    private var homeFeedGroupChatrooms: Results<ChatroomRO>?
    private var observers: [HomeFeedClientObserver?] = []
    private var firebaseRealTimeDBReference: DatabaseReference?
    
    static let shared = HomeFeedClient()
    let realmInstance = LMDBManager.lmDBInstance()
    
    func addObserver(_ ob: HomeFeedClientObserver) {
        guard observers.first(where: {type(of: $0) == type(of: ob)}) == nil else { return }
        observers.append(ob)
    }
    
    func removeObserver(_ ob: HomeFeedClientObserver) {
        observers.removeAll(where: {type(of: $0) == type(of: ob)})
    }
    
    func getConfig(withModuleName moduleName: String,response: LMClientResponse<ConfigResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.getConfig
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: ServiceRequest.httpHeaders(),
                                   withParameters: networkPath.parameters,
                                   withEncoding: networkPath.encoding,
                                   withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
            do {
                let result = try JSONDecoder().decode(LMResponse<ConfigResponse>.self, from: data)
                response?(result)
            } catch let error {
                response?(LMResponse.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    func getExploreTabCount(withModuleName moduleName: String,response: LMClientResponse<GetExploreTabCountResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.explorTabCount
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: ServiceRequest.httpHeaders(),
                                   withParameters: networkPath.parameters,
                                   withEncoding: networkPath.encoding,
                                   withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
            do {
                let result = try JSONDecoder().decode(LMResponse<GetExploreTabCountResponse>.self, from: data)
                response?(result)
            } catch let error {
                response?(LMResponse.failureResponse(error.localizedDescription))
            }
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    func syncChatrooms() {
        let isFirstSync = ChatDBUtil.shared.isEmpty()
        if isFirstSync {
            SyncOperationUtil.startFirstHomeFeedSync(response: nil, chatroomTypes: [ChatroomType.normal.rawValue, ChatroomType.purpose.rawValue])
        } else {
            SyncOperationUtil.startReopenSyncForHomeFeed(response: nil, chatroomTypes: [ChatroomType.normal.rawValue, ChatroomType.purpose.rawValue])
        }
    }
    
    func syncLiveChatrooms() {
        let isFirstSync = ChatDBUtil.shared.isEmpty()
        if isFirstSync {
            SyncOperationUtil.startFirstHomeFeedSync(response: nil, chatroomTypes: [ChatroomType.normal.rawValue, ChatroomType.purpose.rawValue])
        } else {
            SyncOperationUtil.startReopenSyncForHomeFeed(response: nil, chatroomTypes: [ChatroomType.normal.rawValue, ChatroomType.purpose.rawValue])
        }
    }
    
    func getChatrooms(withObserver observer: HomeFeedClientObserver) {
        guard let communityId = SDKPreferences.shared.getCommunityId() else { return }
        addObserver(observer)
        homeFeedGroupChatrooms = ChatDBUtil.shared.getChatrooms(realm: realmInstance, communityId: communityId)
        
        // Observe collection notifications. Keep a strong
        // reference to the notification token or the
        // observation will stop.
        chatroomResultnotificationToken = homeFeedGroupChatrooms?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self else { return }
            switch changes {
            case .initial(let collections):
                guard let chatrooms = homeFeedGroupChatrooms?.list.compactMap({ ro in
                    return ModelConverter.shared.convertChatroomRO(chatroomRO:ro)
                }) else { return }
                observers.forEach { $0?.initial(Array(chatrooms))}
            case .update(let collections, let deletions, let insertions, let modifications):
                guard (homeFeedGroupChatrooms?.list.compactMap({ ro in
                    return ModelConverter.shared.convertChatroomRO(chatroomRO:ro)
                })) != nil else {
                    guard let chatrooms = homeFeedGroupChatrooms?.list.compactMap({ ro in
                        return ModelConverter.shared.convertChatroomRO(chatroomRO:ro)
                    }) else { return }
                    observers.forEach { $0?.initial(Array(chatrooms))}
                    return
                }
                observers.forEach { $0?.onChange(removed: collections.compactMap({ModelConverter.shared.convertChatroomRO(chatroomRO: $0)}), inserted: self.getIndexedChatrooms(indexArray: insertions), updated: self.getIndexedChatrooms(indexArray: modifications))}
                break
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
            }
        }
    }
    
    private func getIndexedChatrooms(indexArray: [Int]) -> [(Int, Chatroom)] {
        return indexArray.compactMap {  index in
            let chatroomRO = homeFeedGroupChatrooms?[index]
            let chatroom = ModelConverter.shared.convertChatroomRO(chatroomRO: chatroomRO)
            return (index, chatroom) as? (Int, Chatroom)
        }
    }
    
    func observeLiveHomeFeed(forCommunity communityId: String) {
        firebaseRealTimeDBReference = FirebaseServiceConfiguration.getDatabaseReferenceForHomeFeed(communityId)
        firebaseRealTimeDBReference?.observe(.childChanged, with:{[weak self] snapshot in
            self?.syncLiveChatrooms()
        })
    }
    
}
