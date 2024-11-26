//
//  ROConverter.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 09/01/24.
//

import Foundation
import RealmSwift

/// A utility class for converting application models to their respective Realm Object (RO) equivalents.
/// This class includes methods for transforming entities such as `Conversation`, `User`, and `ReactionMeta` into their Realm counterparts.
class ROConverter {

    /**
     Converts a `_Conversation_` object into a `ConversationRO`.
      - Parameters:
        - realm: The `Realm` instance for performing database operations.
        - conversation: The `_Conversation_` model to be converted.
        - creator: The `MemberRO` representing the creator of the conversation.
        - polls: An optional list of polls (`Poll`) associated with the conversation.
        - attachments: An optional list of attachments (`Attachment`) associated with the conversation.
        - widgets: A dictionary of widgets in the conversation.
        - reactions: An optional list of reactions (`ReactionMeta`) related to the conversation.
        - loggedInUUID: The UUID of the currently logged-in user.
        - deletedByMemberRO: An optional `MemberRO` representing the member who deleted the conversation.
      - Returns:
        A `ConversationRO` object representing the converted conversation or `nil` if the conversion fails.
     */
    static func convertCommunity(_ community: Community?) -> CommunityRO? {
        guard let community else { return nil }
        let communityRO = CommunityRO()
        communityRO.id = "\(community.id ?? 0)"
        communityRO.name = community.name
        communityRO.imageUrl = community.imageURL
        communityRO.updatedAt = community.updatedAt
        return communityRO
    }
    /**
         * Converts a `Member` to `MemberRO`.
         * - Parameters:
         *   - member: The `Member` object to be converted.
         *   - communityId: The community ID to associate with the `MemberRO`.
         * - Returns: A `MemberRO` object or `nil` if the input member is invalid.
         */
    static func convertMember(member: Member?, communityId: String) -> MemberRO?
    {
        guard let member else { return nil }
        let uuid = member.sdkClientInfo?.uuid ?? ""
        let uid = "\(uuid)#\(communityId)"

        let memberRO = MemberRO()
        memberRO.communityId = communityId
        memberRO.name = member.name
        memberRO.id = member.id
        memberRO.imageUrl = member.imageUrl ?? ""
        memberRO.state = member.state ?? 0
        memberRO.customIntroText = member.customIntroText
        memberRO.customClickText = member.customClickText
        memberRO.uid = uid

        let rolesAsStrings = member.roles?.compactMap { $0.rawValue } ?? []

        let rolesAsList = List<String>()
        rolesAsList.append(objectsIn: rolesAsStrings)
        memberRO.roles = rolesAsList

        //if customTitle == "Member" then save null else member.customTitle()
        if member.customTitle?.lowercased() == "member" {
            memberRO.customTitle = nil
        } else {
            memberRO.customTitle = member.customTitle
        }
        memberRO.isOwner = member.isOwner
        memberRO.isGuest = member.isGuest
        memberRO.userUniqueId = member.userUniqueId
        memberRO.sdkClientInfoRO = convertSDKClientInfo(member.sdkClientInfo)
        return memberRO
    }
    /**
        * Converts an `SDKClientInfo` object to its `SDKClientInfoRO` counterpart.
        * - Parameter sdkClientInfo: The `SDKClientInfo` object to be converted.
        * - Returns: A `SDKClientInfoRO` object or `nil` if the input is invalid.
        */
    static func convertSDKClientInfo(_ sdkClientInfo: SDKClientInfo?)
        -> SDKClientInfoRO?
    {
        guard let sdkClientInfo else { return nil }
        let sdkClientInfoRO = SDKClientInfoRO()
        sdkClientInfoRO.community = sdkClientInfo.community
        sdkClientInfoRO.user = "\(sdkClientInfo.user ?? 0)"
        sdkClientInfoRO.uuid = sdkClientInfo.uuid
        sdkClientInfoRO.userUniqueId = sdkClientInfo.userUniqueID
        return sdkClientInfoRO
    }
    /**
        * Converts a `_Chatroom_` object to a `ChatroomRO`.
        * - Parameters:
        *   - chatroom: The `_Chatroom_` model to be converted.
        *   - chatroomCreatorRO: The `MemberRO` representing the chatroom creator.
        *   - lastConversationRO: Optional `LastConversationRO` associated with the chatroom.
        *   - reactions: A list of reactions (`ReactionMeta`) related to the chatroom.
        *   - chatRequestByRO: An optional `MemberRO` for the member requesting the chat.
        *   - chatroomWithUserRO: An optional `MemberRO` for the user in the chatroom.
        * - Returns: A `ChatroomRO` object or `nil` if the conversion fails.
        */
    static func convertChatroom(
        fromChatroomJsonModel chatroom: _Chatroom_,
        chatroomCreatorRO: MemberRO,
        lastConversationRO: LastConversationRO? = nil,
        reactions: [ReactionMeta] = [],
        chatRequestByRO: MemberRO?,
        chatroomWithUserRO: MemberRO?
    ) -> ChatroomRO? {
        guard let chatroomId = chatroom.id,
            let communityId = chatroom.communityId
        else { return nil }

        let savedChatroom = ChatDBUtil.shared.getChatroom(
            realm: RealmManager.realmInstance(), chatroomId: chatroomId)
        let reactionsRO = Self.convertReactionsMeta(
            realm: RealmManager.realmInstance(), communityId: communityId,
            reactions: reactions)

        let chatroomRO = ChatroomRO()
        chatroomRO.id = chatroomId
        chatroomRO.communityId = communityId
        chatroomRO.state = chatroom.state ?? 0
        chatroomRO.member = chatroomCreatorRO
        chatroomRO.createdAt = chatroom.createdAt
        chatroomRO.type = chatroom.type
        chatroomRO.chatroomImageUrl = chatroom.chatroomImageUrl
        chatroomRO.header = chatroom.header
        chatroomRO.title = chatroom.title ?? ""
        chatroomRO.cardCreationTime = chatroom.cardCreationTime
        chatroomRO.totalResponseCount = savedChatroom?.totalResponseCount ?? 0
        chatroomRO.totalAllResponseCount =
            savedChatroom?.totalAllResponseCount ?? 0
        chatroomRO.muteStatus = chatroom.muteStatus
        chatroomRO.followStatus = chatroom.followStatus
        chatroomRO.hasBeenNamed = chatroom.hasBeenNamed
        chatroomRO.date = chatroom.date
        chatroomRO.isTagged = chatroom.isTagged
        chatroomRO.isPending = chatroom.isPending
        chatroomRO.deletedBy = chatroom.deletedBy
        chatroomRO.autoFollowDone = chatroom.autoFollowDone
        chatroomRO.memberCanMessage = chatroom.memberCanMessage
        chatroomRO.isEdited = chatroom.isEdited
        chatroomRO.externalSeen = chatroom.externalSeen
        chatroomRO.accessWithoutSubscription =
            chatroom.accessWithoutSubscription == true
        chatroomRO.unreadConversationsCount = chatroom.unreadConversationCount

        chatroomRO.reactions = reactionsRO

        let updatedAt =
            lastConversationRO?.createdEpoch
            ?? savedChatroom?.lastConversationRO?.createdEpoch

        chatroomRO.updatedAt = updatedAt

        chatroomRO.lastSeenConversationId = chatroom.lastSeenConversationId
        chatroomRO.lastSeenConversation = savedChatroom?.lastSeenConversation

        chatroomRO.lastConversationId = chatroom.lastConversationId
        chatroomRO.lastConversation = savedChatroom?.lastConversation
        chatroomRO.lastConversationRO =
            lastConversationRO ?? savedChatroom?.lastConversationRO

        chatroomRO.unseenCount = chatroom.unseenCount ?? 0
        chatroomRO.dateEpoch = chatroom.dateEpoch
        chatroomRO.draftConversation = savedChatroom?.draftConversation  //to maintain un-send conversation
        chatroomRO.isSecret = chatroom.isSecret
        let secretParticipants = List<Int>()
        secretParticipants.append(
            objectsIn: chatroom.secretChatroomParticipants ?? [])
        chatroomRO.secretChatRoomParticipants = secretParticipants
        chatroomRO.secretChatRoomLeft = chatroom.secretChatroomLeft
        chatroomRO.topicId = chatroom.topicId ?? savedChatroom?.topicId
        chatroomRO.topic = savedChatroom?.topic
        chatroomRO.isConversationStored =
            savedChatroom?.isConversationStored ?? false
        chatroomRO.chatRequestState = chatroom.chatRequestState
        chatroomRO.isPrivateMember = chatroom.isPrivateMember
        chatroomRO.isPrivate = chatroom.isPrivate
        chatroomRO.chatRequestedById = chatroom.chatRequestedById
        chatroomRO.chatRequestedBy = chatRequestByRO
        chatroomRO.chatRequestCreatedAt = chatroom.chatRequestCreatedAt
        chatroomRO.chatroomWithUserId = chatroom.chatWithUserId
        chatroomRO.chatroomWithUser = chatroomWithUserRO
        chatroomRO.shareLink = chatroom.shareLink
        return chatroomRO
    }

