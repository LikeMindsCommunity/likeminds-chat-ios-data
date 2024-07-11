//
//  FetchDMFeedResponse.swift
//  CollabMates
//
//  Created by Pushpendra Singh on 09/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

public struct FetchDMFeedResponse: Decodable {
//    public let dmChatrooms: [ChatRoomMetaData]?
    public var totalPages, totalUnseenCount: Int?
    public enum CodingKeys: String, CodingKey {
//        case dmChatrooms = "dm_chatrooms"
        case totalPages = "total_pages"
        case totalUnseenCount = "total_unseen_count"
    }
}
