//
//  _Question_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 09/01/24.
//

import Foundation

/// Represents a question used within the LikeMindsChat application.
///
/// The `Question` struct encapsulates data for a question, including its title, state, value, and various flags
/// indicating whether the question is optional, compulsory, or hidden. Additional metadata such as help text, associated
/// community and member identifiers, directory fields, and image URL are also included. This struct conforms to
/// `Codable` for easy JSON parsing.
public struct Question: Codable {
  /// The unique identifier for the question.
  public let id: Int?

  /// The title of the question.
  public let questionTitle: String?

  /// The state of the question.
  public let state: Int?

  /// The value associated with the question.
  public let value: String?

  /// Indicates whether the question is optional.
  public let optional: Bool?

  /// Help text providing additional context for the question.
  public let helpText: String?

  /// A Boolean flag indicating if the question represents a field.
  public let field: Bool?

  /// A Boolean flag indicating if the question is compulsory.
  public let isCompulsory: Bool?

  /// A Boolean flag indicating if the question is hidden.
  public let isHidden: Bool?

  /// The identifier for the community associated with the question.
  public let communityId: String?

  /// The identifier for the member associated with the question.
  public let memberId: String?

  /// Indicates if the question belongs to directory fields.
  public let directoryFields: Bool?

  /// The URL for an image associated with the question.
  public let imageUrl: String?

  /// Indicates whether additional options can be added to the question.
  public let canAddOtherOptions: Bool?

  /// The state change indicator for the question.
  public let questionChangeState: Int?

  /// Indicates whether the answer to the question is editable.
  public let isAnswerEditable: Bool?

  /**
   Coding keys used to map JSON keys to the corresponding properties of `Question`.
  
   These keys accommodate differences between the JSON key names and the property names (e.g., `"question_title"`).
   */
  enum CodingKeys: String, CodingKey {
    case id
    case questionTitle = "question_title"
    case state
    case value
    case optional
    case helpText = "help_text"
    case field
    case isCompulsory = "is_compulsory"
    case isHidden = "is_hidden"
    case communityId = "community_id"
    case memberId = "member_id"
    case directoryFields = "directory_fields"
    case imageUrl = "image_url"
    case canAddOtherOptions = "can_add_options"
    case questionChangeState = "question_change_state"
    case isAnswerEditable = "is_answer_editable"
  }

  /**
   Initializes a new `Question` instance by decoding from the given decoder.
  
   This initializer decodes the JSON representation of a question using the custom `CodingKeys`.
  
   - Parameter decoder: The decoder to read data from.
   - Throws: An error if required data is missing or if decoding fails.
   */
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    questionTitle = try container.decode(String.self, forKey: .questionTitle)
    state = try container.decodeIfPresent(Int.self, forKey: .state)
    value = try container.decodeIfPresent(String.self, forKey: .value)
    optional = try container.decodeIfPresent(Bool.self, forKey: .optional)
    helpText = try container.decodeIfPresent(String.self, forKey: .helpText)
    field = try container.decodeIfPresent(Bool.self, forKey: .field)
    isCompulsory = try container.decodeIfPresent(Bool.self, forKey: .isCompulsory)
    isHidden = try container.decodeIfPresent(Bool.self, forKey: .isHidden)
    communityId = try container.decodeIntToStringIfPresent(forKey: .communityId)
    memberId = try container.decodeIntToStringIfPresent(forKey: .memberId)
    directoryFields = try container.decodeIfPresent(Bool.self, forKey: .directoryFields)
    imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
    canAddOtherOptions = try container.decodeIfPresent(Bool.self, forKey: .canAddOtherOptions)
    questionChangeState = try container.decodeIfPresent(Int.self, forKey: .questionChangeState)
    isAnswerEditable = try container.decodeIfPresent(Bool.self, forKey: .isAnswerEditable)
  }

  /**
   Encodes this question instance to the given encoder.
  
   - Parameter encoder: The encoder to write data to.
   - Throws: An error if encoding fails for any reason.
   */
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encodeIfPresent(id, forKey: .id)
    try container.encodeIfPresent(questionTitle, forKey: .questionTitle)
    try container.encodeIfPresent(state, forKey: .state)
    try container.encodeIfPresent(value, forKey: .value)
    try container.encodeIfPresent(optional, forKey: .optional)
    try container.encodeIfPresent(helpText, forKey: .helpText)
    try container.encodeIfPresent(field, forKey: .field)
    try container.encodeIfPresent(isCompulsory, forKey: .isCompulsory)
    try container.encodeIfPresent(isHidden, forKey: .isHidden)
    try container.encodeIfPresent(communityId, forKey: .communityId)
    try container.encodeIfPresent(memberId, forKey: .memberId)
    try container.encodeIfPresent(directoryFields, forKey: .directoryFields)
    try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
    try container.encodeIfPresent(canAddOtherOptions, forKey: .canAddOtherOptions)
    try container.encodeIfPresent(questionChangeState, forKey: .questionChangeState)
    try container.encodeIfPresent(isAnswerEditable, forKey: .isAnswerEditable)
  }

  /**
   Initializes a new `Question` instance with the provided property values.
  
   This initializer allows for manual creation of a `Question` instance.
  
   - Parameters:
      - id: The unique identifier for the question.
      - questionTitle: The title of the question.
      - state: The state of the question.
      - value: The value associated with the question.
      - optional: A Boolean indicating if the question is optional.
      - helpText: Additional help text for the question.
      - field: A Boolean flag indicating if the question represents a field.
      - isCompulsory: A Boolean flag indicating if the question is compulsory.
      - isHidden: A Boolean flag indicating if the question is hidden.
      - communityId: The identifier for the associated community.
      - memberId: The identifier for the associated member.
      - directoryFields: A Boolean indicating if the question belongs to directory fields.
      - imageUrl: The URL for an image related to the question.
      - canAddOtherOptions: A Boolean indicating if additional options can be added.
      - questionChangeState: The state change indicator for the question.
      - isAnswerEditable: A Boolean indicating if the answer is editable.
   */
  public init(
    id: Int?,
    questionTitle: String?,
    state: Int?,
    value: String?,
    optional: Bool?,
    helpText: String?,
    field: Bool?,
    isCompulsory: Bool?,
    isHidden: Bool?,
    communityId: String?,
    memberId: String?,
    directoryFields: Bool?,
    imageUrl: String?,
    canAddOtherOptions: Bool?,
    questionChangeState: Int?,
    isAnswerEditable: Bool?
  ) {
    self.id = id
    self.questionTitle = questionTitle
    self.state = state
    self.value = value
    self.optional = optional
    self.helpText = helpText
    self.field = field
    self.isCompulsory = isCompulsory
    self.isHidden = isHidden
    self.communityId = communityId
    self.memberId = memberId
    self.directoryFields = directoryFields
    self.imageUrl = imageUrl
    self.canAddOtherOptions = canAddOtherOptions
    self.questionChangeState = questionChangeState
    self.isAnswerEditable = isAnswerEditable
  }
}
