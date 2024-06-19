//
//  CheckDMTabResponse.swift
//  CollabMates
//
//  Created by Pushpendra Singh on 10/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

public struct CheckDMTabResponse: Decodable {
    public let clicked, messaged, hideDMTab, isCM: Bool?
    public let unreadDMCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case clicked, messaged
        case isCM = "is_cm"
        case unreadDMCount = "unread_dm_count"
        case hideDMTab = "hide_dm_tab"
    }
}
