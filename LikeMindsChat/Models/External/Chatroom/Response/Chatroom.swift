//
//  Chatroom.swift
//  RealmRestSync
//
//  Created by Pushpendra Singh on 19/12/23.
//  Copyright © 2023 LikeMinds. All rights reserved.
//

import Foundation

/// Represents a chatroom entity in the system.
///
/// This class encapsulates various properties related to a chatroom including its title, state,
/// participants, and additional metadata. It conforms to `Decodable` to support JSON decoding.
public class Chatroom: Decodable {

    /// The member associated with the chatroom.
    public private(set) var member: Member?
    /// The unique identifier of the chatroom.
    public private(set) var id: String = ""
    /// The title of the chatroom.
    public private(set) var title: String = ""
    /// The creation date of the chatroom in string format.
    public private(set) var createdAt: String?
    /// The answer text or description for the chatroom.
    public private(set) var answerText: String?
    /// The current state of the chatroom.
    public private(set) var state: Int = 0
    /// The number of unseen messages in the chatroom.
    public private(set) var unseenCount: Int?
    /// The URL to share the chatroom.
    public private(set) var shareUrl: String?
    /// The identifier of the community this chatroom belongs to.
    public private(set) var communityId: String?
    /// The name of the community.
    public private(set) var communityName: String?
    /// The type of the chatroom.
    public private(set) var type: ChatroomType?
    /// Additional information about the chatroom.
    public private(set) var about: String?
    /// The header information of the chatroom.
    public private(set) var header: String?
    /// Flag to indicate if the follow telescope option should be shown.
    public private(set) var showFollowTelescope: Bool?
    /// Flag to indicate if the follow auto tag option should be shown.
    public private(set) var showFollowAutoTag: Bool?
    /// The card creation time.
    public private(set) var cardCreationTime: String?
    /// The count of participants in the chatroom.
    public private(set) var participantsCount: Int?
    /// The total number of responses.
    public private(set) var totalResponseCount: Int = 0
    /// Mute status of the chatroom.
    public private(set) var muteStatus: Bool?
    /// Follow status of the chatroom.
    public var followStatus: Bool?
    /// Indicates whether the chatroom has been named.
    public private(set) var hasBeenNamed: Bool?
    /// Indicates whether the chatroom has reactions.
    public private(set) var hasReactions: Bool?
    /// The date string associated with the chatroom.
    public private(set) var date: String?
    /// Flag indicating if the chatroom is tagged.
    public private(set) var isTagged: Bool?
    /// Flag indicating if the chatroom is pending.
    public private(set) var isPending: Bool?
    /// Flag indicating if the chatroom is pinned.
    public private(set) var isPinned: Bool?
    /// Flag indicating if the chatroom is deleted.
    public private(set) var isDeleted: Bool?
    /// The identifier of the user who created the chatroom.
    public private(set) var userId: String?
    /// The identifier of the user who deleted the chatroom.
    public private(set) var deletedBy: String?
    /// The member object representing the user who deleted the chatroom.
    public private(set) var deletedByMember: Member?
    /// The timestamp when the chatroom was last updated.
    public private(set) var updatedAt: Int?
    /// The identifier of the last seen conversation.
    public private(set) var lastSeenConversationId: String?
    /// The identifier of the last conversation.
    public private(set) var lastConversationId: String?
    /// The epoch date of the chatroom.
    public private(set) var dateEpoch: Int?
    /// Flag indicating if the chatroom is secret.
    public private(set) var isSecret: Bool?
    /// Participants of the secret chatroom.
    public private(set) var secretChatroomParticipants: [Int]?
    /// Flag indicating if the user has left the secret chatroom.
    public private(set) var secretChatroomLeft: Bool?
    /// Reactions in the chatroom.
    public private(set) var reactions: [Reaction]?
    /// The topic identifier.
    public private(set) var topicId: String?
    /// The conversation representing the topic.
    public private(set) var topic: Conversation?
    /// Flag indicating if auto-follow is done.
    public private(set) var autoFollowDone: Bool?
    /// Flag indicating if the chatroom is edited.
    public private(set) var isEdited: Bool?
    /// The access level of the chatroom.
    public private(set) var access: Int?
    /// Flag indicating if a member can message in the chatroom.
    public private(set) var memberCanMessage: Bool?
    /// Cohorts associated with the chatroom.
    public private(set) var cohorts: [Cohort]?
    /// Flag indicating if the chatroom is externally seen.
    public private(set) var externalSeen: Bool?
    /// Count of unread conversations.
    public private(set) var unreadConversationCount: Int?
    /// URL for the chatroom image.
    public private(set) var chatroomImageUrl: String?
    /// Flag indicating access without subscription.
    public private(set) var accessWithoutSubscription: Bool?
    /// The last conversation object.
    public private(set) var lastConversation: Conversation?
    /// The last seen conversation object.
    public private(set) var lastSeenConversation: Conversation?
    /// A draft conversation text.
    public private(set) var draftConversation: String?
    /// Flag indicating if the conversation is stored.
    public private(set) var isConversationStored: Bool = false
    /// Flag indicating if the chatroom is a draft.
    public private(set) var isDraft: Bool?
    /// Total count of all responses.
    public private(set) var totalAllResponseCount: Int?
    /// Timestamp for when a chat request was created.
    public private(set) var chatRequestCreatedAt: Int?
    /// The state of the chat request.
    public private(set) var chatRequestState: ChatRequestState?
    /// The identifier of the user who requested the chat.
    public private(set) var chatRequestedById: String?
    /// The member who requested the chat.
    public private(set) var chatRequestedByUser: Member?
    /// The identifier of the user with whom the chat is held.
    public private(set) var chatWithUserId: String?
    /// Flag indicating if the chatroom is private.
    public private(set) var isPrivate: Bool?
    /// Flag indicating if the member is private.
    public private(set) var isPrivateMember: Bool?
    /// The user with whom the chat is held.
    public private(set) var chatWithUser: Member?

