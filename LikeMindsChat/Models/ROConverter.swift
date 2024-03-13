//
//  ROConverter.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 09/01/24.
//

import Foundation
import RealmSwift

class ROConverter {
    
    static func convertCommunity(_ community: Community?) -> CommunityRO? {
        guard let community else { return nil }
        let communityRO = CommunityRO()
        communityRO.id = "\(community.id ?? 0)"
        communityRO.name = community.name
        communityRO.imageUrl = community.imageURL
        communityRO.updatedAt = community.updatedAt
        return communityRO
    }
    
    static func convertMember(member: Member?, communityId: String) -> MemberRO? {
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
        
        //if customTitle == "Member" then save null else member.customTitle()
        if (member.customTitle?.lowercased() == "member") {
            memberRO.customTitle = nil
        } else {
            memberRO.customTitle =  member.customTitle
        }
        memberRO.isOwner = member.isOwner
        memberRO.isGuest = member.isGuest
        memberRO.userUniqueId = member.userUniqueId
        memberRO.sdkClientInfoRO = convertSDKClientInfo(member.sdkClientInfo)
        return memberRO
    }
    
    static func convertSDKClientInfo(_ sdkClientInfo: SDKClientInfo?) -> SDKClientInfoRO? {
        guard let sdkClientInfo else { return nil }
        let sdkClientInfoRO = SDKClientInfoRO()
        sdkClientInfoRO.community = sdkClientInfo.community
        sdkClientInfoRO.user = "\(sdkClientInfo.user ?? 0)"
        sdkClientInfoRO.uuid = sdkClientInfo.uuid
        sdkClientInfoRO.userUniqueId = sdkClientInfo.userUniqueID
        return sdkClientInfoRO
    }
    
    static func convertChatroom(fromChatroomJsonModel chatroom: _Chatroom_,
                                chatroomCreatorRO: MemberRO,
                                lastConversationRO: LastConversationRO? = nil,
                                reactions: [ReactionMeta] = []) -> ChatroomRO? {
       guard let chatroomId = chatroom.id,
             let communityId = chatroom.communityId else { return nil }
        
        let savedChatroom = ChatDBUtil.shared.getChatroom(realm: RealmManager.realmInstance(), chatroomId: chatroomId)
        let reactionsRO = Self.convertReactionsMeta(realm: RealmManager.realmInstance(), communityId: communityId, reactions: reactions)
        
        let chatroomRO = ChatroomRO()
        chatroomRO.id = chatroomId
        chatroomRO.state = chatroom.state ?? 0
        chatroomRO.member = chatroomCreatorRO
        chatroomRO.createdAt = chatroom.createdAt
        chatroomRO.type = chatroom.type
        chatroomRO.chatroomImageUrl = chatroom.chatroomImageUrl
        chatroomRO.header = chatroom.header
        chatroomRO.cardCreationTime = chatroom.cardCreationTime
        chatroomRO.totalResponseCount = savedChatroom?.totalResponseCount ?? 0
        chatroomRO.totalAllResponseCount = savedChatroom?.totalAllResponseCount ?? 0
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
        chatroomRO.accessWithoutSubscription = chatroom.accessWithoutSubscription == true
        chatroomRO.unreadConversationsCount = chatroom.unreadConversationCount
        
        chatroomRO.reactions = reactionsRO ?? List()
        
        let updatedAt = lastConversationRO?.createdEpoch
        ?? savedChatroom?.lastConversationRO?.createdEpoch
        ?? chatroom.createdAt
        
        chatroomRO.updatedAt = updatedAt
        
        chatroomRO.lastSeenConversationId = chatroom.lastSeenConversationId
        chatroomRO.lastSeenConversation = savedChatroom?.lastSeenConversation
        
        chatroomRO.lastConversationId = chatroom.lastConversationId
        chatroomRO.lastConversation = savedChatroom?.lastConversation
        chatroomRO.lastConversationRO = lastConversationRO ?? savedChatroom?.lastConversationRO
        
        chatroomRO.unseenCount = chatroom.unseenCount ?? 0
        chatroomRO.dateEpoch = chatroom.dateEpoch
        chatroomRO.draftConversation = savedChatroom?.draftConversation //to maintain un-send conversation
        chatroomRO.isSecret = chatroom.isSecret
        //        chatroomRO.secretChatRoomParticipants = chatroom.secretChatroomParticipants.toRealmList()
        chatroomRO.secretChatRoomLeft = chatroom.secretChatroomLeft
        chatroomRO.topicId = chatroom.topicId ?? savedChatroom?.topicId
        chatroomRO.topic = savedChatroom?.topic
        chatroomRO.isConversationStored = savedChatroom?.isConversationStored ?? false
        return chatroomRO
    }
    
