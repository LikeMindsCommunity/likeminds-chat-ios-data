//
//  CheckDMLimitRequest.swift
//  CollabMates
//
//  Created by Pushpendra Singh on 07/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

public class CheckDMLimitRequest: Encodable {
    
    var uuid: String?
    
    /// Initiate method
    private init() {}
    
    public static func builder() -> CheckDMLimitRequest {
        return CheckDMLimitRequest()
    }
    
    public func build() -> CheckDMLimitRequest {
        return self
    }
    
    enum CodingKeys: String, CodingKey {
        case uuid
    }
    
    public func uuid(_ uuid: String) -> CheckDMLimitRequest {
        self.uuid = uuid
        return self
    }
}
