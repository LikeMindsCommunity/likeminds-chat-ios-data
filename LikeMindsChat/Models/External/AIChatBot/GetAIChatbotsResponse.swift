//
//  AIChatbotsResponse.swift
//  LikeMindsChat
//
//  Created by Arpit Verma on 10/04/25.
//


import Foundation

/// Response structure for AI Chatbots list
public struct GetAIChatbotsResponse: Decodable {
    /// Current page number in pagination
    public let page: Int
    
    /// Total number of pages based on page size
    public let totalPages: Int
    
    /// Total count of chatbots in the project
    public let totalChatbots: Int
    
    /// List of all chatbots present in the project
    public let users: [Member]?

    /// Coding keys to map between JSON property names and struct property names
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalChatbots = "total_chatbots"
        case users
    }
}
