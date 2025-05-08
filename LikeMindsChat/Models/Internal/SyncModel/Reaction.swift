//
//  _Reaction_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 09/01/24.
//

import Foundation

/// Represents a reaction in the LikeMindsChat application.
///
/// The `Reaction` class encapsulates information about a reaction provided by a member. This includes the member who reacted and the reaction content itself.
///
/// The class conforms to `Decodable` for JSON parsing and employs the builder pattern for convenient construction.
///
/// - Properties:
///    - member: The member who provided the reaction.
///    - reaction: The reaction content as a string.
public class Reaction: Codable {

  /// The member who provided the reaction.
  public let member: Member?

  /// The reaction content.
  public let reaction: String

  /**
   Coding keys for decoding a `Reaction` from JSON.
  
   These keys map the JSON fields to the corresponding properties of the `Reaction` class.
   */
  private enum CodingKeys: String, CodingKey {
    case member
    case reaction
  }

  /**
   Initializes a new `Reaction` instance by decoding from the given decoder.
  
   - Parameter decoder: The decoder to read data from.
   - Throws: An error if required data is missing or if decoding fails.
   */
  required public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    member = try container.decodeIfPresent(Member.self, forKey: .member)
    reaction = try container.decode(String.self, forKey: .reaction)
  }

  /**
   Returns a new `Builder` instance for constructing a `Reaction` object.
  
   - Returns: A new `Builder` instance.
   */
  public static func builder() -> Builder {
    Builder()
  }

  /**
   Private initializer used by the builder to create a `Reaction` instance.
  
   - Parameters:
      - member: The member who provided the reaction.
      - reaction: The reaction content.
   */
  private init(member: Member?, reaction: String) {
    self.member = member
    self.reaction = reaction
  }

  // MARK: - Builder Pattern

  /**
   A builder class for constructing `Reaction` instances.
  
   The builder provides a fluent API for setting the properties of a `Reaction` and creating a fully configured instance.
   */
  public class Builder {
    private var member: Member?
    private var reaction: String = ""

    /**
     Sets the member for the reaction.
    
     - Parameter member: The member who provided the reaction.
     - Returns: The current `Builder` instance for chaining.
     */
    public func member(_ member: Member?) -> Builder {
      self.member = member
      return self
    }

    /**
     Sets the reaction content.
    
     - Parameter reaction: The reaction content as a string.
     - Returns: The current `Builder` instance for chaining.
     */
    public func reaction(_ reaction: String) -> Builder {
      self.reaction = reaction
      return self
    }

    /**
     Builds and returns a new `Reaction` instance with the configured properties.
    
     - Returns: A new `Reaction` object.
     */
    public func build() -> Reaction {
      return Reaction(member: member, reaction: reaction)
    }
  }

  /**
   Returns a builder pre-populated with the current `Reaction`'s properties.
  
   This method allows for convenient modification of an existing `Reaction` instance using the builder pattern.
  
   - Returns: A `Builder` instance pre-populated with the current reaction values.
   */
  public func toBuilder() -> Builder {
    return Builder().reaction(reaction).member(member)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encodeIfPresent(member, forKey: .member)
    try container.encode(reaction, forKey: .reaction)
  }
}
