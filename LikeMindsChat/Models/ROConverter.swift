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
        memberRO.communityId = Int(communityId)
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
        sdkClientInfoRO.user = "\(sdkClientInfo.user)"
        sdkClientInfoRO.uuid = sdkClientInfo.uuid
        sdkClientInfoRO.userUniqueId = sdkClientInfo.userUniqueID
        return sdkClientInfoRO
    }
    
    static func convertChatroom(fromChatroomJsonModel chatroom: _Chatroom_, 
                                chatroomCreatorRO: MemberRO,
                                lastConversationRO: LastConversationRO? = nil,
                                reactions: [ReactionMeta] = []) -> ChatroomRO {
        let chatroomId = chatroom.id
        let communityId = chatroom.communityId ?? ""
        
        let savedChatroom = ChatDBUtil.shared.getChatroom(realm: RealmManager.realmInstance(), chatroomId: chatroomId)
        let reactionsRO = Self.convertReactionsMeta(realm: RealmManager.realmInstance(), communityId: communityId, reactions: reactions)
        
        let chatroomRO = ChatroomRO()
        chatroomRO.state = chatroom.state
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
        
        var updatedAt = lastConversationRO?.createdEpoch
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
