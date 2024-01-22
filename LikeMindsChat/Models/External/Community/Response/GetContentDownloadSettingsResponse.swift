//
//  GetContentDownloadSettingsResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

struct GetContentDownloadSettingsResponse: Decodable {
    var settings: [ContentDownloadSetting]
}
