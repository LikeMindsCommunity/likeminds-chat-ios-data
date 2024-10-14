//
//  UserRO.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 05/02/24.
//

import Foundation
import RealmSwift

class UserRO: Object {
    @Persisted(primaryKey: true) var userUniqueId: String?
    @Persisted var id: String?
    @Persisted var name: String?
    @Persisted var imageUrl: String?
    @Persisted var customTitle: String?
    @Persisted var communityId: Int?
    @Persisted var organizationName: String?
    @Persisted var updatedAt: Int = 0
    @Persisted var isDeleted: Bool?
    @Persisted var isGuest: Bool?
    @Persisted var uuid: String?
    @Persisted var sdkClientInfoRO: SDKClientInfoRO?
    @Persisted var roles: List<String> = List()
