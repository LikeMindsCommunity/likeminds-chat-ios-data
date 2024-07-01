//
//  DirectMessageClient.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 12/06/24.
//

import Foundation
import RealmSwift
import FirebaseDatabase

class DirectMessageClient {
 
    static let shared = DirectMessageClient()
    let realmInstance = RealmManager.realmInstance()
    private var firebaseRealTimeDBReference: DatabaseReference?
    
    private var feedDMChatrooms: Results<ChatroomRO>?
    private var dmChatroomResultnotificationToken: NotificationToken?
    private var dmObservers: [HomeFeedClientObserver?] = []
    
    private let moduleName = "DirectMessageClient"
    
    func addDMObserver(_ ob: HomeFeedClientObserver) {
        guard dmObservers.first(where: {type(of: $0) == type(of: ob)}) == nil else { return }
        dmObservers.append(ob)
    }
    
    func removeDMObserver(_ ob: HomeFeedClientObserver) {
        dmObservers.removeAll(where: {type(of: $0) == type(of: ob)})
    }

    /*
    static func showDirectMessage(communityId: Int, fromModule: String, memberId: Int?, moduleName: String) {
        let networkPath = ServiceAPIRequest.NetworkPath.showDirectMessage(communityId, fromScreen: fromModule, memberId: memberId)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: ServiceRequest.httpHeaders(),
                                   withParameters: networkPath.parameters,
                                   withEncoding: networkPath.encoding, withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
        } failureCallback: { (moduleName, error) in
        }
    }
    static func updateDirectMessage(clicked: Bool?, messaged: Bool?, moduleName: String) {
        let networkPath = ServiceAPIRequest.NetworkPath.updateDMTutorial(clicked, messaged: messaged)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.request(for: url,
                                   withHTTPMethod: networkPath.httpMethod,
                                   headers: ServiceRequest.httpHeaders(),
                                   withParameters: networkPath.parameters,
                                   withEncoding: networkPath.encoding, withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? Data else {return}
        } failureCallback: { (moduleName, error) in
        }
    }
    
    */
    
    func syncDMChatrooms() {
        let isFirstSync = ChatDBUtil.shared.isEmpty()
        if isFirstSync {
            SyncOperationUtil.startFirstDMFeedSync(response: nil, chatroomTypes: [ChatroomType.directMessage.rawValue])
        } else {
            SyncOperationUtil.startReopenSyncForDMFeed(response: nil, chatroomTypes: [ChatroomType.directMessage.rawValue])
        }
    }
    
    func getChatrooms(withObserver observer: HomeFeedClientObserver) {
        guard let communityId = SDKPreferences.shared.getCommunityId() else { return }
        addDMObserver(observer)
        feedDMChatrooms = ChatDBUtil.shared.getDMChatrooms(realm: realmInstance, communityId: communityId)
        
        // Observe collection notifications. Keep a strong
        // reference to the notification token or the
        // observation will stop.
        dmChatroomResultnotificationToken = feedDMChatrooms?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self else { return }
            switch changes {
            case .initial(let collections):
                guard let chatrooms = feedDMChatrooms?.list.compactMap({ ro in
                    return ModelConverter.shared.convertChatroomRO(chatroomRO:ro)
                }) else { return }
                dmObservers.forEach { $0?.initial(Array(chatrooms))}
            case .update(let collections, let deletions, let insertions, let modifications):
                guard (feedDMChatrooms?.list.compactMap({ ro in
                    return ModelConverter.shared.convertChatroomRO(chatroomRO:ro)
                })) != nil else {
                    guard let chatrooms = feedDMChatrooms?.list.compactMap({ ro in
                        return ModelConverter.shared.convertChatroomRO(chatroomRO:ro)
                    }) else { return }
                    dmObservers.forEach { $0?.initial(Array(chatrooms))}
                    return
                }
                dmObservers.forEach { $0?.onChange(removed: collections.compactMap({ModelConverter.shared.convertChatroomRO(chatroomRO: $0)}), inserted: self.getIndexedDMChatrooms(indexArray: insertions), updated: self.getIndexedDMChatrooms(indexArray: modifications))}
                break
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
            }
        }
    }
    
    private func getIndexedDMChatrooms(indexArray: [Int]) -> [(Int, Chatroom)] {
        return indexArray.compactMap {  index in
            let chatroomRO = feedDMChatrooms?[index]
            let chatroom = ModelConverter.shared.convertChatroomRO(chatroomRO: chatroomRO)
            return (index, chatroom) as? (Int, Chatroom)
        }
    }
    
    func checkDMTab(_ response: LMClientResponse<CheckDMTabResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.checkDMTab
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                               withHTTPMethod: networkPath.httpMethod,
                                               headers: ServiceRequest.httpHeadersWithAPIVersion(),
                                               withParameters: networkPath.parameters,
                                               withEncoding: networkPath.encoding,
                                               withResponseType: CheckDMTabResponse.self,
                                               withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<CheckDMTabResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }

    func checkDMStatus(request: CheckDMStatusRequest, response: LMClientResponse<CheckDMStatusResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.checkDMStatus(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: CheckDMStatusResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<CheckDMStatusResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    func checkDMLimit(request: CheckDMLimitRequest, response: LMClientResponse<CheckDMLimitResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.checkDMLimit(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: CheckDMLimitResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<CheckDMLimitResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    func createDMChatroom(request: CreateDMChatroomRequest, response: LMClientResponse<CheckDMChatroomResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.createDMChatroom(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: CheckDMChatroomResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<CheckDMChatroomResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    func sendDMRequest(request: SendDMRequest,  response: LMClientResponse<SendDMResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.sendDMRequest(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: SendDMResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<SendDMResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    func blockDMMember(request: BlockMemberRequest, response: LMClientResponse<BlockMemberResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.blockDMMember(request)
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: BlockMemberResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<BlockMemberResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    func syncLiveChatrooms() {
        let isFirstSync = ChatDBUtil.shared.isEmpty()
        if isFirstSync {
            SyncOperationUtil.startFirstDMFeedSync(response: nil, chatroomTypes: [ChatroomType.directMessage.rawValue])
        } else {
            SyncOperationUtil.startReopenSyncForDMFeed(response: nil, chatroomTypes: [ChatroomType.directMessage.rawValue])
        }
    }
    
    func observeLiveHomeFeed(forCommunity communityId: String) {
        firebaseRealTimeDBReference = FirebaseServiceConfiguration.getDatabaseReferenceForHomeFeed(communityId)
        firebaseRealTimeDBReference?.observe(.childChanged, with:{[weak self] snapshot in
            self?.syncLiveChatrooms()
        })
    }
}
