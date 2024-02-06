//
//  RealmDatabaseObserver.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 05/02/24.
//

import Foundation

public enum RealmDatabaseAction {
    case add
    case insert
    case update
    case remove
}

protocol RealmDatabaseObserver: AnyObject {
    func realmDatabaseObserver(_ action: RealmDatabaseAction) 
}