    /**
     * Converts an `Attachment` to its `AttachmentRO` counterpart.
     * - Parameters:
     *   - chatroomId: The ID of the chatroom associated with the attachment.
     *   - communityId: The community ID associated with the attachment.
     *   - attachment: The `Attachment` to be converted.
     * - Returns: An `AttachmentRO` object.
     */
    private static func convertAttachment(
        chatroomId: String,
        communityId: String,
        attachment: Attachment
    ) -> AttachmentRO {
        let attachmentRO = AttachmentRO()
        attachmentRO.id = attachment.id ?? ""
        attachmentRO.name = attachment.name
        attachmentRO.type = attachment.type
        attachmentRO.index = attachment.index
        attachmentRO.width = attachment.width
        attachmentRO.height = attachment.height
        attachmentRO.awsFolderPath = attachment.awsFolderPath
        attachmentRO.localFilePath = attachment.localFilePath
        attachmentRO.thumbnailUrl = attachment.thumbnailUrl
        attachmentRO.thumbnailAWSFolderPath = attachment.thumbnailAWSFolderPath
        attachmentRO.thumbnailLocalFilePath = attachment.thumbnailLocalFilePath
        attachmentRO.metaRO = convertAttachmentMeta(meta: attachment.meta)
        attachmentRO.createdAt = attachment.createdAt
        attachmentRO.updatedAt = attachment.updatedAt
        attachmentRO.url = attachment.url
        return attachmentRO
    }

