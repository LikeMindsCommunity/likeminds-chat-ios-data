//
//  _ChatroomType_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 21/12/23.
//

import Foundation

public enum ChatRequestState: Int, Codable, CaseIterableDefaultsLast {
    case unknown = -1
    case initiated = 0
    case approved = 1
    case rejected = 2
}

public enum ChatroomType: Int, Codable, CaseIterableDefaultsLast {
    case unknown = -1
    case normal = 0
    case introduction = 1 // introduction
    case event = 2
    case poll = 3
    case unverified = 5
    case publicEvent = 6
    case purpose = 7 // anouncement
    case introductions = 9 // introduction
    case directMessage = 10
    case chatRoomDateSectionHeader = 101
    case newUnseenChatRoomTitle = 11
    
    var value: String {
        switch self {
        case .unknown:
            return "unknown"
        case .normal:
            return "normal"
        case .introduction:
            return "intro"
        case .event:
            return "event"
        case .poll:
            return "poll"
        case .unverified:
            return "unverified"
        case .publicEvent:
            return "publicEvent"
        case .purpose:
            return "purpose"
        case .introductions:
            return "introduction_rooms"
        case .directMessage:
            return "direct message"
        case .chatRoomDateSectionHeader:
            return "chatRoomDateSectionHeader"
        case .newUnseenChatRoomTitle:
            return "newUnseenChatRoomTitle"
        }
    }
    
    var specialRoomValue: String? {
        switch self {
        case .introduction:
            return "Intro room"
        case .purpose:
            return "Announcement room"
        case .event,
                .publicEvent:
            return "Event room"
        case .poll:
            return "Poll room"
        default:
            return nil
        }
    }
}
