//
//  UserRole.swift
//  LikeMindsChat
//
//  Created by Anurag Tyagi on 14/10/24.
//


public enum UserRole: String, Codable {
    case chatbot = "chatbot"
    case member = "member"
    
    // Static method to convert String to UserRole
    static func from(_ value: String) -> UserRole? {
        return UserRole(rawValue: value)
    }
    
    // Custom initializer to handle decoding
      public init(from decoder: Decoder) throws {
          let container = try decoder.singleValueContainer()
          let value = try container.decode(String.self)
          
          // Try to decode using the raw value
          if let role = UserRole(rawValue: value) {
              self = role
          } else {
              throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid role value: \(value)")
          }
      }
      
      // Custom encoding method
      public func encode(to encoder: Encoder) throws {
          var container = encoder.singleValueContainer()
          try container.encode(self.rawValue)
      }
}
