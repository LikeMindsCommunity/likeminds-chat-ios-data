//
//  ConversationUtil.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

enum LoadConversationType: Int {
    case FIRST_TIME = 1,
    FIRST_TIME_BACKGROUND,
    REOPEN
}

enum GetConversationType: Int {
    case NONE = 0,
    BELOW,
    ABOVE,
    TOP,
    BOTTOM
}

enum GetConversationCountType: Int {
    case NONE = 0,
    BELOW,
    ABOVE
}