    /**
     * convert [_Attachment_] to [AttachmentRO]
     * @param chatroomId: id of the chatroom
     * @param communityId: id of the community
     * @param attachment: [_Attachment_] to be converted
     * */
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
        return attachmentRO
    }
    
    /**
     * convert [_AttachmentMeta_] to [AttachmentMetaRO]
     * @param meta: [_AttachmentMeta_] to be converted
     * */
    private static func convertAttachmentMeta(meta: AttachmentMeta?) -> AttachmentMetaRO {
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
                convertAttachment(chatroomId: chatroomId, communityId: communityId, attachment: attachment)
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
            convertAttachment(chatroomId: chatroomId, communityId: communityId, attachment: attachment)
        }
        let roAttachs = List<AttachmentRO>()
        roAttachs.append(objectsIn: attachs)
        return roAttachs
    }
    
    /**
     * convert [_Poll_] to [PollRO]
     * @param realm: Instance of realm
     * @param polls: List of [_Poll_] to converted
     * @param communityId: id of the community
     *
     * @return list of [PollRO]
     * */
    private static func convertPolls(
        realm: Realm,
        polls: [Poll]?,
        communityId: String?
    ) -> List<PollRO> {
        
        let pollsData = (polls ?? []).compactMap { poll in
            convertPoll(realm: realm, communityId: communityId, poll: poll, uuid: nil)
        }
        let pollsList = List<PollRO>()
        pollsList.append(objectsIn: pollsData)
        return pollsList
    }
    
    /**
     * convert [_Poll_] to [PollRO]
     * @param realm: Instance of realm
     * @param poll: [_Poll_] to converted
     * @param communityId: id of the community
     * @param memberId: id of the member who created the poll
     *
     * @return list of [PollRO]
     * */
    static func convertPoll(
        realm: Realm,
        communityId: String?,
        poll: Poll?,
        uuid: String?
    ) -> PollRO? {
        guard let poll, communityId == nil else { return nil }
        let pollRO = PollRO()
        pollRO.id = poll.id ?? ""
        pollRO.text = poll.text ?? ""
        pollRO.subText = poll.subText
        pollRO.isSelected = poll.isSelected
        pollRO.percentage = poll.percentage
        pollRO.noVotes = poll.noVotes
//        pollRO.member = ChatDBUtil.getMember(realm, communityId, uuid)
        return pollRO
    }
    
    private static func convertReactions(
        realm: Realm,
        communityId: String?,
        reactions: [Reaction]?
    ) -> List<ReactionRO> {
        
        let reactionsData = (reactions ?? []).compactMap { reaction in
           convertReaction(realm: realm, reaction: reaction, communityId: communityId)
        }
        let reactionList = List<ReactionRO>()
        reactionList.append(objectsIn: reactionsData)
        return reactionList
    }
    
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
     * convert [_LinkOGTags_] to [LinkRO]
     * @param chatroomId: id of the chatroom
     * @param communityId: id of the community
     * @param link: [_LinkOGTags_] to be converted
     *
     * @return [LinkRO]
     * */
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
        guard let conversation,
              let chatroomId = conversation.chatroomId,
              let communityId = conversation.communityId,
              let memberRO = member ?? ChatDBUtil.shared.getConversationMember(
                realm: RealmManager.realmInstance(),
                conversation: conversation
              ) else { return nil }
        
        let savedAnswer: ConversationRO?
        if conversation.hasReactions == true || ConversationState.isPoll(stateValue: conversation.state) || (conversation.attachmentCount ?? 0) > 0 || conversation.replyConversationId != nil {
            savedAnswer = ChatDBUtil.shared.getConversation(realm: RealmManager.realmInstance(), conversationId: conversation.id)
        } else {
            savedAnswer = nil
        }
        
        let replyConversation: ConversationRO?
        if let replyConversationId = conversation.replyConversationId, !replyConversationId.isEmpty {
            replyConversation = savedAnswer?.replyConversation ?? ChatDBUtil.shared.getConversation(realm: RealmManager.realmInstance(), conversationId: conversation.replyConversationId)
        } else {
            replyConversation = nil
        }
        
        let attachmentList = convertUpdatedAttachments(chatroomId: chatroomId, communityId: communityId, attachments: conversation.attachments ?? [], oldAttachments: savedAnswer?.attachments ?? List())
        let reactionsList = Self.convertReactions(realm: RealmManager.realmInstance(), communityId: communityId, reactions: conversation.reactions)
        let pollsList = convertPolls(realm: RealmManager.realmInstance(), polls: conversation.polls, communityId: communityId)

            
            //Clear embedded object list if already present else calling insertToRealmOrUpdate will duplicate it
