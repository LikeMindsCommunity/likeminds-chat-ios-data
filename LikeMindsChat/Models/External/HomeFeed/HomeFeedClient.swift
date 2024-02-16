//
//  HomeFeedClient.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 24/01/24.
//

import Foundation
import RealmSwift

protocol BaseClientProtocol: AnyObject {
    func addObserver(_ ob: RealmObjectChangeObserver)
    func removeObserver(_ ob: RealmObjectChangeObserver)
}

class HomeFeedClient {
    
    private var notificationToken: NotificationToken?
    private var chatroomsResult: List<ChatroomRO>?
    private var observers: [HomeFeedClientObserver?] = []
    
    static let shared = HomeFeedClient()
    
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
            SyncOperationUtil.startFirstHomeFeedSync { response in
                // Do somthing with response
            }
        } else {
            SyncOperationUtil.startReopenSyncForHomeFeed { response in
                // Do somthing with response
            }
        }
    }
    
    func getChatrooms(withObserver observer: HomeFeedClientObserver) {
        guard let communityId = SDKPreferences.shared.getCommunityId() else { return }
        addObserver(observer)
        chatroomsResult = ChatDBUtil.shared.getChatrooms(realm: RealmManager.realmInstance(), communityId: communityId).list
        
        // Observe collection notifications. Keep a strong
        // reference to the notification token or the
        // observation will stop.
        notificationToken = chatroomsResult?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self else { return }
            switch changes {
            case .initial:
                guard let chatrooms = chatroomsResult?.compactMap({ ro in
                    return ModelConverter.shared.convertChatroomRO(chatroomRO:ro)
                }) else { return }
                observers.forEach { $0?.initial(Array(chatrooms))}
            case .update(_, let deletions, let insertions, let modifications):
                guard let chatrooms = chatroomsResult?.compactMap({ ro in
                    return ModelConverter.shared.convertChatroomRO(chatroomRO:ro)
                }) else { return }
                observers.forEach { $0?.onChange(removed: deletions, inserted: self.getIndexedChatrooms(indexArray: insertions), updated: self.getIndexedChatrooms(indexArray: modifications))}
                break
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
            }
        }
    }
    
    private func getIndexedChatrooms(indexArray: [Int]) -> [(Int, Chatroom)] {
        return indexArray.compactMap {  index in
            let chatroomRO = chatroomsResult?[index]
            let chatroom = ModelConverter.shared.convertChatroomRO(chatroomRO: chatroomRO)
            return (index, chatroom) as? (Int, Chatroom)
        }
    }
    
}
