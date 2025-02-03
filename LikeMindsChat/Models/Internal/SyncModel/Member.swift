//
//  _Member_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 20/12/23.
//

import Foundation

// MARK: 
/// Represents a member within the LikeMindsChat application.
///
/// The `Member` struct encapsulates various properties of a member such as identifiers, name, profile image URL,
/// guest status, and additional metadata. It conforms to the `Decodable` protocol to support JSON decoding.
public struct Member: Decodable {

    /// The unique identifier for the member.
    public private(set) var id: String?

    /// The unique user identifier.
    public private(set) var userUniqueId: String?

    /// The name of the member.
    public private(set) var name: String?

    /// The URL string for the member's profile image.
    public private(set) var imageUrl: String?

    /// An array of questions representing the member's answers.
    public private(set) var questionAnswers: [Question]?

    /// The state of the member (e.g., role or status).
    public private(set) var state: Int?

    /// Indicates whether the member is a guest.
    public private(set) var isGuest: Bool = false

    /// A custom introduction text for the member.
    public private(set) var customIntroText: String?

    /// A custom clickable text associated with the member.
    public private(set) var customClickText: String?

    /// The date when the member joined, as a string.
    public private(set) var memberSince: String?

    /// The name of the community to which the member belongs.
    public private(set) var communityName: String?

    /// Indicates whether the member is the owner of the community.
    public private(set) var isOwner: Bool = false

    /// Indicates whether the member has been deleted.
    public private(set) var isDeleted: Bool?

    /// A custom title assigned to the member.
    public private(set) var customTitle: String?

    /// An array of actions (menu items) available to the member.
    public private(set) var menu: [MemberAction]?

    /// The identifier of the community that the member belongs to.
    public private(set) var communityId: String?

    /// The identifier of the chatroom associated with the member.
    public private(set) var chatroomId: String?

    /// A routing string for the member.
    public private(set) var route: String?

    /// The attending status of the member.
    public private(set) var attendingStatus: Bool?

    /// Indicates whether the member has a profile image.
    public private(set) var hasProfileImage: Bool?

    /// The timestamp when the member was last updated.
    public private(set) var updatedAt: Int?

    /// Client-specific information about the member.
    public private(set) var sdkClientInfo: SDKClientInfo?

    /// A universally unique identifier for the member.
    public private(set) var uuid: String?

    /// An array of roles assigned to the member.
    public private(set) var roles: [UserRole]?

    /**
     Coding keys used to map JSON keys to the corresponding properties.

     These keys ensure proper decoding from JSON by mapping server-provided key names to the struct's properties.
     */
    enum CodingKeys: String, CodingKey {
        case id, name, roles
        case imageUrl = "image_url"
        case userUniqueId = "user_unique_id"
        case isGuest = "is_guest"
        case isDeleted = "is_deleted"
        case isOwner = "is_owner"
        case customTitle = "custom_title"
        case state, menu, route
        case updatedAt = "updated_at"
        case sdkClientInfo = "sdk_client_info"
        case uuid
        case questionAnswers = "question_answers"
        case customIntroText = "custom_intro_text"
        case customClickText = "custom_click_text"
        case memberSince = "member_since"
        case communityName = "community_name"
        case communityId = "community_id"
        case chatroomId = "chatroom_id"
        case attendingStatus = "attending_status"
        case hasProfileImage = "has_profile_image"
    }

    /// Default initializer.
    init() {}