    /**
         * Converts an `AttachmentMeta` to its `AttachmentMetaRO` counterpart.
         * - Parameter meta: The `AttachmentMeta` to be converted.
         * - Returns: An `AttachmentMetaRO` object.
         */
    private static func convertAttachmentMeta(meta: AttachmentMeta?)
        -> AttachmentMetaRO
    {
        let attachmentMetaRO = AttachmentMetaRO()
        attachmentMetaRO.numberOfPage = meta?.numberOfPage
        attachmentMetaRO.size = meta?.size
        attachmentMetaRO.duration = meta?.duration
        return attachmentMetaRO
    }

    /**
     * Update only those conversation attachments(image,video) whose urls are uploaded successfully on server
     * */
    private static func convertUpdatedAttachments(
        chatroomId: String,
        communityId: String,
        attachments: [Attachment],
        oldAttachments: List<AttachmentRO>
    ) -> List<AttachmentRO> {

        if oldAttachments.isEmpty && attachments.isEmpty {
            return List()
        }
        if oldAttachments.isEmpty && !attachments.isEmpty {
            let attachs = attachments.map { attachment in
                convertAttachment(
                    chatroomId: chatroomId, communityId: communityId,
                    attachment: attachment)
            }
            let roAttachs = List<AttachmentRO>()
            roAttachs.append(objectsIn: attachs)
            return roAttachs
        }

        if !oldAttachments.isEmpty && attachments.isEmpty {
            let roAttachs = List<AttachmentRO>()
            roAttachs.append(objectsIn: oldAttachments)
            return roAttachs
        }

        if oldAttachments.count > attachments.count {
            let roAttachs = List<AttachmentRO>()
            roAttachs.append(objectsIn: oldAttachments)
            return roAttachs
        }

        let attachs = attachments.map { attachment in
            convertAttachment(
                chatroomId: chatroomId, communityId: communityId,
                attachment: attachment)
        }
        let roAttachs = List<AttachmentRO>()
        roAttachs.append(objectsIn: attachs)
        return roAttachs
    }

    /**
     * Converts a list of `Poll` objects to a `List<PollRO>`.
     * - Parameters:
     *   - realm: The `Realm` instance for database operations.
     *   - polls: The list of `Poll` objects to be converted.
     *   - communityId: The community ID associated with the polls.
     * - Returns: A `List<PollRO>` containing the converted polls.
     */
    private static func convertPolls(
        realm: Realm,
        polls: [Poll]?,
        communityId: String?
    ) -> List<PollRO> {

        let pollsData = (polls ?? []).compactMap { poll in
            convertPoll(
                realm: realm, communityId: communityId, poll: poll,
                uuid: poll.member?.sdkClientInfo?.uuid)
        }
        let pollsList = List<PollRO>()
        pollsList.append(objectsIn: pollsData)
        return pollsList
    }

    /**
        * Converts a `Poll` to its `PollRO` counterpart.
        * - Parameters:
        *   - realm: The `Realm` instance for database operations.
        *   - poll: The `Poll` to be converted.
        *   - communityId: The community ID associated with the poll.
        *   - uuid: The UUID of the poll creator.
        * - Returns: A `PollRO` object or `nil` if the poll is invalid.
        */
    static func convertPoll(
        realm: Realm,
        communityId: String?,
        poll: Poll?,
        uuid: String?
    ) -> PollRO? {
        guard let poll else { return nil }
        let pollRO = PollRO()
        pollRO.id = poll.id ?? ""
        pollRO.text = poll.text ?? ""
        pollRO.subText = poll.subText
        pollRO.isSelected = poll.isSelected
        pollRO.percentage = poll.percentage
        pollRO.noVotes = poll.noVotes
        pollRO.member = ChatDBUtil.shared.getMember(
            realm: realm, communityId: communityId, uuid: uuid)
        return pollRO
    }

    /**
      * Converts a list of `Reaction` objects into a `List<ReactionRO>` for storage in Realm.
      * - Parameters:
      *   - realm: The `Realm` instance for database operations.
      *   - communityId: The community ID associated with the reactions.
      *   - reactions: The list of `Reaction` objects to be converted.
      * - Returns: A `List<ReactionRO>` containing the converted reactions.
      */
    private static func convertReactions(
        realm: Realm,
        communityId: String?,
        reactions: [Reaction]?
    ) -> List<ReactionRO> {

        let reactionsData = (reactions ?? []).compactMap { reaction in
            convertReaction(
                realm: realm, reaction: reaction, communityId: communityId)
        }
        let reactionList = List<ReactionRO>()
        reactionList.append(objectsIn: reactionsData)
        return reactionList
    }

    /**
     * Converts a single `Reaction` object into a `ReactionRO` object for Realm storage.
     * - Parameters:
     *   - realm: The `Realm` instance for database operations.
     *   - reaction: The `Reaction` object to be converted.
     *   - communityId: The community ID associated with the reaction.
     * - Returns: A `ReactionRO` object or `nil` if the input reaction cannot be converted.
     */
    private static func convertReaction(
        realm: Realm,
        reaction: Reaction,
        communityId: String?
    ) -> ReactionRO? {
        let memberRO = ChatDBUtil.shared.getMember(
            realm: realm,
            communityId: communityId,
            uuid: reaction.member?.sdkClientInfo?.uuid
        )
        let reactionRO = ReactionRO()
        reactionRO.reaction = reaction.reaction
        reactionRO.member = memberRO
        return reactionRO
    }

