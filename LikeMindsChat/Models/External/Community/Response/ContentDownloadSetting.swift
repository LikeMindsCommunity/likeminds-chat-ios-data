//
//  ContentDownloadSetting.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public struct ContentDownloadSetting: Decodable {
    public var communityId: Int
    public var downloadSettingType: String
    public var downloadSettingTitle: String
    public var enabled: Bool
    
    enum CodingKeys: String, CodingKey {
        case communityId = "community_id"
        case enabled
        case downloadSettingTitle = "download_setting_title"
        case downloadSettingType = "download_setting_type"
    }
}
