//
//  Widget.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 24/07/24.
//

import Foundation

public struct Widget: Codable {
  public let id: String?
  public let parentEntityID: String?
  public let parentEntityType: String?
  public let metadata: [String: Any]?
  public let createdAt: Double?
  public let updatedAt: Double?
  public let lmMeta: LMMeta?

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case createdAt = "created_at"
    case metadata
    case parentEntityID = "parent_entity_id"
    case parentEntityType = "parent_entity_type"
    case updatedAt = "updated_at"
    case lmMeta = "_lm_meta"
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try? container.decodeIfPresent(String.self, forKey: .id)
    parentEntityID = try? container.decodeIfPresent(String.self, forKey: .parentEntityID)
    parentEntityType = try? container.decodeIfPresent(String.self, forKey: .parentEntityType)

    if let decodedMetadata = try? container.decodeIfPresent(
      [String: AnyDecodable].self, forKey: .metadata)
    {
      metadata = decodedMetadata.mapValues { $0.value }
    } else {
      metadata = nil
    }

    createdAt = try? container.decodeIfPresent(Double.self, forKey: .createdAt)
    updatedAt = try? container.decodeIfPresent(Double.self, forKey: .updatedAt)
    lmMeta = try? container.decodeIfPresent(LMMeta.self, forKey: .lmMeta)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encodeIfPresent(id, forKey: .id)
    try container.encodeIfPresent(parentEntityID, forKey: .parentEntityID)
    try container.encodeIfPresent(parentEntityType, forKey: .parentEntityType)

    if let metadata = metadata {
      let encodableMetadata: [String: AnyEncodable] = metadata.mapValues { AnyEncodable($0) }
      try container.encode(encodableMetadata, forKey: .metadata)
    }

    try container.encodeIfPresent(createdAt, forKey: .createdAt)
    try container.encodeIfPresent(updatedAt, forKey: .updatedAt)
    try container.encodeIfPresent(lmMeta, forKey: .lmMeta)
  }

  // Custom initializer
  public init(
    id: String?,
    parentEntityID: String?,
    parentEntityType: String?,
    metadata: [String: Any]?,
    createdAt: Double?,
    updatedAt: Double?,
    lmMeta: LMMeta?
  ) {
    self.id = id
    self.parentEntityID = parentEntityID
    self.parentEntityType = parentEntityType
    self.metadata = metadata
    self.createdAt = createdAt
    self.updatedAt = updatedAt
    self.lmMeta = lmMeta
  }

  // MARK: - Builder Pattern
  public class Builder {
    private var id: String?
    private var parentEntityID: String?
    private var parentEntityType: String?
    private var metadata: [String: Any]?
    private var createdAt: Double?
    private var updatedAt: Double?
    private var lmMeta: LMMeta?

    public init() {}

    public func id(_ id: String?) -> Builder {
      self.id = id
      return self
    }

    public func parentEntityID(_ parentEntityID: String?) -> Builder {
      self.parentEntityID = parentEntityID
      return self
    }

    public func parentEntityType(_ parentEntityType: String?) -> Builder {
      self.parentEntityType = parentEntityType
      return self
    }

    public func metadata(_ metadata: [String: Any]?) -> Builder {
      self.metadata = metadata
      return self
    }

    public func createdAt(_ createdAt: Double?) -> Builder {
      self.createdAt = createdAt
      return self
    }

    public func updatedAt(_ updatedAt: Double?) -> Builder {
      self.updatedAt = updatedAt
      return self
    }

    public func lmMeta(_ lmMeta: LMMeta?) -> Builder {
      self.lmMeta = lmMeta
      return self
    }

    public func build() -> Widget {
      return Widget(
        id: id,
        parentEntityID: parentEntityID,
        parentEntityType: parentEntityType,
        metadata: metadata,
        createdAt: createdAt,
        updatedAt: updatedAt,
        lmMeta: lmMeta
      )
    }
  }
}

public struct AnyDecodable: Decodable {
  let value: Any

  public init(from decoder: Decoder) throws {
    if let intValue = try? decoder.singleValueContainer().decode(Int.self) {
      value = intValue
    } else if let doubleValue = try? decoder.singleValueContainer().decode(
      Double.self)
    {
      value = doubleValue
    } else if let stringValue = try? decoder.singleValueContainer().decode(
      String.self)
    {
      value = stringValue
    } else if let boolValue = try? decoder.singleValueContainer().decode(
      Bool.self)
    {
      value = boolValue
    } else if let nestedDictionary = try? decoder.singleValueContainer()
      .decode([String: AnyDecodable].self)
    {
      value = nestedDictionary.mapValues { $0.value }
    } else if let nestedArray = try? decoder.singleValueContainer().decode(
      [AnyDecodable].self)
    {
      value = nestedArray.map { $0.value }
    } else {
      throw DecodingError.dataCorruptedError(
        in: try decoder.singleValueContainer(),
        debugDescription: "Unsupported type")
    }
  }
}

public struct AnyEncodable: Encodable {
  let value: Any

  public init(_ value: Any) {
    self.value = value
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()

    if let intValue = value as? Int {
      try container.encode(intValue)
    } else if let doubleValue = value as? Double {
      try container.encode(doubleValue)
    } else if let stringValue = value as? String {
      try container.encode(stringValue)
    } else if let boolValue = value as? Bool {
      try container.encode(boolValue)
    } else if let dictionaryValue = value as? [String: Any] {
      let encodableDictionary = dictionaryValue.mapValues {
        AnyEncodable($0)
      }
      try container.encode(encodableDictionary)
    } else if let arrayValue = value as? [Any] {
      let encodableArray = arrayValue.map { AnyEncodable($0) }
      try container.encode(encodableArray)
    } else if let conversationValue = value as? Conversation {
      try container.encode(conversationValue)
    } else if let dictionaryValue: any Encodable = value as? Encodable {
      try container.encode(dictionaryValue)
    } else {
      throw EncodingError.invalidValue(
        value,
        EncodingError.Context(
          codingPath: container.codingPath,
          debugDescription: "Unsupported type"))
    }
  }
}
