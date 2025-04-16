import Foundation

public struct GetCommunityConfigurationsResponse: Codable {
    public let configurations: [Configuration]
    
    enum CodingKeys: String, CodingKey {
        case configurations = "community_configurations"
    }
}

public struct Configuration: Codable {
    public let type: ConfigurationType
    public let description: String
    public let value: [String: Any]
    
    enum CodingKeys: String, CodingKey {
        case type
        case description
        case value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decodeIfPresent(ConfigurationType.self, forKey: .type) ?? ConfigurationType.none
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        value = try container.decodeIfPresent([String: AnyDecodable].self, forKey: .value)?.mapValues { $0.value } ?? [:]
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(description, forKey: .description)
        let encodableValue = value.mapValues { AnyEncodable($0) }
        try container.encode(encodableValue, forKey: .value)
    }
}

public enum ConfigurationType: String, Codable {
    case none = "none"
    case mediaLimits = "media_limits"
    case feedMetadata = "feed_metadata"
    case profileMetadata = "profile_metadata"
    case nsfwFiltering = "nsfw_filtering"
    case widgetMetadata = "widgets_metadata"
    case guestFlowMetadata = "guest_flow_metadata"
    case replyPrivately = "reply_privately"
    case feedSettings = "feed_settings"
    case personalisedFeedWeights = "personalised_feed_weights"
    case chatbot = "chatbot"
    case chatPoll = "chat_poll"
}

public enum ReplyPrivatelyAllowedScope: String, Codable {
    case NO_ONE = "NO_ONE"
    case ONLY_CMS = "ONLY_CMS"
    case ALL_MEMBERS = "ALL_MEMBERS"
}
