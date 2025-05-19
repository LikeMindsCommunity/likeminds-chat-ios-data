//
//  _ConversationState_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 21/12/23.
//

import Foundation

/// Protocol for case iterable enums with a default last case
protocol CaseIterableDefaultsLast: Codable & CaseIterable & RawRepresentable
where RawValue: Codable, AllCases: BidirectionalCollection {}

extension CaseIterableDefaultsLast {
  public init(from decoder: Decoder) throws {
    self =
      try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? Self.allCases
      .first!
  }
}

/// Represents the various states a conversation can be in within a chatroom.
///
/// This enum defines all possible states for conversations, including system messages,
/// user actions, and special conversation types like polls.
///
/// The raw value of each case corresponds to the server-side state identifier.
///
/// ## Available States
/// - unknown (-1): Unknown or undefined state
/// - normal (0): Regular conversation message
/// - chatRoomHeader (1): System message showing chatroom header information
/// - chatRoomFollowed (2): System message indicating a user followed the chatroom
/// - chatRoomUnFollowed (3): System message indicating a user unfollowed the chatroom
/// - chatRoomCreater (4): System message showing chatroom creator information
/// - chatRoomEdited (5): System message indicating chatroom settings were edited
/// - chatRoomJoined (6): System message indicating a user joined the chatroom
/// - chatRoomAddParticipants (7): System message showing added participants
/// - chatRoomLeaveSeperator (8): System message indicating a user left the chatroom
/// - chatRoomRemoveSeperator (9): System message indicating a user was removed
/// - microPoll (10): Represents a poll conversation
/// - addAllMembers (11): System message indicating all members were added
/// - chatRoomCurrentTopic (12): System message showing current chatroom topic
/// - directMessageMemberRemovedOrLeft (13): DM system message for member removal/leave
/// - directMessageCMRemoved (14): DM system message for community manager removal
/// - directMessageMemberBecomesCMDisableChat (15): DM message when member becomes CM, chat disabled
/// - directMessageCMBecomesMemberEnableChat (16): DM message when CM becomes member, chat enabled
/// - directMessageMemberBecomesCMEnableChat (17): DM message when member becomes CM, chat enabled
/// - directMessageMemberRequestRejected (19): DM message for rejected member request
/// - directMessageMemberRequestApproved (20): DM message for approved member request
/// - chatroomDataHeader (111): Special state for chatroom data header
/// - bubbleShimmer (-99): UI state for showing shimmer effect
public enum ConversationState: Int, Codable, CaseIterableDefaultsLast {

  /// Represents an unknown or undefined state (-1)
  case unknown = -1

  /// Regular conversation message (0)
  case normal = 0  // normal conversation

  /// System message showing chatroom header information (1)
  case firstConversation = 1  // conversationHeader

  /// System message indicating a user followed the chatroom (2)
  case memberJoinedOpenChatRoom = 2  // conversationFollow

  /// System message indicating a user unfollowed the chatroom (3)
  case memberLeftOpenChatRoom = 3  // conversationUnfollow

  /// System message showing chatroom creator information (4)
  case chatRoomCreater = 4  // conversationCreator

  /// System message indicating chatroom settings were edited (5)
  case chatRoomEdited = 5  // conversationCommunityEdit

  /// System message indicating a user joined the chatroom (6)
  case chatRoomJoined = 6  // conversationGuest

  /// System message showing added participants (7)
  case memberAddedToChatRoom = 7  // conversationAddParticipant

  /// System message indicating a user left the chatroom (8)
  case memberLeftSecretRoom = 8  // leaveConversation

  /// System message indicating a user was removed from the chatroom (9)
  case memberRemovedFromChatRoom = 9  // removedFromConversation

  /// Represents a poll conversation (10)
  case poll = 10  // pollConversation

  /// System message indicating all members were added (11)
  case allMembersAdded = 11  // addAllMembers

  /// System message showing current chatroom topic (12)
  case topicChanged = 12  // set up topic of chatroom

  /// System message for DM when member is removed or leaves (13)
  case directMessageMemberRemovedOrLeft = 13

  /// System message for DM when community manager is removed (14)
  case directMessageCMRemoved = 14

  /// System message for DM when member becomes CM and disables chat (15)
  case directMessageMemberBecomesCMDisableChat = 15

  /// System message for DM when CM becomes member and enables chat (16)
  case directMessageCMBecomesMemberEnableChat = 16

  /// System message for DM when member becomes CM and enables chat (17)
  case directMessageMemberBecomesCMEnableChat = 17

  /// System message for DM when member request is rejected (19)
  case directMessageMemberRequestRejected = 19

  /// System message for DM when member request is approved (20)
  case directMessageMemberRequestApproved = 20

  /// Special state for chatroom data header (111)
  case chatroomDataHeader = 111

  /// UI state for showing shimmer effect (-99)
  case bubbleShimmer = -99

  /// Checks if a given state value represents a poll conversation
  /// - Parameter stateValue: The state value to check
  /// - Returns: `true` if the state represents a poll, `false` otherwise
  public static func isPoll(stateValue: Int) -> Bool {
    poll.rawValue == stateValue
  }
}
