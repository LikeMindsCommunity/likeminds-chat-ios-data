//
//  WidgetRO.swift
//  LikeMindsChat
//
//  Created by Anurag Tyagi on 08/11/24.
//

import Foundation
import RealmSwift

class WidgetRO: Object {
    @Persisted(primaryKey: true) var id: String  // Primary Key: id of the custom widget
    @Persisted var parentEntityId: String        // ID of the parent object, e.g., conversationId
    @Persisted var parentEntityType: String      // Type of entity, e.g., message
    @Persisted var metadata: Data?       // Key-value data of the widget
    @Persisted var _lm_meta: Data?      // Nullable: Key-value data created by LikeMinds
    @Persisted var createdAt: Int64              // Epoch time of widget creation
    @Persisted var updatedAt: Int64              // Epoch time of widget update
}