    /**
        * Converts a `LinkOGTags` to its `LinkRO` counterpart.
        * - Parameters:
        *   - chatroomId: The ID of the chatroom associated with the link.
        *   - communityId: The community ID associated with the link.
        *   - link: The `LinkOGTags` object to be converted.
        * - Returns: A `LinkRO` object or `nil` if the link is invalid.
        */
    static func convertLink(
        chatroomId: String,
        communityId: String,
        link: LinkOGTags?
    ) -> LinkRO? {
        guard let link, link.url?.isEmpty == false else {
            return nil
        }
        let linkRO = LinkRO()
        linkRO.chatroomId = chatroomId
        linkRO.communityId = communityId
        linkRO.title = link.title
        linkRO.image = link.image
        linkRO.linkDescription = link.description ?? ""
        linkRO.link = link.url

        return linkRO
    }
    /**
     * Converts a `Conversation` object into a `ConversationRO` object.
     * This method ensures that the given `Conversation` is transformed into its Realm-compatible counterpart (`ConversationRO`),
     * including all associated metadata such as attachments, reactions, and polls.
     * - Parameter conversation: The `Conversation` object to be converted.
     * - Returns: A `ConversationRO` object containing the converted data or `nil` if the input is invalid.
     */
    static func convertConversation(
        conversation: Conversation?
    ) -> ConversationRO? {
        /**
         * Conversation is invalid without chatroomId, conversationId, Member object
         */
        let realm = RealmManager.realmInstance()
        guard let conversation,
            let chatroomId = conversation.chatroomId,
            let communityId = conversation.communityId
        else { return nil }
        // Attempt to retrieve the member (creator) of the conversation. If the member does not exist,
        // convert it from the conversation data or return nil if it cannot be resolved.

        guard
            let memberRO = ChatDBUtil.shared.getMember(
                realm: realm, communityId: conversation.communityId,
                uuid: conversation.member?.sdkClientInfo?.uuid)
                ?? ROConverter.convertMember(
                    member: conversation.member,
                    communityId: SDKPreferences.shared.getCommunityId() ?? "")
        else { return nil }

        let savedAnswer: ConversationRO?
        if conversation.hasReactions == true
            || ConversationState.isPoll(stateValue: conversation.state.rawValue)
            || (conversation.attachmentCount ?? 0) > 0
            || conversation.replyConversationId != nil
        {
            savedAnswer = ChatDBUtil.shared.getConversation(
                realm: realm, conversationId: conversation.id)
        } else {
            savedAnswer = nil
        }

        let replyConversation: ConversationRO?
        if let replyConversationId = conversation.replyConversationId,
            !replyConversationId.isEmpty
        {
            replyConversation =
                savedAnswer?.replyConversation
                ?? ChatDBUtil.shared.getConversation(
                    realm: realm,
                    conversationId: conversation.replyConversationId)
        } else {
            replyConversation = nil
        }

        let attachmentList = convertUpdatedAttachments(
            chatroomId: chatroomId, communityId: communityId,
            attachments: conversation.attachments ?? [],
            oldAttachments: savedAnswer?.attachments ?? List())
        let reactionsList = Self.convertReactions(
            realm: realm, communityId: communityId,
            reactions: conversation.reactions)
        let pollsList = convertPolls(
            realm: realm, polls: conversation.polls, communityId: communityId)

        var createdEpoch = conversation.createdEpoch ?? 0
        if !TimeUtil.isInMillis(createdEpoch) {
            createdEpoch = createdEpoch * 1000
        }
        let conversationRO = ConversationRO()
        conversationRO.id = conversation.id ?? ""
        conversationRO.answer = conversation.answer
        conversationRO.state = conversation.state.rawValue
        conversationRO.createdEpoch = createdEpoch
        conversationRO.communityId = communityId
        conversationRO.member = memberRO
        conversationRO.chatroomId = chatroomId
        conversationRO.createdAt = conversation.createdAt
        conversationRO.attachments = attachmentList
        conversationRO.link = convertLink(
            chatroomId: chatroomId, communityId: communityId,
            link: conversation.ogTags)
        conversationRO.date = conversation.date
        conversationRO.isEdited = conversation.isEdited
        conversationRO.replyConversationId = conversation.replyConversationId
        conversationRO.replyConversation = replyConversation
        conversationRO.deletedBy = conversation.deletedBy
        conversationRO.attachmentCount = conversation.attachmentCount
        conversationRO.attachmentsUploaded = conversation.attachmentUploaded
        conversationRO.uploadWorkerUUID =
            savedAnswer?.uploadWorkerUUID ?? conversation.uploadWorkerUUID
        conversationRO.localSavedEpoch = conversation.localCreatedEpoch ?? 0
        conversationRO.temporaryId = conversation.temporaryId
        conversationRO.reactions = reactionsList
        conversationRO.isAnonymous = conversation.isAnonymous
        conversationRO.allowAddOption = conversation.allowAddOption
        conversationRO.pollType = conversation.pollType
        conversationRO.pollTypeText = conversation.pollTypeText
        conversationRO.submitTypeText = conversation.submitTypeText
        conversationRO.expiryTime = conversation.expiryTime ?? 0
        conversationRO.multipleSelectNum = conversation.multipleSelectNum
        conversationRO.multipleSelectState = conversation.multipleSelectState
        conversationRO.polls = pollsList
        conversationRO.toShowResults = conversation.toShowResults
        conversationRO.pollAnswerText = conversation.pollAnswerText
        conversationRO.replyChatRoomId = conversation.replyChatroomId
        conversationRO.conversationStatus = conversation.conversationStatus
        if let savedAnswer {
            realm.beginAsyncWrite {
                realm.delete(savedAnswer)
            }
        }
        conversationRO.widgetId = conversation.widgetId
        if conversation.widget != nil {
            let widgetRO = convertWidgetToWidgetRO(conversation.widget!)
            conversationRO.widget = widgetRO
        }
        return conversationRO
    }

