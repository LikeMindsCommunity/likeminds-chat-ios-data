//
//  WidgetRO.swift
//  LikeMindsChat
//
//  Created by Anurag Tyagi on 08/11/24.
//

import Foundation
import RealmSwift

/// A Realm Object model representing a custom widget in the chat system.
///
/// `WidgetRO` is used to store and manage custom widget data in the local database.
/// Widgets can be associated with various chat entities like messages or conversations
/// and contain customizable metadata for extended functionality.
///
/// ## Usage Example:
/// ```swift
/// let widget = WidgetRO()
/// widget.id = "custom_widget_1"
/// widget.parentEntityId = "conversation_123"
/// widget.parentEntityType = "message"
/// // Add to Realm database
/// try! realm.write {
///     realm.add(widget)
/// }
/// ```
///
/// - Note: This class inherits from Realm's `Object` class and includes properties
///         that are persisted in the local database using Realm.
class WidgetRO: Object {
    /// Unique identifier for the widget.
    /// This property serves as the primary key in the Realm database.
    /// - Note: Must be unique across all widgets.
    @Persisted(primaryKey: true) var id: String
    
    /// Identifier of the parent entity this widget is associated with.
    /// For example, this could be a conversation ID or message ID.
    /// - Note: Used to establish relationships between widgets and other entities.
    @Persisted var parentEntityId: String
    
    /// Type of the parent entity.
    /// Specifies what kind of entity this widget is associated with (e.g., "message", "conversation").
    /// - Note: Used for categorization and filtering of widgets.
    @Persisted var parentEntityType: String
    
    /// Custom metadata associated with the widget.
    /// Stored as serialized JSON data to allow flexible key-value storage.
    /// - Note: Can be nil if no metadata is needed.
    @Persisted var metadata: Data?
    
    /// LikeMinds-specific metadata for the widget.
    /// Contains additional information managed by the LikeMinds system.
    /// - Note: Relationship to `LMMetaRO` object, can be nil.
    @Persisted var lmMeta: LMMetaRO?
    
    /// Timestamp when the widget was created.
    /// Stored as Int64 to represent epoch time in milliseconds.
    /// - Note: Used for sorting and tracking widget creation time.
    @Persisted var createdAt: Int64
    
    /// Timestamp when the widget was last updated.
    /// Stored as Int64 to represent epoch time in milliseconds.
    /// - Note: Used for sorting and tracking widget modifications.
    @Persisted var updatedAt: Int64
}

