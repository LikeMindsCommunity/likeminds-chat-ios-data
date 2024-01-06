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
        case syncChatrooms(_ request: ChatroomSyncRequest)
        case syncConversations(_ request: ConversationSyncRequest)
        case sdkOnboarding
        case explorTabCount
        case explorFeed
        
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
            case .syncChatrooms:
                return "chatroom/sync"
            case .syncConversations:
                return "conversation/sync"
            case .sdkOnboarding:
                return "sdk/onboarding"
            case .explorTabCount:
                return "community/member/home/meta"
            case .explorFeed:
                return "community/feed"
            }
        }

        var httpMethod: Alamofire.HTTPMethod {
            switch self {
            case .initiateChatClient,
                    .refreshServiceToken,
                    .pushToken,
                    .logout:
                return .post
            case .getConfig,
                    .syncChatrooms,
                    .syncConversations,
                    .sdkOnboarding,
                    .explorTabCount,
                    .explorFeed:
                return .get
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
