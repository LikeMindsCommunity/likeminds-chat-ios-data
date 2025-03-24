//
//  ModelConverter.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 06/02/24.
//

import Foundation
import RealmSwift

/// A utility class that handles conversion between different model types in the LikeMindsChat SDK.
///
/// The ModelConverter class is responsible for converting between three types of models:
/// - Internal models (prefixed with underscore, e.g. _Conversation_)
/// - Realm database models (suffixed with RO, e.g. ConversationRO)
/// - Client-facing models (e.g. Conversation)
///
/// This class provides a comprehensive set of conversion methods to ensure data consistency
/// across different layers of the application. It handles:
/// - Conversation and message conversions
/// - User and member data transformations
/// - Attachment and media conversions
/// - Poll and reaction data mappings
/// - Community and chatroom conversions
///
/// Usage Example:
/// ```swift
/// let converter = ModelConverter.shared
/// if let conversation = converter.convertConversationRO(realmConversation) {
///     // Use the converted client-facing conversation object
/// }
/// ```
///
/// - Note: All conversion methods handle optional values safely and maintain data integrity
/// - Important: Some conversions involve JSON serialization which may throw errors
class ModelConverter {
    /// Shared singleton instance of ModelConverter
    static let shared = ModelConverter()
    
    /// Converts an internal Conversation model to the client-facing Conversation model
    /// - Parameter _conversation_: Internal conversation model to be converted
    /// - Returns: A client-facing Conversation object with all properties mapped from the internal model
    func convertConversation(
        _conversation_: _Conversation_
    ) -> Conversation {
        return Conversation.Builder()
            .id(_conversation_.id)
            .chatroomId(_conversation_.chatroomId)
            .communityId(_conversation_.communityId)
            .member(_conversation_.member)
            .answer(_conversation_.answer)
            .createdAt(_conversation_.createdAt)
            .state(_conversation_.state)
            .attachments(_conversation_.attachments)
            .lastSeen(_conversation_.lastSeen)
            .ogTags(_conversation_.ogTags)
            .date(_conversation_.date)
            .isEdited(_conversation_.isEdited)
            .memberId(_conversation_.memberId)
            .replyConversationId(_conversation_.replyConversationId)
            .deletedBy(_conversation_.deletedBy)
            .createdEpoch(_conversation_.createdEpoch)
            .attachmentCount(_conversation_.attachmentCount)
            .attachmentUploaded(_conversation_.attachmentUploaded)
            .uploadWorkerUUID(_conversation_.uploadWorkerUUID)
            .temporaryId(_conversation_.temporaryId)
            .localCreatedEpoch(_conversation_.localCreatedEpoch)
            .reactions(_conversation_.reactions)
            .isAnonymous(_conversation_.isAnonymous)
            .allowAddOption(_conversation_.allowAddOption)
            .pollType(_conversation_.pollType)
            .pollTypeText(_conversation_.pollTypeText)
            .submitTypeText(_conversation_.submitTypeText)
            .expiryTime(_conversation_.expiryTime)
            .multipleSelectNum(_conversation_.multipleSelectNum)
            .multipleSelectState(_conversation_.multipleSelectState)
            .polls(_conversation_.polls)
            .toShowResults(_conversation_.toShowResults)
            .pollAnswerText(_conversation_.pollAnswerText)
            .replyChatroomId(_conversation_.replyChatroomId)
            .deviceId(_conversation_.deviceId)
            .hasFiles(_conversation_.hasFiles)
            .hasReactions(_conversation_.hasReactions)
            .lastUpdated(_conversation_.lastUpdated)
            .conversationStatus(.sent)
            .widget(_conversation_.widget)
            .widgetId(_conversation_.widgetId)
            .attachmentUploadedEpoch(_conversation_.attachmentUploadedEpoch)
            .build()
    }

