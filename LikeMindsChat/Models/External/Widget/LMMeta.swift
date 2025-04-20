//
//  LMMeta.swift
//  LikeMindsChat
//
//  Created by Anurag Tyagi on 15/04/25.
//

import Foundation

public struct LMMeta: Decodable {
  public let sourceChatroomId: String?
  public let sourceChatroomName: String?
  public let sourceConversation: Conversation?
  public let type: String?

  enum CodingKeys: String, CodingKey {
    case sourceChatroomId = "source_chatroom_id"
    case sourceChatroomName = "source_chatroom_name"
    case sourceConversation = "source_conversation"
    case type
  }

  // Private initializer to enforce builder pattern for manual creation
  private init(
    sourceChatroomId: String?,
    sourceChatroomName: String?,
    sourceConversation: Conversation?,
    type: String?
  ) {
    self.sourceChatroomId = sourceChatroomId
    self.sourceChatroomName = sourceChatroomName
    self.sourceConversation = sourceConversation
    self.type = type
  }

  // MARK: - Decodable Implementation
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    // Decode properties robustly, assigning nil if decoding fails or key is absent
    sourceChatroomId = try? container.decodeIfPresent(String.self, forKey: .sourceChatroomId)
    sourceChatroomName = try? container.decodeIfPresent(String.self, forKey: .sourceChatroomName)
    sourceConversation = try? container.decodeIfPresent(
      Conversation.self, forKey: .sourceConversation)
    type = try? container.decodeIfPresent(String.self, forKey: .type)
  }

  // MARK: - Builder Pattern
  public static func builder() -> Builder {
    return Builder()
  }

  public class Builder {
    private var sourceChatroomId: String?
    private var sourceChatroomName: String?
    private var sourceConversation: Conversation?
    private var type: String?

    public init() {}

    public func sourceChatroomId(_ sourceChatroomId: String?) -> Builder {
      self.sourceChatroomId = sourceChatroomId
      return self
    }

    public func sourceChatroomName(_ sourceChatroomName: String?) -> Builder {
      self.sourceChatroomName = sourceChatroomName
      return self
    }

    public func sourceConversation(_ sourceConversation: Conversation?) -> Builder {
      self.sourceConversation = sourceConversation
      return self
    }

    public func type(_ type: String?) -> Builder {
      self.type = type
      return self
    }

    public func build() -> LMMeta {
      // Use the private initializer
      return LMMeta(
        sourceChatroomId: sourceChatroomId,
        sourceChatroomName: sourceChatroomName,
        sourceConversation: sourceConversation,
        type: type
      )
    }
  }

  public func toBuilder() -> Builder {
    return Builder()
      .sourceChatroomId(sourceChatroomId)
      .sourceChatroomName(sourceChatroomName)
      .sourceConversation(sourceConversation)
      .type(type)
  }
}
