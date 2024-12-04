//
//  LMDatabaseObserver.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 05/02/24.
//

import Foundation

public enum LMDatabaseAction {
    case add
    case insert
    case update
    case remove
}

protocol LMDatabaseObserver: AnyObject {
    func realmDatabaseObserver(_ action: LMDatabaseAction) 
}
