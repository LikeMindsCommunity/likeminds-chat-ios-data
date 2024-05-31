//
//  GetChatroomActionsResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation


public enum ChatRoomActionType:Int, Codable, CaseIterableDefaultsLast {
    case unknown = -1
    case rename = 1
    case viewParticipants = 2
    case invite = 3
    case follow = 4
    case viewCommunity = 5
    case mute = 6
    case delete = 7
    case unMute = 8
    case unFollow = 9
    case report = 10
    case markActive = 11
    case markInactive = 12
    case pinChatRoom = 13
    case unPinChatRoom = 14
    case leaveChatRoom = 15
    case addAllMembers = 16
    case settings = 17
    case memberCanSendMessage = 18
    case accessWithoutSubscription = 19
    case viewProfile = 21
    case blockDMMember = 27
    case unblockDMMember = 28
    
}

public struct GetChatroomActionsResponse: Decodable {
    public var canAccessSecretChatroom: Bool
    public var chatroomActions: [ChatroomAction]
    public var participantCount: Int
    public var placeHolder: String?
    
    enum CodingKeys: String, CodingKey {
        case canAccessSecretChatroom = "can_access_secret_chatroom"
        case chatroomActions = "chatroom_actions"
        case participantCount = "participant_count"
        case placeHolder = "placeholder"
    }
}

public struct ChatroomAction: Decodable {
    public var id: ChatRoomActionType
    public var title: String
    public var route: String?
}
