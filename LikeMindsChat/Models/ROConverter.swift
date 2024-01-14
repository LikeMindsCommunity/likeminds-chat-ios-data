//
//  ROConverter.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 09/01/24.
//

import Foundation

class ROConverter {
    
    static func convertCommunity(_ community: _Community_?) -> CommunityRO? {
        guard let community else { return nil }
        let communityRO = CommunityRO()
        communityRO.id = "\(community.id ?? 0)"
        communityRO.name = community.name
        communityRO.imageUrl = community.imageURL
        communityRO.updatedAt = community.updatedAt
        return communityRO
    }
    
    static func convertMember(member: _Member_?, communityId: String) -> MemberRO? {
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
        memberRO.sdkClientInfoRO = convertSDKClientInfo(sdkClientInfo: member.sdkClientInfo)
        return memberRO
    }
    
    static func convertSDKClientInfo(sdkClientInfo: SDKClientInfo?) -> SDKClientInfoRO? {
        guard let sdkClientInfo else { return nil }
        let sdkClientInfoRO = SDKClientInfoRO()
        sdkClientInfoRO.community = sdkClientInfo.community
        sdkClientInfoRO.user = "\(sdkClientInfo.user)"
        sdkClientInfoRO.uuid = sdkClientInfo.uuid
        sdkClientInfoRO.userUniqueId = sdkClientInfo.userUniqueID
        return sdkClientInfoRO
    }
    
    static func getChatroomRO(fromChatroomJsonModel chatroom: _Chatroom_) -> ChatroomRO {
        
        return ChatroomRO()
    }
 
}
