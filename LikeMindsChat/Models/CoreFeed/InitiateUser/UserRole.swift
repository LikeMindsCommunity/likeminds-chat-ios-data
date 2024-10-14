//
//  UserRole.swift
//  LikeMindsChat
//
//  Created by Anurag Tyagi on 14/10/24.
//


public enum UserRole: String {
    case chatbot = "chatbot"
    case member = "member"
    
    // Static method to convert String to UserRole
    static func from(_ value: String) -> UserRole? {
        return UserRole(rawValue: value)
    }
}
