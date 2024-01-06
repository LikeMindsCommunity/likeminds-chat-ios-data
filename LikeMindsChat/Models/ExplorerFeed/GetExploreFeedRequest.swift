//
//  GetExploreFeedRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 12/07/23.
//

import Foundation

public class GetExploreFeedRequest: Encodable {
    /// Initiate method
    private init() {}
    
    public static func builder() -> GetExploreFeedRequest {
        return GetExploreFeedRequest()
    }
    
    public func build() -> GetExploreFeedRequest {
        return self
    }
}
