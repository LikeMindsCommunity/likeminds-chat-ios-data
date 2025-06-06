//
//  CheckDMChatroomResponse.swift
//  CollabMates
//
//  Created by Pushpendra Singh on 09/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

public struct CheckDMChatroomResponse: Decodable {
    let chatroom: _Chatroom_?
    
    public var chatroomData: Chatroom? {
        return ModelConverter.shared.convertChatroom(chatroom: chatroom)
    }
}
