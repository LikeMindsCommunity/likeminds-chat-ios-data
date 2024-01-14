//
//  ConversationChangeDelegate.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation


protocol ConversationChangeDelegate: AnyObject {
    func getPostedConversations(conversations: [Conversation]?)
    func getChangedConversations(conversations: [Conversation]?)
    func getNewConversations(conversations: [Conversation]?)
}