//        savedAnswer?.reactions.deleteAllFromRealm()
//        savedAnswer?.attachments?.deleteAllFromRealm()
//        savedAnswer?.polls?.deleteAllFromRealm()
            
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
            conversationRO.link = convertLink(chatroomId: chatroomId, communityId: communityId, link: conversation.ogTags)
            conversationRO.date = conversation.date
            conversationRO.isEdited = conversation.isEdited
            conversationRO.replyConversationId = conversation.replyConversationId
            conversationRO.replyConversation = replyConversation
            conversationRO.deletedBy = conversation.deletedBy
            conversationRO.attachmentCount = conversation.attachmentCount
            conversationRO.attachmentsUploaded = conversation.attachmentUploaded
            conversationRO.uploadWorkerUUID = savedAnswer?.uploadWorkerUUID ?? conversation.uploadWorkerUUID
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
        reactions: [ReactionMeta]?,
        loggedInUUID: String?,
        deletedByMemberRO: MemberRO?
    ) -> ConversationRO? {
        guard let conversation,
              let creator,
              let chatroomId = conversation.chatroomId,
              let communityId = conversation.communityId else { return nil }
        
        var createdEpoch = conversation.createdEpoch ?? 0
        if !TimeUtil.isInMillis(createdEpoch) {
            createdEpoch = createdEpoch * 1000
        }
        
        //get existing conversation from db to update the existing values
        let savedAnswer: ConversationRO?
        if conversation.hasReactions == true || ConversationState.isPoll(stateValue: conversation.state) || (conversation.attachmentCount ?? 0) > 0 || conversation.replyConversationId != nil {
            savedAnswer = ChatDBUtil.shared.getConversation(realm: RealmManager.realmInstance(), conversationId: conversation.id)
        } else {
            savedAnswer = nil
        }
        
        //get replied conversation
        let replyConversation: ConversationRO?
        if let replyConversationId = conversation.replyConversationId, !replyConversationId.isEmpty {
            replyConversation = savedAnswer?.replyConversation ?? ChatDBUtil.shared.getConversation(realm: RealmManager.realmInstance(), conversationId: conversation.replyConversationId)
        } else {
            replyConversation = nil
        }
        
        //get attachments as per saved and new conversation
        let updatedAttachments = convertUpdatedAttachments(chatroomId: chatroomId, communityId: communityId, attachments: conversation.attachments ?? [], oldAttachments: savedAnswer?.attachments ?? List())
        
        let reactionsRO = convertReactions(realm: RealmManager.realmInstance(), communityId: communityId, reactions: conversation.reactions)
        
        let pollsRO = convertPolls(realm: RealmManager.realmInstance(), polls: conversation.polls, communityId: communityId)
        
        let linkRO = convertLink(chatroomId: chatroomId, communityId: communityId, link: conversation.ogTags)

        //Clear embedded object list if already present else calling insertToRealmOrUpdate will duplicate it
//        savedAnswer?.attachments?.deleteAllFromRealm()
//        savedAnswer?.reactions?.deleteAllFromRealm()
//        savedAnswer?.polls?.deleteAllFromRealm()
        
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
              let communityId = conversation.communityId else { return nil }
        
        var createdEpoch = conversation.createdEpoch ?? 0
        if !TimeUtil.isInMillis(createdEpoch) {
            createdEpoch = createdEpoch * 1000
        }
        
        //get existing conversation from db to update the existing values
        let savedAnswer: ConversationRO?
        if conversation.hasReactions == true || ConversationState.isPoll(stateValue: conversation.state) || (conversation.attachmentCount ?? 0) > 0 || conversation.replyConversationId != nil {
            savedAnswer = ChatDBUtil.shared.getConversation(realm: RealmManager.realmInstance(), conversationId: conversation.id)
        } else {
            savedAnswer = nil
        }
        
        //get attachments as per saved and new conversation
        let updatedAttachments = convertUpdatedAttachments(chatroomId: chatroomId, communityId: communityId, attachments: conversation.attachments ?? [], oldAttachments: savedAnswer?.attachments ?? List())
        
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
        return lastConversationRO
    }
    
    /**
     * convert [_User_] to [UserRO]
     * @param user: Object of user to be converted
     * */

    static func convertUser(user: User?) -> UserRO? {
        guard let user else { return nil }
        let userRO = UserRO()
        userRO.id = user.id
        userRO.userUniqueId = user.userUniqueID
        userRO.imageUrl = user.imageUrl
        userRO.name = user.name
        userRO.isGuest = user.isGuest
        userRO.organizationName = user.organisationName
        userRO.updatedAt = user.updatedAt ?? 0
        userRO.sdkClientInfoRO = convertSDKClientInfo(user.sdkClientInfo)
        userRO.isDeleted = user.isDeleted
        userRO.customTitle = user.customTitle
        return userRO
    }

    
    /**
     * convert [UserRO] to [MemberRO] and save it [MemberRO] table
     * @param userRO: object of [UserRO]
     * @param communityId: id of community
     *
     * @return [MemberRO]: object created
     */

    private func convertToMember(userRO: UserRO?, communityId: String?) -> MemberRO? {
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
//        ChatDBUtil.writeAsync({
//            it.insertOrUpdate(memberRO)
//        })
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
    ) -> List<ReactionRO>? {
        guard let communityId, let reactions else { return nil }
        let metaReactions = reactions.compactMap({ reactionMeta in
            return convertReactionMeta(realm: RealmManager.realmInstance(), reaction: reactionMeta, communityId: communityId)
        })
        let list = List<ReactionRO>()
        list.append(objectsIn: metaReactions)
        return List()
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
        let memberRO = Self.convertMember(member: reaction.member, communityId: communityId ?? "")
        
        let reactionRO = ReactionRO()
        reactionRO.member = memberRO
        reactionRO.reaction = reaction.reaction
        return reactionRO
    }
    
}
    
