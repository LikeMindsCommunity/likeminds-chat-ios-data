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

struct ServiceConfigurationURLs {
    struct Production {
        static let authBaseUrl = "https://auth.likeminds.community/"
        static let bucketURL = "prod-likeminds-media"
        static let awsPoolIdCognito = "d73bc2ed-bede-42c8-bab7-0abe0a001325"
        static let secretAccessKey = "aG5oTXBlSFZ3N04zWWpEbXVZSittTkwrd2Y2dW12K29IYXo5ZmdmYQ=="
        static let accessKey = "QUtJQTNITVRESUNDV0JTR1Y2N1o="
        static let firebaseApiKey = "QUl6YVN5Q2NXTWhDTWpGSVZneWVVNUtVNC1lcE9qOWw4V1c4WDVj"
    }
    struct DevTest {
        static let authBaseUrl = "https://betaauth.likeminds.community/"
        static let bucketURL = "beta-likeminds-media"
        static let awsPoolIdCognito = "181963ba-f2db-450b-8199-964a941b38c2"
        static let secretAccessKey = "OWdLeWpGQ3d4Q0RWVDlYaHlNV3VINEdCcXUvVUk3cEFRSkZrNmd1bg=="
        static let accessKey = "QUtJQTNITVRESUNDWUJCWUdJNko="
        static let firebaseApiKey = "QUl6YVN5Q3VNSEJjLTNLdEhKTzQ2NGZ0Wm1zNTRrMEQ2WEQ4enNR"
    }
    static let timeOutInterval:TimeInterval = 60
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
    
    static let firebaseApiKey:String = {
        var firebaseKey = ServiceConfigurationURLs.Production.firebaseApiKey.fromBase64() ?? ""
        switch BuildManager.environment {
        case .devtest:
            firebaseKey = ServiceConfigurationURLs.DevTest.firebaseApiKey.fromBase64() ?? ""
            break
        case .production:
            break
        }
        return firebaseKey
    }()
}
