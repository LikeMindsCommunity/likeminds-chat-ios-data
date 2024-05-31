//
//  GetContentDownloadSettingsResponse.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public struct GetContentDownloadSettingsResponse: Decodable {
    public var settings: [ContentDownloadSetting]?
}
