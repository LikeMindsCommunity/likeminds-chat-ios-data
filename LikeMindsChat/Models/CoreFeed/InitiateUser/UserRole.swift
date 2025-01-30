//
//  UserRole.swift
//  LikeMindsChat
//
//  Created by Anurag Tyagi on 14/10/24.
//

// MARK: - UserRole

/// Represents the role of a user in a given context, such as a chatroom or community.
///
/// The enum is `Codable`, so it supports custom decoding/encoding. It also provides a
/// static `from(_:)` method for convenient conversion from a raw `String` to a `UserRole`.
public enum UserRole: String, Codable {

    /// Indicates the user is a chatbot entity.
    case chatbot = "chatbot"

    /// Indicates the user is a regular member.
    case member = "member"

    /**
     Converts a `String` value into a `UserRole`.

     - Parameter value: A string that should match one of the `UserRole` raw values.
     - Returns: An optional `UserRole`. If the string does not match any known raw values,
               it returns `nil`.
     */
    static func from(_ value: String) -> UserRole? {
        return UserRole(rawValue: value)
    }

    // MARK: - Custom Decoding

    /**
     Custom initializer to handle decoding from a `String` value in the JSON.

     - Parameter decoder: The `Decoder` from which we're reading data.
     - Throws: `DecodingError.dataCorruptedError` if the raw string value does not match
               any known `UserRole` case.
     */
    public init(from decoder: Decoder) throws {
        // A single-value container is used for decoding an enum’s raw string value.
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)

        // Attempt to initialize the enum using the raw value. If it’s invalid, throw an error.
        if let role = UserRole(rawValue: value) {
            self = role
        } else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid role value: \(value)"
            )
        }
    }

    // MARK: - Custom Encoding

    /**
     Custom method to encode the `UserRole` into a single string value in JSON.

     - Parameter encoder: The `Encoder` where the raw value of the enum will be written.
     - Throws: Any errors encountered during encoding.
     */
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }
}