    /**
     * Converts a `Widget` object into a `WidgetRO` object for storage in Realm.
     * This method ensures that all the relevant data from a `Widget` is transferred and converted to its Realm-compatible counterpart.
     * - Parameter widget: The `Widget` object to be converted.
     * - Returns: A `WidgetRO` object containing the converted data.
     */
    static func convertWidgetToWidgetRO(_ widget: Widget) -> WidgetRO {
        let widgetRO = WidgetRO()
        widgetRO.id = widget.id ?? ""
        widgetRO.parentEntityId = widget.parentEntityID ?? ""
        widgetRO.parentEntityType = widget.parentEntityType ?? ""

        if let metadata = widget.metadata {
            do {
                let jsonData = try JSONSerialization.data(
                    withJSONObject: metadata)
                widgetRO.metadata = jsonData
            } catch {
                print("Error serializing metadata: \(error)")
            }
        }

        if let lmMeta = widget.lmMeta {
            do {
                let jsonData = try JSONSerialization.data(
                    withJSONObject: lmMeta)
                widgetRO._lm_meta = jsonData
            } catch {
                print("Error serializing lmMeta: \(error)")
            }
        }

        widgetRO.createdAt = Int64(widget.createdAt ?? 0)
        widgetRO.updatedAt = Int64(widget.updatedAt ?? 0)
        return widgetRO
    }

    /**
     * Use this function to convert for api response
     *
     * convert [_Conversation_] to [ConversationRO]
     * @param realm: instance of realm
     * @param conversation: Conversation object to converted
     * @param member: [MemberRO] object of conversation's creator
     * @param loggedInMember: Object of logged in member
     * */
    static func convertConversation(
        conversation: _Conversation_?,
        member: MemberRO?
    ) -> ConversationRO? {
        /**
         * Conversation is invalid without chatroomId, conversationId, Member object
         */
        let realm = RealmManager.realmInstance()
        guard let conversation,
            let chatroomId = conversation.chatroomId,
            let communityId = conversation.communityId,
            let memberRO = member
                ?? ChatDBUtil.shared.getConversationMember(
                    realm: realm,
                    conversation: conversation
                )
        else { return nil }

        let savedAnswer: ConversationRO?
        if conversation.hasReactions == true
            || ConversationState.isPoll(stateValue: conversation.state)
            || (conversation.attachmentCount ?? 0) > 0
            || conversation.replyConversationId != nil
        {
            savedAnswer = ChatDBUtil.shared.getConversation(
                realm: realm, conversationId: conversation.id)
        } else {
            savedAnswer = nil
        }

        let replyConversation: ConversationRO?
        if let replyConversationId = conversation.replyConversationId,
            !replyConversationId.isEmpty
        {
            replyConversation =
                savedAnswer?.replyConversation
                ?? ChatDBUtil.shared.getConversation(
                    realm: realm,
                    conversationId: conversation.replyConversationId)
        } else {
            replyConversation = nil
        }

        let attachmentList = convertUpdatedAttachments(
            chatroomId: chatroomId, communityId: communityId,
            attachments: conversation.attachments ?? [],
            oldAttachments: savedAnswer?.attachments ?? List())
        let reactionsList = Self.convertReactions(
            realm: realm, communityId: communityId,
            reactions: conversation.reactions)
        let pollsList = convertPolls(
            realm: realm, polls: conversation.polls, communityId: communityId)

        var createdEpoch = conversation.createdEpoch ?? 0
        if !TimeUtil.isInMillis(createdEpoch) {
            createdEpoch = createdEpoch * 1000
        }
        let conversationRO = ConversationRO()
        conversationRO.id = conversation.id ?? ""
        conversationRO.answer = conversation.answer
        conversationRO.state = conversation.state
        conversationRO.createdEpoch = createdEpoch
        conversationRO.communityId = communityId
        conversationRO.member = memberRO
        conversationRO.chatroomId = chatroomId
        conversationRO.createdAt = conversation.createdAt
        conversationRO.attachments = attachmentList
        conversationRO.link = convertLink(
            chatroomId: chatroomId, communityId: communityId,
            link: conversation.ogTags)
        conversationRO.date = conversation.date
        conversationRO.isEdited = conversation.isEdited
        conversationRO.replyConversationId = conversation.replyConversationId
        conversationRO.replyConversation = replyConversation
        conversationRO.deletedBy = conversation.deletedBy
        conversationRO.attachmentCount = conversation.attachmentCount
        conversationRO.attachmentsUploaded = conversation.attachmentUploaded
        conversationRO.uploadWorkerUUID =
            savedAnswer?.uploadWorkerUUID ?? conversation.uploadWorkerUUID
        conversationRO.localSavedEpoch = conversation.localCreatedEpoch ?? 0
        conversationRO.temporaryId = conversation.temporaryId
        conversationRO.reactions = reactionsList
        conversationRO.isAnonymous = conversation.isAnonymous
        conversationRO.allowAddOption = conversation.allowAddOption
        conversationRO.pollType = conversation.pollType
        conversationRO.pollTypeText = conversation.pollTypeText
        conversationRO.submitTypeText = conversation.submitTypeText
        conversationRO.expiryTime = conversation.expiryTime ?? 0
        conversationRO.multipleSelectNum = conversation.multipleSelectNum
        conversationRO.multipleSelectState = conversation.multipleSelectState
        conversationRO.polls = pollsList
        conversationRO.toShowResults = conversation.toShowResults
        conversationRO.pollAnswerText = conversation.pollAnswerText
        conversationRO.replyChatRoomId = conversation.replyChatroomId
        conversationRO.conversationStatus = .sent
        if let savedAnswer {
            RealmManager.delete(savedAnswer)
        }
        conversationRO.widgetId = conversation.widgetId
        if conversation.widget != nil {
            let widgetRO = convertWidgetToWidgetRO(conversation.widget!)
            conversationRO.widget = widgetRO

        }
        return conversationRO
    }