    /**
     Coding keys to map JSON keys to the corresponding properties of `Chatroom`.

     These keys are used during decoding to map JSON data to the properties of this class.
     */
    enum CodingKeys: String, CodingKey {
        case member
        case id
        case title
        case createdAt = "created_at"
        case answerText = "answer_text"
        case state
        case unseenCount = "unseen_count"
        case shareUrl = "share_url"
        case communityId = "community_id"
        case communityName = "community_name"
        case type
        case about
        case header
        case showFollowTelescope = "show_follow_telescope"
        case showFollowAutoTag = "show_follow_auto_tag"
        case cardCreationTime = "card_creation_time"
        case participantsCount = "participants_count"
        case totalResponseCount = "total_response_count"
        case muteStatus = "mute_status"
        case followStatus = "follow_status"
        case hasBeenNamed = "has_been_named"
        case hasReactions = "has_reactions"
        case date
        case isTagged = "is_tagged"
        case isPending = "is_pending"
        case isPinned = "is_pinned"
        case isDeleted = "is_deleted"
        case userId = "user_id"
        case deletedBy = "deleted_by_user_id"
        case deletedByMember = "deleted_by_member"
        case updatedAt = "updated_at"
        case lastSeenConversationId = "last_seen_conversation_id"
        case lastConversationId = "last_conversation_id"
        case dateEpoch = "date_epoch"
        case isSecret = "is_secret"
        case secretChatroomParticipants = "secret_chatroom_participants"
        case secretChatroomLeft = "secret_chatroom_left"
        case reactions
        case topicId = "topic_id"
        case topic
        case autoFollowDone = "auto_follow_done"
        case isEdited = "is_edited"
        case access
        case memberCanMessage = "member_can_message"
        case cohorts
        case externalSeen = "external_seen"
        case unreadConversationCount = "conversations_unread"
        case chatroomImageUrl = "chatroom_image_url"
        case accessWithoutSubscription = "access_without_subscription"
        case chatRequestCreatedAt = "chat_request_created_at"
        case chatRequestState = "chat_request_state"
        case chatRequestedById = "chat_requested_by_id"
        case chatWithUserId = "chatroom_with_user_id"
        case chatWithUser = "chat_with_user"
        case isPrivate = "is_private"
        case isPrivateMember = "is_private_member"
        case dmMessage = "dm_message"
        case shareLink = "share_link"
    }

