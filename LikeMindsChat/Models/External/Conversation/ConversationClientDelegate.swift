//
//  ConversationClientDelegate.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 20/03/24.
//

import Foundation

public protocol ConversationClientObserver: RealmObjectChangeObserver {
    
    func initial(_ conversations: [Conversation])
    func onChange(removed: [Int], inserted: [(Int, Conversation)], updated: [(Int, Conversation)])
    
}
