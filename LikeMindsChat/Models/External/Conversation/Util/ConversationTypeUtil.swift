//
//  ConversationUtil.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public enum LoadConversationType: Int {
    case firstTime = 1,
    firstTimeBackground,
    reopen
}

public enum GetConversationType: Int {
    case none = 0,
    below,
    above,
    top,
    bottom
}

public enum GetConversationCountType: Int {
    case none = 0,
    below,
    above
}
