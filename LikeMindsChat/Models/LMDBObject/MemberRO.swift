//
//  MemberROModel.swift
//  RealmRestSync
//
//  Created by Pushpendra Singh on 19/12/23.
//  Copyright © 2023 LikeMinds Chat. All rights reserved.
//

import Foundation
import RealmSwift

class MemberRO: Object {
    @Persisted(primaryKey: true) var uid: String?
    @Persisted var id: String?
    @Persisted var name: String?
    @Persisted var imageUrl: String?
    @Persisted var state: Int?
    @Persisted var customIntroText: String?
    @Persisted var customClickText: String?
    @Persisted var customTitle: String?
    @Persisted var communityId: String?
    @Persisted var isOwner: Bool? = false
    @Persisted var isGuest: Bool? = false
    @Persisted var userUniqueId: String?
    @Persisted var uuid: String?
    @Persisted var sdkClientInfoRO: SDKClientInfoRO?
    @Persisted var roles: List<String> = List()
}
