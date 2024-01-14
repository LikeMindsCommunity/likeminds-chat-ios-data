//
//  LMResponse.swift
//  LMFeed
//
//  Created by Pushpendra Singh on 19/02/23.
//

import Foundation

public struct LMResponse<T> {
    public let success: Bool
    public let errorMessage: String?
    public let data: T?
    
    private init(_ success: Bool, errorMessage: String) {
        self.success = success
        self.errorMessage = errorMessage
        self.data = nil
    }
    
    static func failureResponse(_ errorMessage: String) -> LMResponse {
        return LMResponse(false, errorMessage: errorMessage)
    }
}

public struct NoData {}
