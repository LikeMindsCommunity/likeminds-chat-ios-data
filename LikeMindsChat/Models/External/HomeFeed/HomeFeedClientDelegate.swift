//
//  HomeFeedClientDelegate.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 13/02/24.
//

import Foundation

public protocol RealmObjectChangeObserver: AnyObject {
}

public protocol HomeFeedClientObserver: RealmObjectChangeObserver {
    
    func initial(_ chatrooms: [Chatroom])
    func onChange(removed: [Int], inserted: [(Int, Chatroom)], updated: [(Int, Chatroom)])
    
}
