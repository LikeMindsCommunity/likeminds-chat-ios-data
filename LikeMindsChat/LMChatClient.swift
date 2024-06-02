//
//  LMFeedClient.swift
//  LMFeed
//
//  Created by Pushpendra Singh on 16/02/23.
//

import Foundation
import FirebaseDatabase

public class LMChatClient {
    let moduleName = "LMFeedClient-SDK"
    public private(set) static var shared = LMChatClient()
    
    private init() {
        FirebaseServiceConfiguration.setupFirebaseAppService()
    }
    
    public static func builder() -> LMChatClient {
        Self.shared = LMChatClient()
        return Self.shared
    }
    
    public func lmCallback(_ lmCallback: LMCallback?) -> LMChatClient {
        guard let lmCallback = lmCallback else {
            print("--No lmCallback--")
            return Self.shared
        }
        let _ = TokenManager.shared.lmCallback(lmCallback)
        return Self.shared
    }
    
    public func build() -> LMChatClient {
        return Self.shared
    }
    
}
