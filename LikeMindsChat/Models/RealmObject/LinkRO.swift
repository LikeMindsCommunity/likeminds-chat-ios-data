//
//  LinkRO.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 01/01/24.
//

import Foundation
import RealmSwift

class LinkRO: EmbeddedObject {
    @Persisted var chatroomId: String?
    @Persisted var communityId: String?
    @Persisted var title: String?
    @Persisted var image: String?
    @Persisted var linkDescription: String?
    @Persisted var link: String?
}
