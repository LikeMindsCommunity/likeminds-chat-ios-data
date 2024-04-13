//
//  ServiceConfiguration.swift
//  CollabMates
//
//  Created by Likemind on 14/04/21.
//  Copyright © 2021 CollabMates. All rights reserved.
//

import Foundation
import Alamofire

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
    func appending(_ queryItem: String, value: String?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        var queryItems: [URLQueryItem] = urlComponents.queryItems?.filter({$0.name != queryItem}) ??  []
        let queryItem = URLQueryItem(name: queryItem, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}

public struct ServiceAPI {
    static let requestTimeout = TimeInterval(30)
    static let authBaseURL = ServiceConfiguration.authBaseURL
    public static let bucketURL = ServiceConfiguration.bucketURL
    public static let awsPoolIdCognito = ServiceConfiguration.awsPoolIdCognito
    public static let secretAccessKey = ServiceConfiguration.secretAccessKey
    public static let accessKey = ServiceConfiguration.accessKey
}

struct ServiceConfigurationURLs {
    struct Production {
        static let authBaseUrl = "https://auth.likeminds.community/"
        static let bucketURL = "prod-likeminds-media"
        static let awsPoolIdCognito = "d73bc2ed-bede-42c8-bab7-0abe0a001325"
        static let secretAccessKey = "aG5oTXBlSFZ3N04zWWpEbXVZSittTkwrd2Y2dW12K29IYXo5ZmdmYQ=="
        static let accessKey = "QUtJQTNITVRESUNDV0JTR1Y2N1o="
    }
    struct DevTest {
        static let authBaseUrl = "https://betaauth.likeminds.community/"
        static let bucketURL = "beta-likeminds-media"
        static let awsPoolIdCognito = "181963ba-f2db-450b-8199-964a941b38c2"
        static let secretAccessKey = "OWdLeWpGQ3d4Q0RWVDlYaHlNV3VINEdCcXUvVUk3cEFRSkZrNmd1bg=="
        static let accessKey = "QUtJQTNITVRESUNDWUJCWUdJNko="
    }
    static let timeOutInterval:TimeInterval = 60
}


struct ServiceAPIRequest {

    enum NetworkPath {
        //MARK:- SDK APIs
        case initiateChatClient(_ request: InitiateUserRequest)
        case refreshServiceToken(rtm: String)
        case pushToken(_ request: RegisterDeviceRequest)
        case logout(_ request: LogoutRequest)
        case getConfig
        case sdkOnboarding
        case explorTabCount
        case explorFeed
        
        //MARK:- Chatrooms api
        case syncChatrooms(_ request: ChatroomSyncRequest)
        case getChatroomActions(_ request: GetChatroomActionsRequest)
        case followChatroom(_ request: FollowChatroomRequest)
        case leaveSecretChatroom(_ request: LeaveSecretChatroomRequest)
        case muteChatroom(_ request: MuteChatroomRequest)
        case markReadChatroom(_ request: MarkReadChatroomRequest)
        case setChatroomTopic(_ request: SetChatroomTopicRequest)
        case getParticipants(_ request: GetParticipantsRequest)
        case editChatroomTitle(_ request: EditChatroomTitleRequest)
        
        //MARK:- Community api
        case getExploreFeed(_ request: GetExploreFeedRequest)
        case getContentDownloadSettings
        
        //MARK:- Conversation api
        case syncConversations(_ request: ConversationSyncRequest)
        case postConversation(_ request: PostConversationRequest)
        case editConversation(_ request: EditConversationRequest)
        case deleteConversations(_ request: DeleteConversationsRequest)
        case putReaction(_ request: PutReactionRequest)
        case deleteReaction(_ request: DeleteReactionRequest)
        case putMultimedia(_ request: PutMultimediaRequest)
        
        //MARK:- Helper api
        case decodeUrl(_ request: DecodeUrlRequest )
        case getTaggingList(_ request: GetTaggingListRequest)
        case getExploreTabCount
        
        //MARK:- Poll api
        case postPollConversation(_ request: PostPollConversationRequest)
        case addPollOption(_ request: AddPollOptionRequest)
        case submitPoll(_ request: SubmitPollRequest)
        case getPollUsers(_ request: GetPollUsersRequest)
        
        //MARK:- Search api
        case searchChatroom(_ request: SearchChatroomRequest)
        case searchConversation(_ request: SearchConversationRequest)
        
        //MARK:- Report api
        case getReportTags(_ reqeust: GetReportTagsRequest)
        case postReport(_ request: PostReportRequest)
        
        var apiURL: String {
            switch self {
            case .initiateChatClient:
                return "sdk/initiate"
            case .refreshServiceToken:
                return "user/refresh"
            case .pushToken:
                return "user/device/push"
            case .logout:
                return "user/logout"
            case .getConfig:
                return "user/config"
            case .sdkOnboarding:
                return "sdk/onboarding"
            case .explorTabCount:
                return "community/member/home/meta"
            case .explorFeed:
                return "community/feed"
                
            //MARK:- Chatrooms api URL
            case .syncChatrooms(let request):
                var urlRequest = "chatroom/sync?is_local_db=true&page=\(request.page)&page_size=\(request.pageSize)&min_timestamp=\(request.minTimestamp)&max_timestamp=\(request.maxTimestamp)"
                
                if !request.chatroomTypes.isEmpty {
                    urlRequest.append("&chatroom_types=[\(request.chatroomTypes.map({"\($0)"}).joined(separator: ","))]")
                }
                
                return urlRequest
            case .getChatroomActions(let request):
                return "chatroom?chatroom_id=\(request.chatroomId)"
            case .followChatroom:
                return "chatroom/follow"
            case .leaveSecretChatroom:
                return "chatroom/participants"
            case .muteChatroom:
                return "chatroom/mute"
            case .markReadChatroom:
                return "chatroom/mark_read"
            case .setChatroomTopic:
                return "conversation/topic"
            case .getParticipants(let request):
                var queryUrl =  "chatroom/participants?chatroom_id=\(request.chatroomId)&is_secret=\(request.isChatroomSecret)&page=\(request.page)&page_size=\(request.pageSize)"
                guard let searchName = request.participantName else { return queryUrl }
                return queryUrl + "&participant_name=\(searchName)"
            case .editChatroomTitle:
                return "chatroom"
                
            //MARK:- Community api URL
            case .getExploreFeed(let request):
                return "community/feed"
            case .getContentDownloadSettings:
                return "community/settings/content_download"
                
            //MARK:- Conversation api URL
            case .postConversation,
                    .editConversation,
                    .deleteConversations,
                    .postPollConversation:
                return "conversation"
                
            case .syncConversations(let request):
                var urlRequest = "conversation/sync?is_local_db=true&chatroom_id=\(request.chatroomId ?? "")&page=\(request.page)&page_size=\(request.pageSize)&min_timestamp=\(request.minTimestamp ?? 0)&max_timestamp=\(request.maxTimestamp ?? 0)"
                return urlRequest
            case .putReaction,
                    .deleteReaction:
                return "conversation/reaction"
            case .putMultimedia:
                return "helper/media/upload"
                
            //MARK:- Helper api URL
            case .decodeUrl(let request):
                return "helper/url?url=\(request.url)"
            case .getTaggingList(let request):
                let requestUrl = "community/tag?page_size=\(request.pageSize)&page=\(request.page)" + ((request.searchName ?? "").isEmpty ? "" : "&search_name=\(request.searchName ?? "")")
                return requestUrl
            case .getExploreTabCount:
                return "community/member/home/meta"
                
            // MARK:- Poll api URL
            case .addPollOption:
                return "conversation/poll"
            case .submitPoll:
                return "conversation/poll/submit"
            case .getPollUsers(let request):
                return "conversation/poll/users"
            case .searchChatroom(let request):
                return "chatroom/search"
            case .searchConversation(let request):
                return "conversation/search"
                
            //MARK:- Report api
            case .getReportTags(let request):
                return "community/report/tag?type=\(request.type)"
            case .postReport(let request):
                return "community/report"
            }
        }

        var httpMethod: Alamofire.HTTPMethod {
            switch self {
            case .initiateChatClient,
                    .refreshServiceToken,
                    .pushToken,
                    .logout,
                    .markReadChatroom,
                    .putMultimedia,
                    .postConversation,
                    .postPollConversation,
                    .addPollOption,
                    .submitPoll,
                    .postReport:
                return .post
            case .getConfig,
                    .syncChatrooms,
                    .syncConversations,
                    .sdkOnboarding,
                    .explorTabCount,
                    .explorFeed,
                    .getChatroomActions,
                    .getParticipants,
                    .getExploreFeed,
                    .getContentDownloadSettings,
                    .decodeUrl,
                    .getTaggingList,
                    .getExploreTabCount,
                    .searchChatroom,
                    .searchConversation,
                    .getPollUsers,
                    .getReportTags:
                return .get
            case .setChatroomTopic,
                    .muteChatroom,
                    .followChatroom,
                    .editChatroomTitle,
                    .putReaction,
                    .editConversation:
                return .put
            case .leaveSecretChatroom,
                    .deleteReaction,
                    .deleteConversations:
                return .delete
            }
        }

        var requestTimeout: TimeInterval {
            switch self {
            default:
                return ServiceAPI.requestTimeout
            }
        }

        var parameters: Alamofire.Parameters? {
            switch self {
            case .initiateChatClient(let request):
                return request.requestParam()
            case .pushToken(let request):
                return ["token": request.token ?? ""]
            case .refreshServiceToken:
                return [:]
            case .logout(let request):
                return request.requestParam()
            case .syncChatrooms(let request):
                return request.requestParam()
            case .followChatroom(let request):
                return request.requestParam()
            case .leaveSecretChatroom(let request):
                return request.requestParam()
            case .muteChatroom(let request):
                return request.requestParam()
            case .markReadChatroom(let request):
                return request.requestParam()
            case .setChatroomTopic(let request):
                return request.requestParam()
            case .editChatroomTitle(let request):
                return request.requestParam()
            case .postConversation(let request):
                return request.requestParam()
            case .editConversation(let request):
                return request.requestParam()
            case .deleteConversations(let request):
                return request.requestParam()
            case .putReaction(let request):
                return request.requestParam()
            case .deleteReaction(let request):
                return request.requestParam()
            case .putMultimedia(let request):
                return request.requestParam()
            case .addPollOption(let request):
                return request.requestParam()
            case .submitPoll(let request):
                return request.requestParam()
            case .postPollConversation(let request):
                return request.requestParam()
            case .postReport(let request):
                return request.requestParam()
                
            default:
                return nil
            }
        }

        var encoding: Alamofire.ParameterEncoding {
            switch self {
            default:
                return JSONEncoding.default
            }
        }
    }
}


struct ServiceConfiguration {

    static let authBaseURL:String = {
        var url = ServiceConfigurationURLs.Production.authBaseUrl
        switch BuildManager.environment {
        case .devtest:
            url = ServiceConfigurationURLs.DevTest.authBaseUrl
            break
        case .production:
            break
        }
        return url
    }()

    static let bucketURL:String = {
        var url = ServiceConfigurationURLs.Production.bucketURL
        switch BuildManager.environment {
        case .devtest:
            url = ServiceConfigurationURLs.DevTest.bucketURL
            break
        case .production:
            break
        }
        return url
    }()

    static let secretAccessKey:String = {
        var secretAccessKey = ServiceConfigurationURLs.Production.secretAccessKey.fromBase64() ?? ""
        switch BuildManager.environment {
        case .devtest:
            secretAccessKey = ServiceConfigurationURLs.DevTest.secretAccessKey.fromBase64() ?? ""
            break
        case .production:
            break
        }
        return secretAccessKey
    }()

    static let accessKey:String = {
        var accessKey = ServiceConfigurationURLs.Production.accessKey.fromBase64() ?? ""
        switch BuildManager.environment {
        case .devtest:
            accessKey = ServiceConfigurationURLs.DevTest.accessKey.fromBase64() ?? ""
            break
        case .production:
            break
        }
        return accessKey
    }()
    
    static let awsPoolIdCognito: String = {
        var accessKey = ServiceConfigurationURLs.Production.awsPoolIdCognito
        switch BuildManager.environment {
        case .devtest:
            accessKey = ServiceConfigurationURLs.DevTest.awsPoolIdCognito
            break
        case .production:
            break
        }
        return accessKey
    }()
}
