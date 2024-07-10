//
//  LMChatTokenManager.swift
//  LikeMindsChatData
//
//  Created by Anurag Tyagi on 03/07/24.
//

import Foundation

struct LMChatTokenManager {
    @UserDefaultsBacked(key: "lmChatAccessToken")
    static var accessToken: String?
    
    @UserDefaultsBacked(key: "lmChatRefreshToken")
    static var refreshToken: String?
}

public struct LMChatTokenResponse: Decodable{
    public let accessToken: String
    public let refreshToken: String
}
