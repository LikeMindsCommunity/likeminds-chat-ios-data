//
//  RefreshAccessTokenResponse.swift
//  LikeMindsChatData
//
//  Created by Anurag Tyagi on 04/07/24.
//

import Foundation

public class RefreshAccessTokenResponse: Decodable{
    public let accessToken: String?
    public let refreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