    /// Converts a Realm Conversation object to the client-facing Conversation model
    /// - Parameter conversationRO: Optional Realm Conversation object to be converted
    /// - Returns: An optional client-facing Conversation object. Returns nil if input is nil
    func convertConversationRO(_ conversationRO: ConversationRO?)
        -> Conversation?
    {
        guard let conversationRO else { return nil }
        var widget: Widget?
        if let widgetRO = conversationRO.widget {
            widget = convertWidgetROToWidget(widgetRO)
        }
        return Conversation.Builder()
            .id(conversationRO.id)
            .chatroomId(conversationRO.chatroomId)
            .communityId(conversationRO.communityId)
            .member(convertMemberRO(conversationRO.member))
            .answer(conversationRO.answer)
            .state(conversationRO.state)
            .createdAt(conversationRO.createdAt)
            .createdEpoch(conversationRO.createdEpoch)
            .attachments(convertAttachmentsRO(conversationRO.attachments))
            .ogTags(convertLinkRO(conversationRO.link))
            .date(conversationRO.date)
            .isEdited(conversationRO.isEdited)
            .lastSeen(conversationRO.lastSeen)
            .replyConversationId(conversationRO.replyConversationId)
            .replyConversation(
                convertConversationRO(conversationRO.replyConversation)
            )
            .deletedBy(conversationRO.deletedBy)
            .attachmentCount(conversationRO.attachmentCount)
            .attachmentUploaded(conversationRO.attachmentsUploaded)
            .uploadWorkerUUID(conversationRO.uploadWorkerUUID)
            .temporaryId(conversationRO.temporaryId)
            .reactions(convertReactionsRO(conversationRO.reactions))
            .isAnonymous(conversationRO.isAnonymous)
            .allowAddOption(conversationRO.allowAddOption)
            .pollType(conversationRO.pollType)
            .pollTypeText(conversationRO.pollTypeText)
            .submitTypeText(conversationRO.submitTypeText)
            .expiryTime(conversationRO.expiryTime)
            .multipleSelectNum(conversationRO.multipleSelectNum)
            .multipleSelectState(conversationRO.multipleSelectState)
            .polls(convertPollsRO(conversationRO.polls))
            .pollAnswerText(conversationRO.pollAnswerText)
            .toShowResults(conversationRO.toShowResults)
            .replyChatroomId(conversationRO.replyChatRoomId)
            .lastUpdated(conversationRO.lastUpdatedAt)
            .deletedByMember(convertMemberRO(conversationRO.deletedByMember))
            .conversationStatus(conversationRO.conversationStatus)
            .widget(widget)
            .widgetId(conversationRO.widgetId)
            .attachmentUploadedEpoch(conversationRO.attachmentUploadedEpoch)
            .build()
    }

    /// Converts a Realm Member object to the client-facing Member model
    /// - Parameter memberRO: Optional Realm Member object to be converted
    /// - Returns: An optional client-facing Member object. Returns nil if input is nil
    /// - Note: Converts member roles from strings to UserRole enum values
    func convertMemberRO(_ memberRO: MemberRO?) -> Member? {
        guard let memberRO else { return nil }
        let roles: [UserRole] = memberRO.roles.compactMap { UserRole.from($0) }

        return Member.Builder()
            .id(memberRO.id ?? "")
            .userUniqueId(memberRO.userUniqueId ?? "")
            .name(memberRO.name ?? "")
            .imageUrl(memberRO.imageUrl ?? "")
            .state(memberRO.state)
            .customIntroText(memberRO.customIntroText)
            .customClickText(memberRO.customClickText)
            .customTitle(memberRO.customTitle)
            .communityId(memberRO.communityId)
            .isOwner(memberRO.isOwner ?? false)
            .isGuest(memberRO.isGuest ?? false)
            .sdkClientInfo(convertSDKClientInfoRO(memberRO.sdkClientInfoRO))
            .uuid(memberRO.uuid ?? "")
            .roles(roles)
            .build()
    }

    /// Converts a Realm SDKClientInfo object to the client-facing SDKClientInfo model
    /// - Parameter sdkClientInfoRO: Optional Realm SDKClientInfo object to be converted
    /// - Returns: An optional client-facing SDKClientInfo object. Returns nil if input is nil
    func convertSDKClientInfoRO(_ sdkClientInfoRO: SDKClientInfoRO?)
        -> SDKClientInfo?
    {
        guard let sdkClientInfoRO else { return nil }
        return SDKClientInfo(
            community: sdkClientInfoRO.community,
            user: Int(sdkClientInfoRO.user ?? "0"),
            userUniqueID: sdkClientInfoRO.userUniqueId,
            uuid: sdkClientInfoRO.uuid
        )
    }

