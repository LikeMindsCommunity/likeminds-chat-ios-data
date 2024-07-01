//
//  CheckDMChatroomResponse.swift
//  CollabMates
//
//  Created by Pushpendra Singh on 09/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

public struct CheckDMChatroomResponse: Decodable {
    let chatroom_: _Chatroom_?
    
    public var chatroom: Chatroom? {
        return ModelConverter.shared.convertChatroom(chatroom: chatroom_)
    }
}
