//
//  ModelConverterUtil.swift
//  RealmRestSync
//
//  Created by Pushpendra Singh on 19/12/23.
//  Copyright © 2023 LikeMinds Chat. All rights reserved.
//

import Foundation

class ModelConverterUtil {
    
    static func getChatroomRO(fromChatroomJsonModel chatroom: _Chatroom_) -> ChatroomRO {
        
        return ChatroomRO()
    }
    
    static func getChatroom(fromChatroomRO chatroom: ChatroomRO) -> Chatroom {
        
        return Chatroom()
    }
    
}
