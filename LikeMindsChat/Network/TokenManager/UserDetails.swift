//
//  UserDetails.swift
//  LikeMindsChatData
//
//  Created by Anurag Tyagi on 03/07/24.
//

import Foundation

struct UserDetails {
    @UserDefaultsBacked(key: "lmFeedUserDetails")
    static var userDetails: User?
    
    @UserDefaultsBacked(key: "lmFeedAPIKey")
    static var apiKey: String?
}
