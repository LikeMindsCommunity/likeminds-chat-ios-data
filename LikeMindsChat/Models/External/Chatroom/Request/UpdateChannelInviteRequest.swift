//
//  UpdateChannelInviteRequest.swift
//  LikeMindsChat
//
//  Created by Anurag Tyagi on 17/01/25.
//

//
//  UpdateChannelInviteRequest.swift
//  LikeMindsChat
//
//  Created by Your Name on 17/01/25.
//

import Foundation

/// Represents the status of a channel invite.
public enum ChannelInviteStatus: Int, Encodable {
    case invited = 0
    case accepted = 1
    case rejected = 2
    // Add other statuses if needed.
}

/// A request object for updating a channel invite in the LikeMinds Chat SDK.
/// This class provides a builder pattern for creating instances with customizable parameters.
///
/// - Note: Instances of this class are immutable once built.
///         Use the `builder` method to construct or modify an instance.
public class UpdateChannelInviteRequest: Encodable {

    // MARK: - Properties

    /// The unique identifier of the channel.
    public let channelId: String

    /// The desired invite status (e.g., accept or reject).
    public let inviteStatus: ChannelInviteStatus

    // MARK: - Private Initializer

    /// Private initializer to enforce the use of the builder pattern.
    ///
    /// - Parameters:
    ///   - channelId: The unique channel identifier.
    ///   - inviteStatus: The new invite status.
    private init(
        channelId: String,
        inviteStatus: ChannelInviteStatus
    ) {
        self.channelId = channelId
        self.inviteStatus = inviteStatus
    }

    // MARK: - Coding Keys

    /// Maps the properties to their respective keys in the JSON request body.
    private enum CodingKeys: String, CodingKey {
        case channelId = "channel_id"
        case inviteStatus = "invite_status"
    }

    // MARK: - Builder Pattern

    /// Creates a new builder for constructing an `UpdateChannelInviteRequest` object.
    ///
    /// - Returns: An instance of `Builder` to configure the request.
    public static func builder() -> Builder {
        return Builder()
    }

    /// A nested builder class for constructing `UpdateChannelInviteRequest` objects.
    public class Builder {

        // MARK: - Builder Properties

        private var channelId: String = ""
        private var inviteStatus: ChannelInviteStatus = .invited

        // MARK: - Builder Methods

        /// Sets the unique identifier of the channel.
        ///
        /// - Parameter channelId: The channel's identifier.
        /// - Returns: The current builder instance.
        public func channelId(_ channelId: String) -> Builder {
            self.channelId = channelId
            return self
        }

        /// Sets the desired invite status (e.g., accepted or rejected).
        ///
        /// - Parameter inviteStatus: The new invite status.
        /// - Returns: The current builder instance.
        public func inviteStatus(_ inviteStatus: ChannelInviteStatus) -> Builder
        {
            self.inviteStatus = inviteStatus
            return self
        }

        /// Builds and returns an `UpdateChannelInviteRequest` object.
        ///
        /// - Returns: A fully configured `UpdateChannelInviteRequest` instance.
        public func build() -> UpdateChannelInviteRequest {
            return UpdateChannelInviteRequest(
                channelId: channelId,
                inviteStatus: inviteStatus
            )
        }
    }

    // MARK: - Builder Conversion

    /// Converts the current `UpdateChannelInviteRequest` instance into a builder for modification.
    ///
    /// - Returns: A `Builder` initialized with the current request's values.
    public func toBuilder() -> Builder {
        return Builder()
            .channelId(channelId)
            .inviteStatus(inviteStatus)
    }
}
