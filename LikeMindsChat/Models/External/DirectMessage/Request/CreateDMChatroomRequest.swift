//
//  CreateDMChatroomRequest.swift
//  CollabMates
//
//  Created by Pushpendra Singh on 07/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

public class CreateDMChatroomRequest: Encodable {
    
    var uuid: String?
    var memberId: Int?
    
    /// Initiate method
    private init() {}
    
    public static func builder() -> CreateDMChatroomRequest {
        return CreateDMChatroomRequest()
    }
    
    public func build() -> CreateDMChatroomRequest {
        return self
    }
    
    enum CodingKeys: String, CodingKey {
        case uuid,
             memberId = "member_id"
    }
    
    public func uuid(_ uuid: String) -> CreateDMChatroomRequest {
        self.uuid = uuid
        return self
    }
    
    public func memberId(_ memberId: Int) -> CreateDMChatroomRequest {
        self.memberId = memberId
        return self
    }
}
