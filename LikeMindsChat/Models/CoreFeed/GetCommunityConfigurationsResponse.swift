import Foundation

public struct GetCommunityConfigurationsResponse: Decodable {
    public let configurations: [Configuration]
}

public struct Configuration: Decodable {
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
        type = try container.decode(ConfigurationType.self, forKey: .type)
        description = try container.decode(String.self, forKey: .description)
        value = try container.decode([String: AnyDecodable].self, forKey: .value)
    }
}

public enum ConfigurationType: String, Codable {
    case NONE = "none"
    case MEDIA_LIMITS = "media_limits"
    case FEED_METADATA = "feed_metadata"
    case PROFILE_METADATA = "profile_metadata"
    case NSFW_FILTERING = "nsfw_filtering"
    case WIDGET_METADATA = "widgets_metadata"
    case GUEST_FLOW_METADATA = "guest_flow_metadata"
    case REPLY_PRIVATELY = "reply_privately"
}

public enum ReplyPrivatelyAllowedScope: String{
    case NO_ONE = "NO_ONE"
    case ONLY_CMS = "ONLY_CMS"
    case ALL_MEMBERS = "ALL_MEMBERS"
}
