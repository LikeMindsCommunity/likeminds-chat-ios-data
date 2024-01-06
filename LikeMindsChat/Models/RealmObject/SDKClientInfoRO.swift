//
//  SDKClientInfoRO.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 01/01/24.
//

import Foundation
import RealmSwift

class SDKClientInfoRO: Object {
    @Persisted var community: Int?
    @Persisted var user: String?
    @Persisted var userUniqueId: String?
    @Persisted var uuid: String?
}
