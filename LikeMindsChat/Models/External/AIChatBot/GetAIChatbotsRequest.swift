//
//  AIChatbotsRequest.swift
//  LikeMindsChat
//
//  Created by Arpit Verma on 10/04/25.
//

import Foundation

/// Request structure for fetching AI Chatbots list
public class GetAIChatbotsRequest: Encodable {
    private(set) var page: Int?
    private(set) var pageSize: Int
    
    private init(builder: Builder) {
        self.page = builder.page
        self.pageSize = builder.pageSize
    }
    
    public static func builder() -> Builder {
        return Builder()
    }
    
    public class Builder {
        var page: Int?
        var pageSize: Int = 10 // Default value
        
        public init() {
        }
        
        /// Sets the page number for pagination
        /// - Parameter page: Page number (required)
        /// - Returns: Builder instance for method chaining
        public func page(_ page: Int) -> Builder {
            self.page = page
            return self
        }
        
        /// Sets the page size for pagination
        /// - Parameter pageSize: Number of items per page (required)
        /// - Returns: Builder instance for method chaining
        public func pageSize(_ pageSize: Int) -> Builder {
            self.pageSize = pageSize
            return self
        }
        
        /// Builds the GetAIChatbotsRequest instance
        /// - Returns: Configured GetAIChatbotsRequest
        /// - Throws: Error if page is not provided
        public func build() throws -> GetAIChatbotsRequest {
            guard let _ = page else {
                throw AIChatbotsError.pageNotProvided
            }
            return GetAIChatbotsRequest(builder: self)
        }
    }
    
    /// Converts the current request to a builder for modifications
    /// - Returns: Builder instance with current values
    public func toBuilder() -> Builder {
        var builder = Builder()
        if let page = self.page {
            builder = builder.page(page)
        }
        builder = builder.pageSize(self.pageSize)
        return builder
    }
    
    /// Coding keys for JSON encoding
    enum CodingKeys: String, CodingKey {
        case page
        case pageSize = "page_size"
    }
}

/// Custom errors for AIChatbots
public enum AIChatbotsError: Error {
    case pageNotProvided
}

extension AIChatbotsError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .pageNotProvided:
            return "Page number is required for pagination"
        }
    }
}
