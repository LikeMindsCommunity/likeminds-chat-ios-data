//
//  Constant.swift
//  LikeMindsChat
//
//  Created by Augment on 08/07/24.
//

import Foundation

/// A singleton class that provides access to constants used throughout the SDK.
/// This includes API endpoints and parameter keys.
public final class Constant {
  /// The shared singleton instance of `Constant`.
  public static let shared = Constant()

  /// The endpoints singleton instance.
  public let paths = Paths.shared

  /// The keys singleton instance.
  public let keys = Keys.shared

  /// Private initializer to enforce singleton pattern.
  private init() {}
}

/// A singleton class that contains all API endpoints used in the SDK.
public final class Paths {
  /// The shared singleton instance of `Endpoints`.
  public static let shared = Paths()

  // MARK: - SDK APIs
  public let sdkInitiate = "sdk/initiate"
  public let userRefresh = "user/refresh"
  public let userDevicePush = "user/device/push"
  public let userLogout = "user/logout"
  public let userConfig = "user/config"
  public let sdkOnboarding = "sdk/onboarding"
  public let communityMemberHomeMeta = "community/member/home/meta"

  // MARK: - DM APIs
  public let homeDmMeta = "home/dm/meta"
  public let chatroomDm = "chatroom/dm"
  public let communityDmStatus = "community/dm/status"
  public let chatroomDmLimit = "chatroom/dm/limit"
  public let chatroomDmCreate = "chatroom/dm/create"
  public let chatroomDmRequest = "chatroom/dm/request"
  public let chatroomDmBlock = "chatroom/dm/block"

  // MARK: - Chatroom APIs
  public let chatroomSync = "chatroom/sync"
  public let chatroom = "chatroom"
  public let chatroomFollow = "chatroom/follow"
  public let chatroomParticipants = "chatroom/participants"
  public let chatroomMute = "chatroom/mute"
  public let chatroomMarkRead = "chatroom/mark_read"

  // MARK: - Conversation APIs
  public let conversationTopic = "conversation/topic"
  public let conversation = "conversation"
  public let conversationSync = "conversation/sync"
  public let conversationReaction = "conversation/reaction"
  public let conversationPoll = "conversation/poll"
  public let conversationPollSubmit = "conversation/poll/submit"
  public let conversationPollUsers = "conversation/poll/users"
  public let conversationSearch = "conversation/search"

  // MARK: - Community APIs
  public let communityFeed = "community/feed"
  public let communitySettingsContentDownload = "community/settings/content_download"
  public let communityMemberState = "community/member/state"
  public let communityMember = "community/member"
  public let communityMemberSearch = "community/member/search"
  public let communityTag = "community/tag"
  public let communityReport = "community/report"
  public let communityReportTag = "community/report/tag"
  public let communityConfigurations = "community/configurations"
  public let communityChatbot = "community/chatbot"

  // MARK: - Helper APIs
  public let helperUrl = "helper/url"

  // MARK: - Search APIs
  public let chatroomSearch = "chatroom/search"

  // MARK: - Channel APIs
  public let channelInvites = "channel/invites"
  public let channelInvite = "channel/invite"

  /// Private initializer to enforce singleton pattern.
  private init() {}
}

/// A singleton class that contains all parameter keys used in API requests.
public final class Keys {
  /// The shared singleton instance of `Keys`.
  public static let shared = Keys()

  // MARK: - Common Query Parameters
  public let page = "page"
  public let pageSize = "page_size"
  public let search = "search"
  public let searchType = "search_type"
  public let isLocalDb = "is_local_db"

  // MARK: - Chatroom Parameters
  public let chatroomId = "chatroom_id"
  public let chatroomTypes = "chatroom_types"
  public let followStatus = "follow_status"
  public let isSecret = "is_secret"
  public let participantName = "participant_name"

  // MARK: - Conversation Parameters
  public let minTimestamp = "min_timestamp"
  public let maxTimestamp = "max_timestamp"
  public let conversationId = "conversation_id"
  public let pollId = "poll_id"

  // MARK: - DM Parameters
  public let reqFrom = "req_from"
  public let uuid = "uuid"

  // MARK: - Community Parameters
  public let orderType = "order_type"
  public let pinned = "pinned"
  public let memberState = "member_state"
  public let memberStates = "member_states"
  public let filterMemberRoles = "filter_member_roles"
  public let excludeSelfUser = "exclude_self_user"
  public let searchName = "search_name"
  public let type = "type"

  // MARK: - Channel Parameters
  public let channelType = "channel_type"
  public let channelId = "channel_id"
  public let inviteStatus = "invite_status"

  // MARK: - Helper Parameters
  public let url = "url"

  /// Private initializer to enforce singleton pattern.
  private init() {}
}