    /// Converts a list of Realm Attachment objects to an array of client-facing Attachment models
    /// - Parameter attachmentsRO: Optional Realm List of AttachmentRO objects
    /// - Returns: An optional array of client-facing Attachment objects. Returns nil if input is nil
    private func convertAttachmentsRO(_ attachmentsRO: List<AttachmentRO>?)
        -> [Attachment]?
    {
        guard let attachmentsRO = attachmentsRO else { return nil }
        return attachmentsRO.map { attachmentRO in
            convertAttachmentRO(attachmentRO)
        }
    }

    /// Converts a single Realm Attachment object to a client-facing Attachment model
    /// - Parameter attachmentRO: Realm Attachment object to be converted
    /// - Returns: A client-facing Attachment object with all properties mapped
    private func convertAttachmentRO(_ attachmentRO: AttachmentRO) -> Attachment
    {
        return Attachment.Builder()
            .id(attachmentRO.id)
            .name(attachmentRO.name)
            .url(attachmentRO.url ?? "")
            .type(Attachment.AttachmentType(rawValue: attachmentRO.type ?? "") ?? Attachment.AttachmentType.unknown)
            .index(attachmentRO.index)
            .width(attachmentRO.width)
            .height(attachmentRO.height)
            .awsFolderPath(attachmentRO.awsFolderPath)
            .localFilePath(attachmentRO.localFilePath)
            .thumbnailUrl(attachmentRO.thumbnailUrl)
            .thumbnailAWSFolderPath(attachmentRO.thumbnailAWSFolderPath)
            .thumbnailLocalFilePath(attachmentRO.thumbnailLocalFilePath)
            .meta(convertAttachmentMetaRO(attachmentRO.metaRO))
            .createdAt(attachmentRO.createdAt)
            .updatedAt(attachmentRO.updatedAt)
            .isUploaded(attachmentRO.isUploaded)
            .build()
    }

    /// Converts a Realm AttachmentMeta object to a client-facing AttachmentMeta model
    /// - Parameter attachmentMetaRO: Optional Realm AttachmentMeta object
    /// - Returns: An optional client-facing AttachmentMeta object. Returns nil if input is nil
    private func convertAttachmentMetaRO(_ attachmentMetaRO: AttachmentMetaRO?)
        -> AttachmentMeta?
    {
        guard let attachmentMetaRO = attachmentMetaRO else { return nil }
        return AttachmentMeta.Builder()
            .numberOfPage(attachmentMetaRO.numberOfPage)
            .duration(attachmentMetaRO.duration)
            .size(attachmentMetaRO.size)
            .build()
    }

    /// Converts a Realm Link object to a client-facing LinkOGTags model
    /// - Parameter linkRO: Optional Realm Link object to be converted
    /// - Returns: An optional client-facing LinkOGTags object. Returns nil if input is nil
    private func convertLinkRO(_ linkRO: LinkRO?) -> LinkOGTags? {
        guard let linkRO = linkRO else { return nil }
        return LinkOGTags.Builder()
            .url(linkRO.link)
            .title(linkRO.title)
            .description(linkRO.linkDescription)
            .image(linkRO.image)
            .build()
    }

    /// Converts a list of Realm Reaction objects to an array of client-facing Reaction models
    /// - Parameter reactionsRO: Optional Realm List of ReactionRO objects
    /// - Returns: An optional array of client-facing Reaction objects. Returns nil if input is nil
    private func convertReactionsRO(_ reactionsRO: List<ReactionRO>?)
        -> [Reaction]?
    {
        guard let reactionsRO = reactionsRO else { return nil }
        return reactionsRO.map { reactionRO in
            convertReactionRO(reactionRO)
        }
    }

    /// Converts a single Realm Reaction object to a client-facing Reaction model
    /// - Parameter reactionRO: Realm Reaction object to be converted
    /// - Returns: A client-facing Reaction object with member information
    private func convertReactionRO(_ reactionRO: ReactionRO) -> Reaction {
        return Reaction.Builder()
            .reaction(reactionRO.reaction ?? "")
            .member(convertMemberRO(reactionRO.member))
            .build()
    }

    /// Converts a list of Realm Poll objects to an array of client-facing Poll models
    /// - Parameter pollsRO: Realm List of PollRO objects
    /// - Returns: An array of client-facing Poll objects
    private func convertPollsRO(_ pollsRO: List<PollRO>) -> [Poll] {
        return pollsRO.map { pollRO in
            convertPollRO(pollRO)
        }
    }

