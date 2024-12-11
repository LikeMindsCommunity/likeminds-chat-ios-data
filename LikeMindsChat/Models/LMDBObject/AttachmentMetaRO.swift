//
//  AttachmentMetaRO.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 01/01/24.
//

import Foundation
import RealmSwift

class AttachmentMetaRO: EmbeddedObject {
    @Persisted var numberOfPage: Int?
    @Persisted var size: Int?
    @Persisted var duration: Int?
}
