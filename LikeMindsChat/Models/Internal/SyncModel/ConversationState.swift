//
//  _ConversationState_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 21/12/23.
//

import Foundation

protocol CaseIterableDefaultsLast: Decodable & CaseIterable & RawRepresentable
where RawValue: Decodable, AllCases: BidirectionalCollection { }

extension CaseIterableDefaultsLast {
    init(from decoder: Decoder) throws {
        self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? Self.allCases.first!
    }
}

enum ConversationState: Int, Codable, CaseIterableDefaultsLast {
    
    case unknown = -1
    case normal = 0 // normal conversation
    case chatRoomHeader = 1 // conversationHeader
    case chatRoomFollowed = 2 // conversationFollow
    case chatRoomUnFollowed = 3  // conversationUnfollow
    case chatRoomCreater = 4 // conversationCreator
    case chatRoomEdited = 5 // conversationCommunityEdit
    case chatRoomJoined = 6 // conversationGuest
    case chatRoomAddParticipants = 7 // conversationAddParticipant
    case chatRoomLeaveSeperator = 8 // leaveConversation
    case chatRoomRemoveSeperator = 9 // removedFromConversation
    case microPoll = 10 // pollConversation
    case addAllMembers = 11 // addAllMembers
    case chatRoomCurrentTopic = 12 // set up topic of chatroom
    case directMessageMemberRemovedOrLeft = 13
    case directMessageCMRemoved = 14
    case directMessageMemberBecomesCMDisableChat = 15
    case directMessageCMBecomesMemberEnableChat = 16
    case directMessageMemberBecomesCMEnableChat = 17
    case directMessageMemberRequestRejected = 19
    case directMessageMemberRequestApproved = 20
}