    /// Converts a single Realm Poll object to a client-facing Poll model
    /// - Parameter pollRO: Realm Poll object to be converted
    /// - Returns: A client-facing Poll object with all properties mapped
    private func convertPollRO(_ pollRO: PollRO) -> Poll {
        return Poll.Builder()
            .id(pollRO.id)
            .text(pollRO.text)
            .isSelected(pollRO.isSelected)
            .percentage(pollRO.percentage)
            .subText(pollRO.subText)
            .noVotes(pollRO.noVotes)
            .member(convertUser(convertMemberRO(pollRO.member)))
            .build()
    }

    /// Converts an internal Chatroom model to the client-facing Chatroom model
    /// - Parameter chatroom: Optional internal chatroom model to be converted
    /// - Returns: An optional client-facing Chatroom object. Returns nil if input is nil
    func convertChatroom(chatroom: _Chatroom_?) -> Chatroom? {
        guard let chatroom else { return nil }
        return Chatroom.Builder()
            .id(chatroom.id ?? "")
            .member(chatroom.member)
            .communityId(chatroom.communityId)
            .communityName("")
            .title(chatroom.title ?? "")
            .state(chatroom.state ?? 0)
            .createdAt(chatroom.createdAt)
            .type(chatroom.type)
            .chatroomImageUrl(chatroom.chatroomImageUrl)
            .header(chatroom.header)
            .cardCreationTime(chatroom.cardCreationTime)
            .totalResponseCount(chatroom.totalResponseCount ?? 0)
            .muteStatus(chatroom.muteStatus)
            .followStatus(chatroom.followStatus)
            .hasBeenNamed(chatroom.hasBeenNamed)
            .date(chatroom.date)
            .isTagged(chatroom.isTagged)
            .isPending(chatroom.isPending)
            .deletedBy(chatroom.deletedBy)
            .updatedAt(chatroom.updatedAt)
            .lastConversationId(chatroom.lastConversationId)
            .lastSeenConversationId(chatroom.lastSeenConversationId)
            .dateEpoch(chatroom.dateEpoch)
            .unseenCount(chatroom.unseenCount)
            .isSecret(chatroom.isSecret)
            .topicId(chatroom.topicId)
            .autoFollowDone(chatroom.autoFollowDone)
            .memberCanMessage(chatroom.memberCanMessage)
            .isEdited(chatroom.isEdited)
            .accessWithoutSubscription(chatroom.accessWithoutSubscription)
            .externalSeen(chatroom.externalSeen)
            .participantsCount(chatroom.participantsCount)
            .isPinned(chatroom.isPinned)
            .showFollowTelescope(chatroom.showFollowTelescope)
            .showFollowAutoTag(chatroom.showFollowAutoTag)
            .chatWithUser(chatroom.chatWithUser)
            .chatWithUserId(chatroom.chatWithUserId)
            .chatRequestedById(chatroom.chatRequestedById)
            .chatRequestState(chatroom.chatRequestState)
            .isPrivateMember(chatroom.isPrivateMember)
            .isPrivate(chatroom.isPrivate)
            .chatRequestCreatedAt(chatroom.chatRequestCreatedAt)
            .build()
    }

