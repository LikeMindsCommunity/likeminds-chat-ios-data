//
//  BlockMemberResponse.swift
//  CollabMates
//
//  Created by Pushpendra Singh on 10/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation


public struct BlockMemberResponse: Decodable {
    let chatroom: _Chatroom_?
    public let conversation: Conversation?
    
    public var chatroomData: Chatroom? {
        return ModelConverter.shared.convertChatroom(chatroom: chatroom)
    }
}
