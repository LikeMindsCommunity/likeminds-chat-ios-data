//
//  ReportTagResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 19/01/24.
//

import Foundation

public struct GetReportTagsResponse: Decodable {
    public let tags: [ReportTag]?
    
    private enum CodingKeys: String, CodingKey {
        case tags = "report_tags"
    }
}

public struct ReportTag: Decodable {
    public let id: Int?
    public let name: String?
}