    /// Converts a Realm Chatroom object to the client-facing Chatroom model
    /// - Parameter chatroomRO: Optional Realm Chatroom object to be converted
    /// - Returns: An optional client-facing Chatroom object. Returns nil if input is nil
    func convertChatroomRO(chatroomRO: ChatroomRO?) -> Chatroom? {
        guard let chatroomRO else { return nil }
        return Chatroom.Builder()
            .id(chatroomRO.id)
            .member(convertMemberRO(chatroomRO.member))
            .communityId(chatroomRO.communityId)
            .communityName("")
            .title(chatroomRO.title)
            .state(chatroomRO.state)
            .createdAt(chatroomRO.createdAt)
            .type(chatroomRO.type)
            .chatroomImageUrl(chatroomRO.chatroomImageUrl)
            .header(chatroomRO.header)
            .cardCreationTime(chatroomRO.cardCreationTime)
            .totalResponseCount(chatroomRO.totalResponseCount)
            .muteStatus(chatroomRO.muteStatus)
            .followStatus(chatroomRO.followStatus)
            .hasBeenNamed(chatroomRO.hasBeenNamed)
            .date(chatroomRO.date)
            .isTagged(chatroomRO.isTagged)
            .isPending(chatroomRO.isPending)
            .deletedBy(chatroomRO.deletedBy)
            .updatedAt(chatroomRO.updatedAt)
            .lastConversationId(chatroomRO.lastConversationId)
            .lastConversation(
                convertLastConversationRO(chatroomRO.lastConversationRO)
                    ?? convertConversationRO(chatroomRO.lastConversation)
            )
            .lastSeenConversationId(chatroomRO.lastSeenConversationId)
            .lastSeenConversation(
                convertConversationRO(chatroomRO.lastSeenConversation)
            )
            .dateEpoch(chatroomRO.dateEpoch)
            .unseenCount(chatroomRO.unseenCount)
            .draftConversation(chatroomRO.draftConversation)
            .isSecret(chatroomRO.isSecret)
            .secretChatroomParticipants(
                chatroomRO.secretChatRoomParticipants.compactMap({ $0 })
            )
            .secretChatroomLeft(chatroomRO.secretChatRoomLeft)
            .topicId(chatroomRO.topicId)
            .topic(convertConversationRO(chatroomRO.topic))
            .autoFollowDone(chatroomRO.autoFollowDone)
            .memberCanMessage(chatroomRO.memberCanMessage)
            .isEdited(chatroomRO.isEdited)
            .reactions(convertReactionsRO(chatroomRO.reactions))
            .unreadConversationCount(chatroomRO.unreadConversationsCount)
            .accessWithoutSubscription(chatroomRO.accessWithoutSubscription)
            .externalSeen(chatroomRO.externalSeen)
            .isConversationStored(chatroomRO.isConversationStored)
            .isDraft(chatroomRO.isDraft)
            .totalAllResponseCount(chatroomRO.totalAllResponseCount)
            .chatWithUser(convertMemberRO(chatroomRO.chatroomWithUser))
            .chatWithUserId(chatroomRO.chatroomWithUserId)
            .chatRequestedById(chatroomRO.chatRequestedById)
            .chatRequestedByUser(convertMemberRO(chatroomRO.chatRequestedBy))
            .chatRequestState(chatroomRO.chatRequestState)
            .isPrivateMember(chatroomRO.isPrivateMember)
            .isPrivate(chatroomRO.isPrivate)
            .chatRequestCreatedAt(chatroomRO.chatRequestCreatedAt)
            .build()
    }

    /// Converts a Realm LastConversation object to the client-facing Conversation model
    /// - Parameter lastConversationRO: Optional Realm LastConversation object
    /// - Returns: An optional client-facing Conversation object. Returns nil if input is nil
    private func convertLastConversationRO(
        _ lastConversationRO: LastConversationRO?
    ) -> Conversation? {
        guard let lastConversationRO else { return nil }
        var widget: Widget?
        if let widgetRO = lastConversationRO.widget {
            widget = convertWidgetROToWidget(widgetRO)
        }
        return Conversation.Builder()
            .id(lastConversationRO.id)
            .member(convertMemberRO(lastConversationRO.member))
            .createdAt(lastConversationRO.createdAt)
            .answer(lastConversationRO.answer ?? "")
            .state(lastConversationRO.state ?? 0)
            .attachments(convertAttachmentsRO(lastConversationRO.attachments))
            .date(lastConversationRO.date)
            .deletedBy(lastConversationRO.deletedBy)
            .attachmentCount(lastConversationRO.attachmentCount)
            .attachmentUploaded(lastConversationRO.attachmentsUploaded)
            .uploadWorkerUUID(lastConversationRO.uploadWorkerUUID)
            .createdEpoch(lastConversationRO.createdEpoch)
            .chatroomId(lastConversationRO.chatroomId)
            .communityId(lastConversationRO.communityId)
            .ogTags(convertLinkRO(lastConversationRO.link))
            .deletedByMember(
                convertMemberRO(lastConversationRO.deletedByMember)
            )
            .widget(widget)
            .widgetId(lastConversationRO.widgetId)
            .attachmentUploadedEpoch(lastConversationRO.attachmentUploadedEpoch)
            .build()
    }