    /**
     * Use this function to convert sync conversation/chatroom
     *
     * convert [_Conversation_] to [ConversationRO]
     * @param realm: instance of realm
     * @param conversation: Conversation object to converted
     * @param creator: [MemberRO] object of conversation's creator
     * @param polls: [List<Poll>] list of polls
     * @param attachments: [List<CollabcardAttachment>] list of attachments
     * @param reactions: [List<ReactionMeta>] list of reactions
     * */
    static func convertConversation(
        realm: Realm,
        conversation: _Conversation_?,
        creator: MemberRO?,
        polls: [Poll]?,
        attachments: [Attachment]?,
        widgets: [String: Widget]?,
        reactions: [ReactionMeta]?,
        loggedInUUID: String?,
        deletedByMemberRO: MemberRO?
    ) -> ConversationRO? {
        guard let conversation,
            let creator,
            let chatroomId = conversation.chatroomId,
            let communityId = conversation.communityId
        else { return nil }

        var createdEpoch = conversation.createdEpoch ?? 0
        if !TimeUtil.isInMillis(createdEpoch) {
            createdEpoch = createdEpoch * 1000
        }

        //get existing conversation from db to update the existing values
        let savedAnswer: ConversationRO?
        if conversation.hasReactions == true
            || ConversationState.isPoll(stateValue: conversation.state)
            || (conversation.attachmentCount ?? 0) > 0
            || conversation.replyConversationId != nil
        {
            savedAnswer = ChatDBUtil.shared.getConversation(
                realm: realm, conversationId: conversation.id)
        } else {
            savedAnswer = nil
        }

        //get replied conversation
        let replyConversation: ConversationRO?
        if let replyConversationId = conversation.replyConversationId,
            !replyConversationId.isEmpty
        {
            replyConversation =
                savedAnswer?.replyConversation
                ?? ChatDBUtil.shared.getConversation(
                    realm: realm,
                    conversationId: conversation.replyConversationId)
        } else {
            replyConversation = nil
        }

        //get attachments as per saved and new conversation
        let updatedAttachments = convertUpdatedAttachments(
            chatroomId: chatroomId, communityId: communityId,
            attachments: attachments ?? [],
            oldAttachments: savedAnswer?.attachments ?? List())

        let reactionsRO = Self.convertReactionsMeta(
            realm: realm, communityId: communityId, reactions: reactions)
        let pollsRO = convertPolls(
            realm: realm, polls: polls ?? conversation.polls,
            communityId: communityId)

        let linkRO = convertLink(
            chatroomId: chatroomId, communityId: communityId,
            link: conversation.ogTags)

        let conversationRO = ConversationRO()
        conversationRO.id = conversation.id ?? ""
        conversationRO.answer = conversation.answer
        conversationRO.state = conversation.state
        conversationRO.createdEpoch = createdEpoch

        conversationRO.chatroomId = chatroomId
        conversationRO.communityId = communityId
        conversationRO.member = creator

        conversationRO.createdAt = conversation.createdAt
        conversationRO.lastUpdatedAt = conversation.lastUpdated ?? 0
        conversationRO.date = conversation.date
        conversationRO.isEdited = conversation.isEdited

        conversationRO.replyChatRoomId = conversation.replyChatroomId
        conversationRO.replyConversationId = conversation.replyConversationId
        conversationRO.replyConversation = replyConversation

        conversationRO.deletedBy = conversation.deletedBy
        conversationRO.deletedByMember = deletedByMemberRO
        conversationRO.attachmentCount = conversation.attachmentCount
        conversationRO.attachmentsUploaded = conversation.attachmentUploaded
        conversationRO.uploadWorkerUUID = savedAnswer?.uploadWorkerUUID
        conversationRO.attachments = updatedAttachments
        conversationRO.link = linkRO

        conversationRO.localSavedEpoch = conversation.localCreatedEpoch ?? 0

        conversationRO.temporaryId = conversation.temporaryId

        conversationRO.reactions = reactionsRO

        conversationRO.isAnonymous = conversation.isAnonymous
        conversationRO.allowAddOption = conversation.allowAddOption
        conversationRO.pollType = conversation.pollType
        conversationRO.pollTypeText = conversation.pollTypeText
        conversationRO.submitTypeText = conversation.submitTypeText
        conversationRO.expiryTime = conversation.expiryTime ?? 0
        conversationRO.multipleSelectNum = conversation.multipleSelectNum
        conversationRO.multipleSelectState = conversation.multipleSelectState
        conversationRO.polls = pollsRO
        conversationRO.toShowResults = conversation.toShowResults
        conversationRO.pollAnswerText = conversation.pollAnswerText
        conversationRO.conversationStatus = .sent
        if let savedAnswer {
            realm.delete(savedAnswer)
        }
        if conversation.widgetId != nil && !conversation.widgetId!.isEmpty {
            conversationRO.widgetId = conversation.widgetId
            guard let widget = widgets?[conversation.widgetId!] else {
                return conversationRO
            }
            let widgetRO = convertWidgetToWidgetRO(widget)
            conversationRO.widget = widgetRO
        }
        return conversationRO
    }

