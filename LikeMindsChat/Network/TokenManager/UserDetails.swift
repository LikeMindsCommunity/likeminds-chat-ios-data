//
//  UserDetails.swift
//  LikeMindsChatData
//
//  Created by Anurag Tyagi on 03/07/24.
//

import Foundation

struct UserDetails {
    @UserDefaultsBacked(key: "lmChatUserDetails")
    static var userDetails: User?
    
    @UserDefaultsBacked(key: "lmChatAPIKey")
    static var apiKey: String?
}