    /// Converts a list of Realm Conversation objects to an array of client-facing Conversation models
    /// - Parameter conversationsRO: Optional Realm List of ConversationRO objects
    /// - Returns: An optional array of client-facing Conversation objects. Returns nil if input is nil
    private func convertConversationsRO(
        _ conversationsRO: List<ConversationRO>?
    ) -> [Conversation]? {
        return (conversationsRO ?? List()).compactMap { conversation in
            convertConversationRO(conversation)
        }
    }

    /// Converts a Realm Community object to the client-facing Community model
    /// - Parameter communityRO: Realm Community object to be converted
    /// - Returns: A client-facing Community object with basic properties mapped
    func convertCommunityRO(_ communityRO: CommunityRO) -> Community {
        return Community(
            id: Int(communityRO.id), imageURL: communityRO.imageUrl,
            name: communityRO.name, membersCount: communityRO.membersCount,
            purpose: nil, subType: nil, type: nil,
            updatedAt: communityRO.updatedAt, autoApproval: nil, hideDMTab: nil,
            communitySettings: nil, communitySettingRights: nil)
    }

    /// Converts a Realm User object to the client-facing User model
    /// - Parameter userRO: Optional Realm User object to be converted
    /// - Returns: An optional client-facing User object. Returns nil if input is nil
    /// - Note: Converts user roles from strings to UserRole enum values
    func convertUserRO(_ userRO: UserRO?) -> User? {
        guard let userRO else { return nil }
        var user = User(id: userRO.id, imageUrl: userRO.imageUrl)
        user.isGuest = userRO.isGuest ?? false
        user.name = userRO.name
        user.organisationName = userRO.organizationName
        user.sdkClientInfo = convertSDKClientInfoRO(userRO.sdkClientInfoRO)
        user.isDeleted = userRO.isDeleted
        user.customTitle = userRO.customTitle
        user.updatedAt = userRO.updatedAt
        user.userUniqueID = userRO.userUniqueId
        user.uuid = userRO.uuid
        let roles: [UserRole] = userRO.roles.compactMap { UserRole.from($0) }
        user.roles = roles
        return user
    }

    /// Converts a Member object to the client-facing User model
    /// - Parameter member: Optional Member object to be converted
    /// - Returns: An optional client-facing User object. Returns nil if input is nil
    /// - Note: Maps all relevant member properties to the user model including roles
    func convertUser(_ member: Member?) -> User? {
        guard let member else { return nil }
        var user = User(id: member.id, imageUrl: member.imageUrl)
        user.isGuest = member.isGuest
        user.name = member.name
        user.state = member.state
        user.sdkClientInfo = member.sdkClientInfo
        user.isDeleted = member.isDeleted
        user.customTitle = member.customTitle
        user.updatedAt = member.updatedAt
        user.userUniqueID = member.userUniqueId
        user.uuid = member.uuid
        user.roles = member.roles
        user.roles = member.roles
        return user
    }

    /// Converts a Realm Widget object to the client-facing Widget model
    /// - Parameter widgetRO: Realm Widget object to be converted
    /// - Returns: An optional client-facing Widget object
    /// - Throws: JSONSerialization errors if metadata or lmMeta cannot be deserialized
    /// - Note: Returns nil if JSON deserialization fails for either metadata or lmMeta
    func convertWidgetROToWidget(_ widgetRO: WidgetRO) -> Widget? {
        var metadataDict: [String: Any]?
        var lmMetaDict: [String: Any]?

        // Deserialize metadata
        do {
            if let metadataData = widgetRO.metadata {
                metadataDict =
                    try JSONSerialization.jsonObject(with: metadataData)
                    as? [String: Any]
            }
        } catch {
            print("Error deserializing metadata: \(error)")
            return nil
        }

        // Deserialize lmMeta
        do {
            if let lmMetaRO = widgetRO._lm_meta {
                lmMetaDict =
                    try JSONSerialization.jsonObject(with: lmMetaRO)
                    as? [String: Any]
            }
        } catch {
            print("Error deserializing lmMeta: \(error)")
            return nil
        }

        return Widget(
            id: widgetRO.id,
            parentEntityID: widgetRO.parentEntityId,
            parentEntityType: widgetRO.parentEntityType,
            metadata: metadataDict,
            createdAt: Double(widgetRO.createdAt),
            updatedAt: Double(widgetRO.updatedAt),
            lmMeta: lmMetaDict
        )
    }
}
