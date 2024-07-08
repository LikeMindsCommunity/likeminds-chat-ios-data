//
//  CheckDMLimitResponse.swift
//  CollabMates
//
//  Created by Pushpendra Singh on 09/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

public struct CheckDMLimitResponse: Decodable {
    public let chatroomId: Int?
    public let isRequestDMLimitExceeded: Bool?
    public let newRequestDMTimestamp: Double?
    public let userDMLimit: DMLimitObject?
    
    public struct DMLimitObject: Decodable {
        public let state: Int?
        public let duration: String?
        public let numberInDuration: Int?
        
        enum CodingKeys: String, CodingKey {
            case state,
                 duration,
                 numberInDuration = "number_in_duration"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case chatroomId = "chatroom_id",
             userDMLimit = "user_dm_limit",
             newRequestDMTimestamp = "new_request_dm_timestamp",
             isRequestDMLimitExceeded = "is_request_dm_limit_exceeded"
    }
}
