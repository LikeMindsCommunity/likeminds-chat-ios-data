//
//  LMMetaRO.swift
//  LikeMindsChat
//
//  Created by AI on 21/01/25.
//

import Foundation
import RealmSwift

/// A Realm Object model representing LikeMinds-specific metadata for widgets.
///
/// `LMMetaRO` stores additional information about widgets that is specific to the
/// LikeMinds chat system. This includes references to chatrooms and conversations
/// that are associated with the widget.
///
/// ## Usage Example:
/// ```swift
/// let lmMeta = LMMetaRO()
/// lmMeta.sourceChatroomId = "chatroom_123"
/// lmMeta.type = "forward"
/// widget.lmMeta = lmMeta
/// ```
///
/// - Note: This class inherits from Realm's `Object` class and is typically used
///         as a nested object within `WidgetRO`.
class LMMetaRO: Object {
    /// ID of the source chatroom associated with this metadata.
    /// - Note: Can be nil if not associated with a specific chatroom.
    @Persisted var sourceChatroomId: String?
    
    /// Name of the source chatroom.
    /// Provides a human-readable identifier for the associated chatroom.
    /// - Note: Can be nil if not associated with a specific chatroom.
    @Persisted var sourceChatroomName: String?
    
    /// Reference to the source conversation.
    /// Establishes a relationship with a specific conversation in the chat system.
    /// - Note: Can be nil if not associated with a specific conversation.
    @Persisted var sourceConversation: ConversationRO?
    
    /// Type identifier for the metadata.
    /// Specifies the category or purpose of this metadata (e.g., "forward", "reply").
    /// - Note: Can be nil if no specific type is needed.
    @Persisted var type: String?
}
