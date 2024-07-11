//
//  CheckDMStatusResponse.swift
//  CollabMates
//
//  Created by Pushpendra Singh on 09/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

public struct CheckDMStatusResponse: Decodable {
    public let showDM: Bool?
    public let cta: String?
    
    enum CodingKeys: String, CodingKey {
        case cta
        case showDM = "show_dm"
    }
}

