//
//  SendDMRequest.swift
//  CollabMates
//
//  Created by Pushpendra Singh on 10/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

/// Request model for sending a DM, supporting custom encoding and decoding.
public class SendDMRequest: Codable {
    
    var chatRequestState: Int?
    var text: String?
    var chatroomId: String?
    
    // New properties:
    var metadata: [String: Any]?     // Representing a JSON object; optional.
    var temporaryId: String?         // Optional temporary identifier.
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case chatRequestState = "chat_request_state"
        case text
        case chatroomId = "chatroom_id"
        case metadata
        case temporaryId = "temporary_id"
    }
    
    // MARK: - Initializers
    
    /// Private initializer to enforce use of the builder.
    private init() {}
    
    /// Custom initializer to build the object manually (used by the Builder).
    private init(chatRequestState: Int?,
                 text: String?,
                 chatroomId: String?,
                 metadata: [String: Any]?,
                 temporaryId: String?) {
        self.chatRequestState = chatRequestState
        self.text = text
        self.chatroomId = chatroomId
        self.metadata = metadata
        self.temporaryId = temporaryId
    }
    
    // MARK: - Builder Pattern
    
    /// Returns a new Builder instance.
    public static func builder() -> Builder {
        return Builder()
    }
    
    /// Returns self as the built object.
    public func build() -> SendDMRequest {
        return self
    }
    
    /// Provides a Builder pre-populated with the current values.
    public func toBuilder() -> Builder {
        return Builder()
            .chatRequestState(chatRequestState)
            .text(text)
            .chatroomId(chatroomId)
            .metadata(metadata)
            .temporaryId(temporaryId)
    }
    
    // MARK: - Custom Decoding
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        chatRequestState = try? container.decodeIfPresent(Int.self, forKey: .chatRequestState)
        text = try? container.decodeIfPresent(String.self, forKey: .text)
        chatroomId = try? container.decodeIfPresent(String.self, forKey: .chatroomId)
        
        // Decode metadata as [String: AnyDecodable] and map to [String: Any].
        if let decodedMetadata = try? container.decodeIfPresent([String: AnyDecodable].self, forKey: .metadata) {
            metadata = decodedMetadata.mapValues { $0.value }
        } else {
            metadata = nil
        }
        
        temporaryId = try? container.decodeIfPresent(String.self, forKey: .temporaryId)
    }
    
    // MARK: - Custom Encoding
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try? container.encodeIfPresent(chatRequestState, forKey: .chatRequestState)
        try? container.encodeIfPresent(text, forKey: .text)
        try? container.encodeIfPresent(chatroomId, forKey: .chatroomId)
        
        // Encoding metadata, ensuring it's serializable as a dictionary.
        if let metadata = self.metadata {
            let encodableMetadata = metadata.mapValues { AnyEncodable($0) }
            try? container.encodeIfPresent(encodableMetadata, forKey: .metadata)
        }
        
        try? container.encodeIfPresent(temporaryId, forKey: .temporaryId)
    }
    
    // MARK: - Builder Class
    public class Builder {
        private var chatRequestState: Int?
        private var text: String?
        private var chatroomId: String?
        private var metadata: [String: Any]?
        private var temporaryId: String?
        
        // Builder methods for setting values
        
        public func chatRequestState(_ chatRequestState: Int?) -> Builder {
            self.chatRequestState = chatRequestState
            return self
        }
        
        public func text(_ text: String?) -> Builder {
            self.text = text
            return self
        }
        
        public func chatroomId(_ chatroomId: String?) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func metadata(_ metadata: [String: Any]?) -> Builder {
            self.metadata = metadata
            return self
        }
        
        public func temporaryId(_ temporaryId: String?) -> Builder {
            self.temporaryId = temporaryId
            return self
        }
        
        // Final build method to return a SendDMRequest instance
        public func build() -> SendDMRequest {
            return SendDMRequest(chatRequestState: chatRequestState,
                                 text: text,
                                 chatroomId: chatroomId,
                                 metadata: metadata,
                                 temporaryId: temporaryId)
        }
    }
}

