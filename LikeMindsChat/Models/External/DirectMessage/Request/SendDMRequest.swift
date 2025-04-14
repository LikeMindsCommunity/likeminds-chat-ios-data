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
    
    /// Fluent API methods for setting values.
    public func chatRequestState(_ chatRequestState: Int?) -> SendDMRequest {
        self.chatRequestState = chatRequestState
        return self
    }
    
    public func text(_ text: String?) -> SendDMRequest {
        self.text = text
        return self
    }
    
    public func chatroomId(_ chatroomId: String?) -> SendDMRequest {
        self.chatroomId = chatroomId
        return self
    }
    
    public func metadata(_ metadata: [String: Any]?) -> SendDMRequest {
        self.metadata = metadata
        return self
    }
    
    public func temporaryId(_ temporaryId: String?) -> SendDMRequest {
        self.temporaryId = temporaryId
        return self
    }
    
    // MARK: - Custom Decoding
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            chatRequestState = try container.decodeIfPresent(Int.self, forKey: .chatRequestState)
        } catch {
            print("Error decoding chatRequestState: \(error)")
            chatRequestState = nil
        }
        
        do {
            text = try container.decodeIfPresent(String.self, forKey: .text)
        } catch {
            print("Error decoding text: \(error)")
            text = nil
        }
        
        do {
            chatroomId = try container.decodeIfPresent(String.self, forKey: .chatroomId)
        } catch {
            print("Error decoding chatroomId: \(error)")
            chatroomId = nil
        }
        
        do {
            // Decode metadata as [String: AnyDecodable] and then map to [String: Any].
            let decodedMetadata = try container.decodeIfPresent([String: AnyDecodable].self, forKey: .metadata)
            metadata = decodedMetadata?.mapValues { $0.value }
        } catch {
            print("Error decoding metadata: \(error)")
            metadata = nil
        }
        
        do {
            temporaryId = try container.decodeIfPresent(String.self, forKey: .temporaryId)
        } catch {
            print("Error decoding temporaryId: \(error)")
            temporaryId = nil
        }
    }
    
    // MARK: - Custom Encoding
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        do {
            try container.encodeIfPresent(chatRequestState, forKey: .chatRequestState)
        } catch {
            print("Error encoding chatRequestState: \(error)")
        }
        
        do {
            try container.encodeIfPresent(text, forKey: .text)
        } catch {
            print("Error encoding text: \(error)")
        }
        
        do {
            try container.encodeIfPresent(chatroomId, forKey: .chatroomId