    /**
     Initializes a new `Chatroom` instance by decoding from the given decoder.

     - Parameter decoder: The decoder to read data from.
     - Throws: An error if any required values are missing or if data is invalid.
     */
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        member = try container.decodeIfPresent(Member.self, forKey: .member)
        id = try container.decodeIntToStringIfPresent(forKey: .id) ?? ""
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        createdAt = try container.decodeIfPresent(
            String.self, forKey: .createdAt)
        answerText = try container.decodeIfPresent(
            String.self, forKey: .answerText)
        state = try container.decodeIfPresent(Int.self, forKey: .state) ?? 0
        unseenCount = try container.decodeIfPresent(
            Int.self, forKey: .unseenCount)
        shareUrl = try container.decodeIfPresent(String.self, forKey: .shareUrl)
        communityId = try container.decodeIntToStringIfPresent(
            forKey: .communityId)
        communityName = try container.decodeIfPresent(
            String.self, forKey: .communityName)
        type = try container.decodeIfPresent(ChatroomType.self, forKey: .type)
        about = try container.decodeIfPresent(String.self, forKey: .about)
        header = try container.decodeIfPresent(String.self, forKey: .header)
        showFollowTelescope = try container.decodeIfPresent(
            Bool.self, forKey: .showFollowTelescope)
        showFollowAutoTag = try container.decodeIfPresent(
            Bool.self, forKey: .showFollowAutoTag)
        cardCreationTime = try container.decodeIfPresent(
            String.self, forKey: .cardCreationTime)
        participantsCount = try container.decodeIfPresent(
            Int.self, forKey: .participantsCount)
        totalResponseCount =
            try container.decodeIfPresent(Int.self, forKey: .totalResponseCount)
            ?? 0
        muteStatus = try container.decodeIfPresent(
            Bool.self, forKey: .muteStatus)
        followStatus = try container.decodeIfPresent(
            Bool.self, forKey: .followStatus)
        hasBeenNamed = try container.decodeIfPresent(
            Bool.self, forKey: .hasBeenNamed)
        hasReactions = try container.decodeIfPresent(
            Bool.self, forKey: .hasReactions)
        date = try container.decodeIfPresent(String.self, forKey: .date)
        isTagged = try container.decodeIfPresent(Bool.self, forKey: .isTagged)
        isPending = try container.decodeIfPresent(Bool.self, forKey: .isPending)
        isPinned = try container.decodeIfPresent(Bool.self, forKey: .isPinned)
        isDeleted = try container.decodeIfPresent(Bool.self, forKey: .isDeleted)
        userId = try container.decodeIntToStringIfPresent(forKey: .userId)
        deletedBy = try container.decodeIntToStringIfPresent(forKey: .deletedBy)
        deletedByMember = try container.decodeIfPresent(
            Member.self, forKey: .deletedByMember)
        updatedAt = try container.decodeIfPresent(Int.self, forKey: .updatedAt)
        lastSeenConversationId = try container.decodeIntToStringIfPresent(
            forKey: .lastSeenConversationId)
        lastConversationId = try container.decodeIntToStringIfPresent(
            forKey: .lastConversationId)
        dateEpoch = try container.decodeIfPresent(Int.self, forKey: .dateEpoch)
        isSecret = try container.decodeIfPresent(Bool.self, forKey: .isSecret)
        secretChatroomParticipants = try container.decodeIfPresent(
            [Int].self, forKey: .secretChatroomParticipants)
        secretChatroomLeft = try container.decodeIfPresent(
            Bool.self, forKey: .secretChatroomLeft)
        reactions = try container.decodeIfPresent(
            [Reaction].self, forKey: .reactions)
        topicId = try container.decodeIntToStringIfPresent(forKey: .topicId)
        topic = try container.decodeIfPresent(Conversation.self, forKey: .topic)
        autoFollowDone = try container.decodeIfPresent(
            Bool.self, forKey: .autoFollowDone)
        isEdited = try container.decodeIfPresent(Bool.self, forKey: .isEdited)
        access = try container.decodeIfPresent(Int.self, forKey: .access)
        memberCanMessage = try container.decodeIfPresent(
            Bool.self, forKey: .memberCanMessage)
        cohorts = try container.decodeIfPresent([Cohort].self, forKey: .cohorts)
        externalSeen = try container.decodeIfPresent(
            Bool.self, forKey: .externalSeen)
        unreadConversationCount = try container.decodeIfPresent(
            Int.self, forKey: .unreadConversationCount)
        chatroomImageUrl = try container.decodeIfPresent(
            String.self, forKey: .chatroomImageUrl)
        accessWithoutSubscription = try container.decodeIfPresent(
            Bool.self, forKey: .accessWithoutSubscription)
        chatRequestCreatedAt = try container.decodeIfPresent(
            Int.self, forKey: .chatRequestCreatedAt)
        chatRequestState = try container.decodeIfPresent(
            ChatRequestState.self, forKey: .chatRequestState)
        chatRequestedById = try container.decodeIntToStringIfPresent(
            forKey: .chatRequestedById)
        chatWithUserId = try container.decodeIntToStringIfPresent(
            forKey: .chatWithUserId)
        chatWithUser = try container.decodeIfPresent(
            Member.self, forKey: .chatWithUser)
        isPrivate = try container.decodeIfPresent(Bool.self, forKey: .isPrivate)
        isPrivateMember = try container.decodeIfPresent(
            Bool.self, forKey: .isPrivateMember)
    }

    /**
     Initializes a new, empty `Chatroom` instance.

     This initializer creates a new instance of `Chatroom` with default values.
     */
    public init() {}

    // MARK: - Builder Pattern

    /**
     A builder class for constructing `Chatroom` instances.

     Provides a fluent interface to set various properties on a `Chatroom` and build the final object.
     */
    public class Builder {

        /// The `Chatroom` instance being built.
        private(set) var chatroom: Chatroom

        /**
         Initializes a new `Builder` with an empty `Chatroom` instance.
         */
        public init() {
            chatroom = Chatroom()
        }

        /**
         Sets the member associated with the chatroom.

         - Parameter member: The member object.
         - Returns: The current `Builder` instance for chaining.
         */
        public func member(_ member: Member?) -> Builder {
            chatroom.member = member
            return self
        }

        /**
         Sets the unique identifier for the chatroom.

         - Parameter id: The chatroom ID.
         - Returns: The current `Builder` instance for chaining.
         */
        public func id(_ id: String) -> Builder {
            chatroom.id = id
            return self
        }

        /**
         Sets the title of the chatroom.

         - Parameter title: The display title.
         - Returns: The current `Builder` instance for chaining.
         */
        public func title(_ title: String) -> Builder {
            chatroom.title = title
            return self
        }

        /**
         Sets the creation date of the chatroom.

         - Parameter createdAt: The creation date as a string.
         - Returns: The current `Builder` instance for chaining.
         */
        public func createdAt(_ createdAt: String?) -> Builder {
            chatroom.createdAt = createdAt
            return self
        }

        /**
         Sets the answer text or description for the chatroom.

         - Parameter answerText: The answer text.
         - Returns: The current `Builder` instance for chaining.
         */
        public func answerText(_ answerText: String?) -> Builder {
            chatroom.answerText = answerText
            return self
        }

        /**
         Sets the state of the chatroom.

         - Parameter state: The state as an integer.
         - Returns: The current `Builder` instance for chaining.
         */
        public func state(_ state: Int) -> Builder {
            chatroom.state = state
            return self
        }

        /**
         Sets the unseen message count for the chatroom.

         - Parameter unseenCount: The count of unseen messages.
         - Returns: The current `Builder` instance for chaining.
         */
        public func unseenCount(_ unseenCount: Int?) -> Builder {
            chatroom.unseenCount = unseenCount
            return self
        }

        /**
         Sets the share URL for the chatroom.

         - Parameter shareUrl: The URL to share the chatroom.
         - Returns: The current `Builder` instance for chaining.
         */
        public func shareUrl(_ shareUrl: String?) -> Builder {
            chatroom.shareUrl = shareUrl
            return self
        }

        /**
         Sets the community identifier for the chatroom.

         - Parameter communityId: The community ID.
         - Returns: The current `Builder` instance for chaining.
         */
        public func communityId(_ communityId: String?) -> Builder {
            chatroom.communityId = communityId
            return self
        }

        /**
         Sets the community name for the chatroom.

         - Parameter communityName: The community name.
         - Returns: The current `Builder` instance for chaining.
         */
        public func communityName(_ communityName: String?) -> Builder {
            chatroom.communityName = communityName
            return self
        }

        /**
         Sets the chatroom type using an integer raw value.

         - Parameter type: The raw value for `ChatroomType`.
         - Returns: The current `Builder` instance for chaining.
         */
        public func type(_ type: Int?) -> Builder {
            guard let type else { return self }
            chatroom.type = ChatroomType(rawValue: type)
            return self
        }

        /**
         Sets additional information about the chatroom.

         - Parameter about: A string containing additional details.
         - Returns: The current `Builder` instance for chaining.
         */
        public func about(_ about: String?) -> Builder {
            chatroom.about = about
            return self
        }

        /**
         Sets the header information of the chatroom.

         - Parameter header: The header text.
         - Returns: The current `Builder` instance for chaining.
         */
        public func header(_ header: String?) -> Builder {
            chatroom.header = header
            return self
        }

        /**
         Sets the flag to show follow telescope.

         - Parameter showFollowTelescope: A Boolean indicating if follow telescope should be shown.
         - Returns: The current `Builder` instance for chaining.
         */
        public func showFollowTelescope(_ showFollowTelescope: Bool?) -> Builder
        {
            chatroom.showFollowTelescope = showFollowTelescope
            return self
        }

        /**
         Sets the flag to show follow auto tag.

         - Parameter showFollowAutoTag: A Boolean indicating if follow auto tag should be shown.
         - Returns: The current `Builder` instance for chaining.
         */
        public func showFollowAutoTag(_ showFollowAutoTag: Bool?) -> Builder {
            chatroom.showFollowAutoTag = showFollowAutoTag
            return self
        }

        /**
         Sets the card creation time for the chatroom.

         - Parameter cardCreationTime: The card creation time as a string.
         - Returns: The current `Builder` instance for chaining.
         */
        public func cardCreationTime(_ cardCreationTime: String?) -> Builder {
            chatroom.cardCreationTime = cardCreationTime
            return self
        }

        /**
         Sets the participant count for the chatroom.

         - Parameter participantsCount: The number of participants.
         - Returns: The current `Builder` instance for chaining.
         */
        public func participantsCount(_ participantsCount: Int?) -> Builder {
            chatroom.participantsCount = participantsCount
            return self
        }

        /**
         Sets the total response count for the chatroom.

         - Parameter totalResponseCount: The total number of responses.
         - Returns: The current `Builder` instance for chaining.
         */
        public func totalResponseCount(_ totalResponseCount: Int) -> Builder {
            chatroom.totalResponseCount = totalResponseCount
            return self
        }

        /**
         Sets the mute status of the chatroom.

         - Parameter muteStatus: A Boolean indicating the mute status.
         - Returns: The current `Builder` instance for chaining.
         */
        public func muteStatus(_ muteStatus: Bool?) -> Builder {
            chatroom.muteStatus = muteStatus
            return self
        }

        /**
         Sets the follow status of the chatroom.

         - Parameter followStatus: A Boolean indicating if the chatroom is followed.
         - Returns: The current `Builder` instance for chaining.
         */
        public func followStatus(_ followStatus: Bool?) -> Builder {
            chatroom.followStatus = followStatus
            return self
        }

        /**
         Sets the flag indicating if the chatroom has been named.

         - Parameter hasBeenNamed: A Boolean indicating if the chatroom has been named.
         - Returns: The current `Builder` instance for chaining.
         */
        public func hasBeenNamed(_ hasBeenNamed: Bool?) -> Builder {
            chatroom.hasBeenNamed = hasBeenNamed
            return self
        }

        /**
         Sets the flag indicating if the chatroom has reactions.

         - Parameter hasReactions: A Boolean indicating if the chatroom has reactions.
         - Returns: The current `Builder` instance for chaining.
         */
        public func hasReactions(_ hasReactions: Bool?) -> Builder {
            chatroom.hasReactions = hasReactions
            return self
        }

        /**
         Sets the date associated with the chatroom.

         - Parameter date: The date as a string.
         - Returns: The current `Builder` instance for chaining.
         */
        public func date(_ date: String?) -> Builder {
            chatroom.date = date
            return self
        }

        /**
         Sets the flag indicating if the chatroom is tagged.

         - Parameter isTagged: A Boolean indicating if the chatroom is tagged.
         - Returns: The current `Builder` instance for chaining.
         */
        public func isTagged(_ isTagged: Bool?) -> Builder {
            chatroom.isTagged = isTagged
            return self
        }

        /**
         Sets the flag indicating if the chatroom is pending.

         - Parameter isPending: A Boolean indicating if the chatroom is pending.
         - Returns: The current `Builder` instance for chaining.
         */
        public func isPending(_ isPending: Bool?) -> Builder {
            chatroom.isPending = isPending
            return self
        }

        /**
         Sets the flag indicating if the chatroom is pinned.

         - Parameter isPinned: A Boolean indicating if the chatroom is pinned.
         - Returns: The current `Builder` instance for chaining.
         */
        public func isPinned(_ isPinned: Bool?) -> Builder {
            chatroom.isPinned = isPinned
            return self
        }

        /**
         Sets the flag indicating if the chatroom is deleted.

         - Parameter isDeleted: A Boolean indicating if the chatroom is deleted.
         - Returns: The current `Builder` instance for chaining.
         */
        public func isDeleted(_ isDeleted: Bool?) -> Builder {
            chatroom.isDeleted = isDeleted
            return self
        }

        /**
         Sets the user identifier for the chatroom.

         - Parameter userId: The user ID.
         - Returns: The current `Builder` instance for chaining.
         */
        public func userId(_ userId: String?) -> Builder {
            chatroom.userId = userId
            return self
        }

        /**
         Sets the identifier of the user who deleted the chatroom.

         - Parameter deletedBy: The user ID who deleted the chatroom.
         - Returns: The current `Builder` instance for chaining.
         */
        public func deletedBy(_ deletedBy: String?) -> Builder {
            chatroom.deletedBy = deletedBy
            return self
        }

        /**
         Sets the member who deleted the chatroom.

         - Parameter deletedByMember: The member object.
         - Returns: The current `Builder` instance for chaining.
         */
        public func deletedByMember(_ deletedByMember: Member?) -> Builder {
            chatroom.deletedByMember = deletedByMember
            return self
        }

        /**
         Sets the last updated timestamp for the chatroom.

         - Parameter updatedAt: The timestamp as an integer.
         - Returns: The current `Builder` instance for chaining.
         */
        public func updatedAt(_ updatedAt: Int?) -> Builder {
            chatroom.updatedAt = updatedAt
            return self
        }

        /**
         Sets the identifier of the last seen conversation.

         - Parameter lastSeenConversationId: The conversation ID as a string.
         - Returns: The current `Builder` instance for chaining.
         */
        public func lastSeenConversationId(_ lastSeenConversationId: String?)
            -> Builder
        {
            chatroom.lastSeenConversationId = lastSeenConversationId
            return self
        }

        /**
         Sets the identifier of the last conversation.

         - Parameter lastConversationId: The conversation ID as a string.
         - Returns: The current `Builder` instance for chaining.
         */
        public func lastConversationId(_ lastConversationId: String?) -> Builder
        {
            chatroom.lastConversationId = lastConversationId
            return self
        }

        /**
         Sets the epoch date for the chatroom.

         - Parameter dateEpoch: The epoch date as an integer.
         - Returns: The current `Builder` instance for chaining.
         */
        public func dateEpoch(_ dateEpoch: Int?) -> Builder {
            chatroom.dateEpoch = dateEpoch
            return self
        }

        /**
         Sets the secret flag for the chatroom.

         - Parameter isSecret: A Boolean indicating if the chatroom is secret.
         - Returns: The current `Builder` instance for chaining.
         */
        public func isSecret(_ isSecret: Bool?) -> Builder {
            chatroom.isSecret = isSecret
            return self
        }

        /**
         Sets the secret chatroom participants.

         - Parameter secretChatroomParticipants: An array of participant identifiers.
         - Returns: The current `Builder` instance for chaining.
         */
        public func secretChatroomParticipants(
            _ secretChatroomParticipants: [Int]?
        ) -> Builder {
            chatroom.secretChatroomParticipants = secretChatroomParticipants
            return self
        }

        /**
         Sets the flag indicating if a participant has left the secret chatroom.

         - Parameter secretChatroomLeft: A Boolean flag.
         - Returns: The current `Builder` instance for chaining.
         */
        public func secretChatroomLeft(_ secretChatroomLeft: Bool?) -> Builder {
            chatroom.secretChatroomLeft = secretChatroomLeft
            return self
        }

        /**
         Sets the reactions for the chatroom.

         - Parameter reactions: An array of `Reaction` objects.
         - Returns: The current `Builder` instance for chaining.
         */
        public func reactions(_ reactions: [Reaction]?) -> Builder {
            chatroom.reactions = reactions
            return self
        }

        /**
         Sets the topic identifier for the chatroom.

         - Parameter topicId: The topic ID as a string.
         - Returns: The current `Builder` instance for chaining.
         */
        public func topicId(_ topicId: String?) -> Builder {
            chatroom.topicId = topicId
            return self
        }

        /**
         Sets the topic conversation for the chatroom.

         - Parameter topic: A `Conversation` object representing the topic.
         - Returns: The current `Builder` instance for chaining.
         */
        public func topic(_ topic: Conversation?) -> Builder {
            chatroom.topic = topic
            return self
        }

        /**
         Sets the auto follow flag for the chatroom.

         - Parameter autoFollowDone: A Boolean indicating if auto follow is done.
         - Returns: The current `Builder` instance for chaining.
         */
        public func autoFollowDone(_ autoFollowDone: Bool?) -> Builder {
            chatroom.autoFollowDone = autoFollowDone
            return self
        }

        /**
         Sets the edited flag for the chatroom.

         - Parameter isEdited: A Boolean indicating if the chatroom is edited.
         - Returns: The current `Builder` instance for chaining.
         */
        public func isEdited(_ isEdited: Bool?) -> Builder {
            chatroom.isEdited = isEdited
            return self
        }

        /**
         Sets the access level for the chatroom.

         - Parameter access: The access level as an integer.
         - Returns: The current `Builder` instance for chaining.
         */
        public func access(_ access: Int?) -> Builder {
            chatroom.access = access
            return self
        }

        /**
         Sets the flag indicating if a member can send messages in the chatroom.

         - Parameter memberCanMessage: A Boolean flag.
         - Returns: The current `Builder` instance for chaining.
         */
        public func memberCanMessage(_ memberCanMessage: Bool?) -> Builder {
            chatroom.memberCanMessage = memberCanMessage
            return self
        }

        /**
         Sets the cohorts associated with the chatroom.

         - Parameter cohorts: An array of `Cohort` objects.
         - Returns: The current `Builder` instance for chaining.
         */
        public func cohorts(_ cohorts: [Cohort]?) -> Builder {
            chatroom.cohorts = cohorts
            return self
        }

        /**
         Sets the external seen flag for the chatroom.

         - Parameter externalSeen: A Boolean indicating if the chatroom is externally seen.
         - Returns: The current `Builder` instance for chaining.
         */
        public func externalSeen(_ externalSeen: Bool?) -> Builder {
            chatroom.externalSeen = externalSeen
            return self
        }

        /**
         Sets the unread conversation count for the chatroom.

         - Parameter unreadConversationCount: The count of unread conversations.
         - Returns: The current `Builder` instance for chaining.
         */
        public func unreadConversationCount(_ unreadConversationCount: Int?)
            -> Builder
        {
            chatroom.unreadConversationCount = unreadConversationCount
            return self
        }

        /**
         Sets the chatroom image URL.

         - Parameter chatroomImageUrl: The URL string of the chatroom image.
         - Returns: The current `Builder` instance for chaining.
         */
        public func chatroomImageUrl(_ chatroomImageUrl: String?) -> Builder {
            chatroom.chatroomImageUrl = chatroomImageUrl
            return self
        }

        /**
         Sets the flag indicating access without subscription.

         - Parameter accessWithoutSubscription: A Boolean flag.
         - Returns: The current `Builder` instance for chaining.
         */
        public func accessWithoutSubscription(
            _ accessWithoutSubscription: Bool?
        ) -> Builder {
            chatroom.accessWithoutSubscription = accessWithoutSubscription
            return self
        }

        /**
         Sets the last conversation for the chatroom.

         - Parameter lastConversation: A `Conversation` object representing the last conversation.
         - Returns: The current `Builder` instance for chaining.
         */
        public func lastConversation(_ lastConversation: Conversation?)
            -> Builder
        {
            chatroom.lastConversation = lastConversation
            return self
        }

        /**
         Sets the last seen conversation for the chatroom.

         - Parameter lastSeenConversation: A `Conversation` object representing the last seen conversation.
         - Returns: The current `Builder` instance for chaining.
         */
        public func lastSeenConversation(_ lastSeenConversation: Conversation?)
            -> Builder
        {
            chatroom.lastSeenConversation = lastSeenConversation
            return self
        }

        /**
         Sets the draft conversation text.

         - Parameter draftConversation: A string representing the draft conversation.
         - Returns: The current `Builder` instance for chaining.
         */
        public func draftConversation(_ draftConversation: String?) -> Builder {
            chatroom.draftConversation = draftConversation
            return self
        }

        /**
         Sets the flag indicating if the conversation is stored.

         - Parameter isConversationStored: A Boolean flag.
         - Returns: The current `Builder` instance for chaining.
         */
        public func isConversationStored(_ isConversationStored: Bool)
            -> Builder
        {
            chatroom.isConversationStored = isConversationStored
            return self
        }

        /**
         Sets the draft flag for the chatroom.

         - Parameter isDraft: A Boolean indicating if the chatroom is a draft.
         - Returns: The current `Builder` instance for chaining.
         */
        public func isDraft(_ isDraft: Bool?) -> Builder {
            chatroom.isDraft = isDraft
            return self
        }

        /**
         Sets the total count of all responses.

         - Parameter totalAllResponseCount: The total number of responses.
         - Returns: The current `Builder` instance for chaining.
         */
        public func totalAllResponseCount(_ totalAllResponseCount: Int?)
            -> Builder
        {
            chatroom.totalAllResponseCount = totalAllResponseCount
            return self
        }

        /**
         Sets the chat request creation time.

         - Parameter chatRequestCreatedAt: The timestamp when the chat request was created.
         - Returns: The current `Builder` instance for chaining.
         */
        public func chatRequestCreatedAt(_ chatRequestCreatedAt: Int?)
            -> Builder
        {
            chatroom.chatRequestCreatedAt = chatRequestCreatedAt
            return self
        }

        /**
         Sets the state of the chat request.

         - Parameter chatRequestState: The raw state value of the chat request.
         - Returns: The current `Builder` instance for chaining.
         */
        public func chatRequestState(_ chatRequestState: Int?) -> Builder {
            guard let state = chatRequestState else { return self }
            chatroom.chatRequestState = ChatRequestState(rawValue: state)
            return self
        }

        /**
         Sets the identifier of the user who requested the chat.

         - Parameter chatRequestedById: The user ID.
         - Returns: The current `Builder` instance for chaining.
         */
        public func chatRequestedById(_ chatRequestedById: String?) -> Builder {
            chatroom.chatRequestedById = chatRequestedById
            return self
        }

        /**
         Sets the member who requested the chat.

         - Parameter chatRequestedByUser: A `Member` object.
         - Returns: The current `Builder` instance for chaining.
         */
        public func chatRequestedByUser(_ chatRequestedByUser: Member?)
            -> Builder
        {
            chatroom.chatRequestedByUser = chatRequestedByUser
            return self
        }

        /**
         Sets the identifier of the user with whom the chat is held.

         - Parameter chatWithUserId: The user ID.
         - Returns: The current `Builder` instance for chaining.
         */
        public func chatWithUserId(_ chatWithUserId: String?) -> Builder {
            chatroom.chatWithUserId = chatWithUserId
            return self
        }

        /**
         Sets the flag indicating if the chatroom is private.

         - Parameter isPrivate: A Boolean flag.
         - Returns: The current `Builder` instance for chaining.
         */
        public func isPrivate(_ isPrivate: Bool?) -> Builder {
            chatroom.isPrivate = isPrivate
            return self
        }

        /**
         Sets the flag indicating if the member is private.

         - Parameter isPrivateMember: A Boolean flag.
         - Returns: The current `Builder` instance for chaining.
         */
        public func isPrivateMember(_ isPrivateMember: Bool?) -> Builder {
            chatroom.isPrivateMember = isPrivateMember
            return self
        }

        /**
         Sets the user with whom the chat is held.

         - Parameter chatWithUser: A `Member` object.
         - Returns: The current `Builder` instance for chaining.
         */
        public func chatWithUser(_ chatWithUser: Member?) -> Builder {
            chatroom.chatWithUser = chatWithUser
            return self
        }

        /**
         Builds and returns the configured `Chatroom` instance.

         - Returns: A `Chatroom` object with all the set properties.
         */
        public func build() -> Chatroom {
            return chatroom
        }
    }

    /**
     Returns a new builder pre-populated with the current chatroom's properties.

     This allows modification of an existing `Chatroom` instance using the builder pattern.

     - Returns: A `Builder` instance with the current chatroom values.
     */
    public func toBuilder() -> Builder {
        return Builder()
            .member(member)
            .id(id)
            .title(title)
            .createdAt(createdAt)
            .answerText(answerText)
            .state(state)
            .unseenCount(unseenCount)
            .shareUrl(shareUrl)
            .communityId(communityId)
            .communityName(communityName)
            .type(type?.rawValue)
            .about(about)
            .header(header)
            .showFollowTelescope(showFollowTelescope)
            .showFollowAutoTag(showFollowAutoTag)
            .cardCreationTime(cardCreationTime)
            .participantsCount(participantsCount)
            .totalResponseCount(totalResponseCount)
            .muteStatus(muteStatus)
            .followStatus(followStatus)
            .hasBeenNamed(hasBeenNamed)
            .hasReactions(hasReactions)
            .date(date)
            .isTagged(isTagged)
            .isPending(isPending)
            .isPinned(isPinned)
            .isDeleted(isDeleted)
            .userId(userId)
            .deletedBy(deletedBy)
            .deletedByMember(deletedByMember)
            .updatedAt(updatedAt)
            .lastSeenConversationId(lastSeenConversationId)
            .lastConversationId(lastConversationId)
            .dateEpoch(dateEpoch)
            .isSecret(isSecret)
            .secretChatroomParticipants(secretChatroomParticipants)
            .secretChatroomLeft(secretChatroomLeft)
            .reactions(reactions)
            .topicId(topicId)
            .topic(topic)
            .autoFollowDone(autoFollowDone)
            .isEdited(isEdited)
            .access(access)
            .memberCanMessage(memberCanMessage)
            .cohorts(cohorts)
            .externalSeen(externalSeen)
            .unreadConversationCount(unreadConversationCount)
            .chatroomImageUrl(chatroomImageUrl)
            .accessWithoutSubscription(accessWithoutSubscription)
            .lastConversation(lastConversation)
            .lastSeenConversation(lastSeenConversation)
            .draftConversation(draftConversation)
            .isConversationStored(isConversationStored)
            .isDraft(isDraft)
            .totalAllResponseCount(totalAllResponseCount)
            .chatRequestCreatedAt(chatRequestCreatedAt)
            .chatRequestState(chatRequestState?.rawValue)
            .chatWithUser(chatWithUser)
            .chatRequestedById(chatRequestedById)
            .chatRequestedByUser(chatRequestedByUser)
            .isPrivate(isPrivate)
            .isPrivateMember(isPrivateMember)
            .chatWithUserId(chatWithUserId)
    }
}