    /**
     Initializes a new `Member` instance by decoding from the given decoder.

     - Parameter decoder: The decoder to read data from.
     - Throws: An error if any required keys are missing or if the data is corrupted.
     */
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIntToStringIfPresent(forKey: .id)
        userUniqueId = try container.decodeIfPresent(
            String.self, forKey: .userUniqueId)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        questionAnswers = try container.decodeIfPresent(
            [Question].self, forKey: .questionAnswers)
        state = try container.decodeIfPresent(Int.self, forKey: .state)
        isGuest =
            try container.decodeIfPresent(Bool.self, forKey: .isGuest) ?? false
        customIntroText = try container.decodeIfPresent(
            String.self, forKey: .customIntroText)
        customClickText = try container.decodeIfPresent(
            String.self, forKey: .customClickText)
        memberSince = try container.decodeIfPresent(
            String.self, forKey: .memberSince)
        communityName = try container.decodeIfPresent(
            String.self, forKey: .communityName)
        isOwner =
            try container.decodeIfPresent(Bool.self, forKey: .isOwner) ?? false
        isDeleted = try container.decodeIfPresent(Bool.self, forKey: .isDeleted)
        customTitle = try container.decodeIfPresent(
            String.self, forKey: .customTitle)
        menu = try container.decodeIfPresent([MemberAction].self, forKey: .menu)
        communityId = try container.decodeIntToStringIfPresent(
            forKey: .communityId)
        chatroomId = try container.decodeIntToStringIfPresent(
            forKey: .chatroomId)
        route = try container.decodeIfPresent(String.self, forKey: .route)
        attendingStatus = try container.decodeIfPresent(
            Bool.self, forKey: .attendingStatus)
        hasProfileImage = try container.decodeIfPresent(
            Bool.self, forKey: .hasProfileImage)
        updatedAt = try container.decodeIfPresent(Int.self, forKey: .updatedAt)
        sdkClientInfo = try container.decodeIfPresent(
            SDKClientInfo.self, forKey: .sdkClientInfo)
        uuid = try container.decodeIfPresent(String.self, forKey: .uuid)
        roles = try container.decodeIfPresent([UserRole].self, forKey: .roles)
    }

    // MARK: - Computed Properties

    /**
     Returns a string representing the community manager role for the member.

     If the member's state equals `1`, it returns `"Community manager"`, otherwise returns `nil`.

     - Returns: A string if the member is a community manager; otherwise, `nil`.
     */
    public func communityManager() -> String? {
        switch state {
        case 1:
            return "Community manager"
        default:
            return nil
        }
    }

    // MARK: - Builder Pattern

    /**
     A builder class for constructing `Member` instances.

     The builder provides a fluent interface to set properties on a `Member` and build a fully configured object.
     */
    public class Builder {
        private var id: String = ""
        private var userUniqueId: String = ""
        private var name: String = ""
        private var imageUrl: String = ""
        private var questionAnswers: [Question]?
        private var state: Int?
        private var isGuest: Bool = false
        private var customIntroText: String?
        private var customClickText: String?
        private var memberSince: String?
        private var communityName: String?
        private var isOwner: Bool = false
        private var customTitle: String?
        private var menu: [MemberAction]?
        private var communityId: String?
        private var chatroomId: String?
        private var route: String?
        private var attendingStatus: Bool?
        private var hasProfileImage: Bool?
        private var updatedAt: Int?
        private var sdkClientInfo: SDKClientInfo?
        private var uuid: String = ""
        private var roles: [UserRole] = []

        /// Initializes a new `Builder` instance.
        public init() {}

        /**
         Sets the member's unique identifier.

         - Parameter id: The unique identifier.
         - Returns: The current `Builder` instance for chaining.
         */
        public func id(_ id: String) -> Builder {
            self.id = id
            return self
        }

        /**
         Sets the user unique identifier.

         - Parameter userUniqueId: The user unique identifier.
         - Returns: The current `Builder` instance for chaining.
         */
        public func userUniqueId(_ userUniqueId: String) -> Builder {
            self.userUniqueId = userUniqueId
            return self
        }

        /**
         Sets the member's name.

         - Parameter name: The member's name.
         - Returns: The current `Builder` instance for chaining.
         */
        public func name(_ name: String) -> Builder {
            self.name = name
            return self
        }

        /**
         Sets the member's profile image URL.

         - Parameter imageUrl: The profile image URL.
         - Returns: The current `Builder` instance for chaining.
         */
        public func imageUrl(_ imageUrl: String) -> Builder {
            self.imageUrl = imageUrl
            return self
        }

        /**
         Sets the member's question answers.

         - Parameter questionAnswers: An array of `Question` objects.
         - Returns: The current `Builder` instance for chaining.
         */
        public func questionAnswers(_ questionAnswers: [Question]?) -> Builder {
            self.questionAnswers = questionAnswers
            return self
        }

        /**
         Sets the member's state.

         - Parameter state: An integer representing the state.
         - Returns: The current `Builder` instance for chaining.
         */
        public func state(_ state: Int?) -> Builder {
            self.state = state
            return self
        }

        /**
         Sets whether the member is a guest.

         - Parameter isGuest: A Boolean indicating guest status.
         - Returns: The current `Builder` instance for chaining.
         */
        public func isGuest(_ isGuest: Bool) -> Builder {
            self.isGuest = isGuest
            return self
        }

        /**
         Sets the custom introduction text for the member.

         - Parameter customIntroText: The custom introduction text.
         - Returns: The current `Builder` instance for chaining.
         */
        public func customIntroText(_ customIntroText: String?) -> Builder {
            self.customIntroText = customIntroText
            return self
        }

        /**
         Sets the custom click text for the member.

         - Parameter customClickText: The custom click text.
         - Returns: The current `Builder` instance for chaining.
         */
        public func customClickText(_ customClickText: String?) -> Builder {
            self.customClickText = customClickText
            return self
        }

        /**
         Sets the date when the member joined.

         - Parameter memberSince: The join date as a string.
         - Returns: The current `Builder` instance for chaining.
         */
        public func memberSince(_ memberSince: String?) -> Builder {
            self.memberSince = memberSince
            return self
        }

        /**
         Sets the community name for the member.

         - Parameter communityName: The community name.
         - Returns: The current `Builder` instance for chaining.
         */
        public func communityName(_ communityName: String?) -> Builder {
            self.communityName = communityName
            return self
        }

        /**
         Sets whether the member is the owner.

         - Parameter isOwner: A Boolean indicating ownership.
         - Returns: The current `Builder` instance for chaining.
         */
        public func isOwner(_ isOwner: Bool) -> Builder {
            self.isOwner = isOwner
            return self
        }

        /**
         Sets the custom title for the member.

         - Parameter customTitle: The custom title.
         - Returns: The current `Builder` instance for chaining.
         */
        public func customTitle(_ customTitle: String?) -> Builder {
            self.customTitle = customTitle
            return self
        }

        /**
         Sets the menu actions available for the member.

         - Parameter menu: An array of `MemberAction` objects.
         - Returns: The current `Builder` instance for chaining.
         */
        public func menu(_ menu: [MemberAction]?) -> Builder {
            self.menu = menu
            return self
        }

        /**
         Sets the community identifier.

         - Parameter communityId: The community ID.
         - Returns: The current `Builder` instance for chaining.
         */
        public func communityId(_ communityId: String?) -> Builder {
            self.communityId = communityId
            return self
        }

        /**
         Sets the chatroom identifier.

         - Parameter chatroomId: The chatroom ID.
         - Returns: The current `Builder` instance for chaining.
         */
        public func chatroomId(_ chatroomId: String?) -> Builder {
            self.chatroomId = chatroomId
            return self
        }

        /**
         Sets the routing string.

         - Parameter route: The route value.
         - Returns: The current `Builder` instance for chaining.
         */
        public func route(_ route: String?) -> Builder {
            self.route = route
            return self
        }

        /**
         Sets the attending status for the member.

         - Parameter attendingStatus: A Boolean indicating attending status.
         - Returns: The current `Builder` instance for chaining.
         */
        public func attendingStatus(_ attendingStatus: Bool?) -> Builder {
            self.attendingStatus = attendingStatus
            return self
        }

        /**
         Sets whether the member has a profile image.

         - Parameter hasProfileImage: A Boolean indicating if the profile image is present.
         - Returns: The current `Builder` instance for chaining.
         */
        public func hasProfileImage(_ hasProfileImage: Bool?) -> Builder {
            self.hasProfileImage = hasProfileImage
            return self
        }

        /**
         Sets the last updated timestamp.

         - Parameter updatedAt: The update timestamp as an integer.
         - Returns: The current `Builder` instance for chaining.
         */
        public func updatedAt(_ updatedAt: Int?) -> Builder {
            self.updatedAt = updatedAt
            return self
        }

        /**
         Sets the SDK client information.

         - Parameter sdkClientInfo: An `SDKClientInfo` object.
         - Returns: The current `Builder` instance for chaining.
         */
        public func sdkClientInfo(_ sdkClientInfo: SDKClientInfo?) -> Builder {
            self.sdkClientInfo = sdkClientInfo
            return self
        }

        /**
         Sets the UUID for the member.

         - Parameter uuid: The UUID as a string.
         - Returns: The current `Builder` instance for chaining.
         */
        public func uuid(_ uuid: String) -> Builder {
            self.uuid = uuid
            return self
        }

        /**
         Sets the roles assigned to the member.

         - Parameter roles: An array of `UserRole` objects.
         - Returns: The current `Builder` instance for chaining.
         */
        public func roles(_ roles: [UserRole]) -> Builder {
            self.roles = roles
            return self
        }

        /**
         Builds and returns a `Member` instance with the configured properties.

         - Returns: A fully constructed `Member` object.
         */
        public func build() -> Member {
            var member = Member()
            member.id = self.id
            member.userUniqueId = self.userUniqueId
            member.name = self.name
            member.imageUrl = self.imageUrl
            member.questionAnswers = self.questionAnswers
            member.state = self.state
            member.isGuest = self.isGuest
            member.customIntroText = self.customIntroText
            member.customClickText = self.customClickText
            member.memberSince = self.memberSince
            member.communityName = self.communityName
            member.isOwner = self.isOwner
            member.customTitle = self.customTitle
            member.menu = self.menu
            member.communityId = self.communityId
            member.chatroomId = self.chatroomId
            member.route = self.route
            member.attendingStatus = self.attendingStatus
            member.hasProfileImage = self.hasProfileImage
            member.updatedAt = self.updatedAt
            member.sdkClientInfo = self.sdkClientInfo
            member.uuid = self.uuid
            member.roles = self.roles
            return member
        }
    }

    /**
     Returns a new builder pre-populated with the current member's properties.

     This allows for convenient modification of an existing `Member` instance using the builder pattern.

     - Returns: A `Builder` instance initialized with the current values.
     */
    public func toBuilder() -> Builder {
        return Builder()
            .id(id ?? "")
            .userUniqueId(userUniqueId ?? "")
            .name(name ?? "")
            .imageUrl(imageUrl ?? "")
            .questionAnswers(questionAnswers)
            .state(state)
            .isGuest(isGuest)
            .customIntroText(customIntroText)
            .customClickText(customClickText)
            .memberSince(memberSince)
            .communityName(communityName)
            .isOwner(isOwner)
            .customTitle(customTitle)
            .menu(menu)
            .communityId(communityId)
            .chatroomId(chatroomId)
            .route(route)
            .attendingStatus(attendingStatus)
            .hasProfileImage(hasProfileImage)
            .updatedAt(updatedAt)
            .sdkClientInfo(sdkClientInfo)
            .uuid(uuid ?? "")
            .roles(roles ?? [])
    }

    /**
     Returns a string indicating the member's role as a community manager if applicable.

     If the member's state is equal to 1, this method returns "Community manager"; otherwise, it returns `nil`.

     - Returns: A string representing the community manager role, or `nil` if not applicable.
     */
    public func communityManager() -> String? {
        switch state {
        case 1:
            return "Community manager"
        default:
            return nil
        }
    }
}