    /**
     * convert [_Conversation_] to [LastConversationRO] from new sync workers
     * @param realm: instance of realm
     * @param conversation: Conversation object to converted
     * @param creator: [MemberRO] object of conversation's creator
     * @param attachments: [List<_Attachment_>] list of attachments
     * */
    static func convertLastConversation(
        realm: Realm,
        conversation: _Conversation_?,
        creator: MemberRO?,
        attachments: [Attachment]?,
        deletedByMember: MemberRO?
    ) -> LastConversationRO? {
        guard let conversation,
            let creator,
            let chatroomId = conversation.chatroomId,
            let communityId = conversation.communityId
        else { return nil }

        var createdEpoch = conversation.createdEpoch ?? 0
        if !TimeUtil.isInMillis(createdEpoch) {
            createdEpoch = createdEpoch * 1000
        }

        //get existing conversation from db to update the existing values
        let savedAnswer: ConversationRO?
        if conversation.hasReactions == true
            || ConversationState.isPoll(stateValue: conversation.state)
            || (conversation.attachmentCount ?? 0) > 0
            || conversation.replyConversationId != nil
        {
            savedAnswer = ChatDBUtil.shared.getConversation(
                realm: RealmManager.realmInstance(),
                conversationId: conversation.id)
        } else {
            savedAnswer = nil
        }

        //get attachments as per saved and new conversation
        let updatedAttachments = convertUpdatedAttachments(
            chatroomId: chatroomId, communityId: communityId,
            attachments: attachments ?? [],
            oldAttachments: savedAnswer?.attachments ?? List())

        //Clear embedded object list if already present else calling insertToRealmOrUpdate will duplicate it
        //        savedAnswer?.attachments?.deleteAllFromRealm()

        let lastConversationRO = LastConversationRO()
        lastConversationRO.id = conversation.id
        lastConversationRO.answer = conversation.answer
        lastConversationRO.state = conversation.state
        lastConversationRO.createdEpoch = createdEpoch
        lastConversationRO.member = creator
        lastConversationRO.createdAt = conversation.createdAt
        lastConversationRO.attachments = updatedAttachments
        lastConversationRO.attachmentCount = conversation.attachmentCount
        lastConversationRO.date = conversation.date
        lastConversationRO.deletedBy = conversation.deletedBy
        lastConversationRO.deletedByMember = deletedByMember
        lastConversationRO.attachmentsUploaded = conversation.attachmentUploaded
        lastConversationRO.uploadWorkerUUID = savedAnswer?.uploadWorkerUUID
        lastConversationRO.createdEpoch = createdEpoch
        lastConversationRO.chatroomId = chatroomId
        lastConversationRO.communityId = communityId
        lastConversationRO.conversationStatus = .sent
        lastConversationRO.widgetId = conversation.widgetId

        if let widget = conversation.widget {
            lastConversationRO.widget = convertWidgetToWidgetRO(widget)
        }
        return lastConversationRO
    }

