//
//  LMResponse.swift
//  LMFeed
//
//  Created by Pushpendra Singh on 19/02/23.
//

import Foundation

public typealias LMClientResponse<T:Decodable> = (LMResponse<T>) -> (Void)

public struct LMResponse<T: Decodable>: Decodable {
    public let success: Bool
    public let errorMessage: String?
    public let data: T?
    
    enum CodingKeys: String, CodingKey {
        case success, data
        case errorMessage = "error_message"
    }
    
    private init(_ success: Bool, errorMessage: String?) {
        self.success = success
        self.errorMessage = errorMessage
        self.data = nil
    }
    
    private init(data: T) {
        self.success = true
        self.data = data
        self.errorMessage = nil
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent(T.self, forKey: .data)
    }
    
    static func failureResponse(_ errorMessage: String) -> LMResponse {
        return LMResponse(false, errorMessage: errorMessage)
    }
    
    static func successResponse(_ data: T) -> LMResponse {
        return LMResponse(data: data)
    }
}

public struct NoData: Decodable {}
