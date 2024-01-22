//
//  ReportTagResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 19/01/24.
//

import Foundation

struct GetReportTagsResponse: Decodable {
    let tags: [ReportTag]?
    
    private enum CodingKeys: String, CodingKey {
        case tags = "report_tags"
    }
}

struct ReportTag: Decodable {
    let id: Int?
    let name: String?
}