    /**
     * Converts a `Conversation` object into a `LastConversationRO`.
     * This method is used to update or create a new `LastConversationRO` object for the given conversation.
     * - Parameters:
     *   - realm: The `Realm` instance for database operations.
     *   - conversation: The `Conversation` object to be converted.
     *   - creator: The `MemberRO` representing the creator of the conversation.
     *   - attachments: An optional list of `Attachment` objects associated with the conversation.
     *   - deletedByMember: An optional `MemberRO` representing the member who deleted the conversation, if applicable.
     * - Returns: A `LastConversationRO` object representing the converted conversation or `nil` if the input is invalid.
     */
    static func convertLastConversation(
        realm: Realm,
        conversation: Conversation?,
        creator: MemberRO?,
        attachments: [Attachment]?,
        deletedByMember: MemberRO?
    ) -> LastConversationRO? {
        guard let conversation,
            let creator,
            let chatroomId = conversation.chatroomId,
            let communityId = conversation.communityId
        else { return nil }

        var createdEpoch = conversation.createdEpoch ?? 0
        if !TimeUtil.isInMillis(createdEpoch) {
            createdEpoch = createdEpoch * 1000
        }

        //get existing conversation from db to update the existing values
        let savedAnswer: ConversationRO?
        if conversation.hasReactions == true
            || ConversationState.isPoll(stateValue: conversation.state.rawValue)
            || (conversation.attachmentCount ?? 0) > 0
            || conversation.replyConversationId != nil
        {
            savedAnswer = ChatDBUtil.shared.getConversation(
                realm: RealmManager.realmInstance(),
                conversationId: conversation.id)
        } else {
            savedAnswer = nil
        }

        //get attachments as per saved and new conversation
        let updatedAttachments = convertUpdatedAttachments(
            chatroomId: chatroomId, communityId: communityId,
            attachments: attachments ?? [],
            oldAttachments: savedAnswer?.attachments ?? List())

        //Clear embedded object list if already present else calling insertToRealmOrUpdate will duplicate it
        //        savedAnswer?.attachments?.deleteAllFromRealm()

        let lastConversationRO = LastConversationRO()
        lastConversationRO.id = conversation.id
        lastConversationRO.answer = conversation.answer
        lastConversationRO.state = conversation.state.rawValue
        lastConversationRO.createdEpoch = createdEpoch
        lastConversationRO.member = creator
        lastConversationRO.createdAt = conversation.createdAt
        lastConversationRO.attachments = updatedAttachments
        lastConversationRO.attachmentCount = conversation.attachmentCount
        lastConversationRO.date = conversation.date
        lastConversationRO.deletedBy = conversation.deletedBy
        lastConversationRO.deletedByMember = deletedByMember
        lastConversationRO.attachmentsUploaded = conversation.attachmentUploaded
        lastConversationRO.uploadWorkerUUID = savedAnswer?.uploadWorkerUUID
        lastConversationRO.createdEpoch = createdEpoch
        lastConversationRO.chatroomId = chatroomId
        lastConversationRO.communityId = communityId
        lastConversationRO.conversationStatus = conversation.conversationStatus
        lastConversationRO.widgetId = conversation.widgetId

        if let widget = conversation.widget {
            lastConversationRO.widget = convertWidgetToWidgetRO(widget)
        }
        return lastConversationRO
    }

    /**
     * convert [_User_] to [UserRO]
     * @param user: Object of user to be converted
     **/
    static func convertUser(user: User?) -> UserRO? {
        guard let user else { return nil }
        let userRO = UserRO()
        userRO.id = user.id
        userRO.userUniqueId = user.userUniqueID
        userRO.uuid = user.uuid
        userRO.imageUrl = user.imageUrl
        userRO.name = user.name
        userRO.isGuest = user.isGuest
        userRO.organizationName = user.organisationName
        userRO.updatedAt = user.updatedAt ?? 0
        userRO.sdkClientInfoRO = convertSDKClientInfo(user.sdkClientInfo)
        userRO.isDeleted = user.isDeleted
        userRO.customTitle = user.customTitle
        userRO.communityId = user.sdkClientInfo?.community

        let rolesAsStrings = user.roles?.compactMap { $0.rawValue } ?? []

        let rolesAsList = List<String>()
        rolesAsList.append(objectsIn: rolesAsStrings)

        userRO.roles = rolesAsList
        return userRO
    }

    /**
     * convert [UserRO] to [MemberRO] and save it [MemberRO] table
     * @param userRO: object of [UserRO]
     * @param communityId: id of community
     *
     * @return [MemberRO]: object created
     */
    private func convertToMember(userRO: UserRO?, communityId: String?)
        -> MemberRO?
    {
        guard let userRO, let communityId else { return nil }
        let uuid = userRO.sdkClientInfoRO?.uuid ?? ""
        let uid = "\(uuid)#\(communityId)"
        let memberRO = MemberRO()
        memberRO.uid = uid
        memberRO.uuid = uuid
        memberRO.name = userRO.name
        memberRO.id = userRO.id
        memberRO.imageUrl = userRO.imageUrl
        memberRO.customTitle = userRO.customTitle
        memberRO.userUniqueId = userRO.userUniqueId
        memberRO.isGuest = userRO.isGuest
        memberRO.sdkClientInfoRO = userRO.sdkClientInfoRO
        memberRO.communityId = communityId
        memberRO.roles = userRO.roles
        return memberRO
    }

    /**
     * convert [_ReactionMeta_] to [ReactionRO]
     * @param realm: Instance of realm
     * @param reactions: List of [_ReactionMeta_] to converted
     * @param communityId: id of the community
     *
     * @return list of [ReactionRO]
     * */
    static func convertReactionsMeta(
        realm: Realm,
        communityId: String?,
        reactions: [ReactionMeta]?
    ) -> List<ReactionRO> {
        guard let communityId, let reactions else { return List() }
        let metaReactions = reactions.compactMap({ reactionMeta in
            return convertReactionMeta(
                realm: RealmManager.realmInstance(), reaction: reactionMeta,
                communityId: communityId)
        })
        let list = List<ReactionRO>()
        list.append(objectsIn: metaReactions)
        return list
    }

    /**
     * convert [_ReactionMeta_] to [ReactionRO]
     * @param realm: Instance of realm
     * @param reaction: [_ReactionMeta_] to converted
     * @param communityId: id of the community
     *
     * @return [ReactionRO]
     * */
    static func convertReactionMeta(
        realm: Realm,
        reaction: ReactionMeta,
        communityId: String?
    ) -> ReactionRO? {
        let memberRO = Self.convertMember(
            member: reaction.member, communityId: communityId ?? "")

        let reactionRO = ReactionRO()
        reactionRO.member = memberRO
        reactionRO.reaction = reaction.reaction
        return reactionRO
    }

}
