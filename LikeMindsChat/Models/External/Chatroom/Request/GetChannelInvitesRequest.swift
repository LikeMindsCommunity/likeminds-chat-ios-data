//
//  GetChannelInviteRequest.swift
//  LikeMindsChat
//
//  Created by Anurag Tyagi on 17/01/25.
//


//
//  GetChannelInviteRequest.swift
//  LikeMindsChat
//
//  Created by Your Name on 18/01/24.
//

import Foundation

/// A request object for retrieving channel invites in the LikeMinds Chat SDK.
/// This class provides a builder pattern for creating instances with customizable parameters.
///
/// - Note: Instances of this class are immutable once built. Use the `builder` method to construct or modify an instance.
public class GetChannelInvitesRequest: Encodable {

    // MARK: - Properties

    /// The type of the channel.
    let channelType: Int

    /// The page number for paginated results.
    /// Defaults to `1`.
    let page: Int

    /// The number of results to retrieve per page.
    /// Defaults to `10`.
    let pageSize: Int

    // MARK: - Initializer

    /// Private initializer to enforce the use of the builder pattern.
    ///
    /// - Parameters:
    ///   - channelType: The type of the channel.
    ///   - page: The page number for paginated results.
    ///   - pageSize: The number of results per page.
    private init(
        channelType: Int,
        page: Int,
        pageSize: Int
    ) {
        self.channelType = channelType
        self.page = page
        self.pageSize = pageSize
    }

    // MARK: - Coding Keys

    /// Maps the properties to their respective keys in the JSON request body.
    private enum CodingKeys: String, CodingKey {
        case channelType = "channel_type"
        case page
        case pageSize = "page_size"
    }

    // MARK: - Builder Pattern

    /// Creates a new builder for constructing a `GetChannelInviteRequest` object.
    ///
    /// - Returns: An instance of `Builder` to configure the request.
    public static func builder() -> Builder {
        return Builder()
    }

    /// A nested builder class for constructing `GetChannelInviteRequest` objects.
    public class Builder {

        // MARK: - Builder Properties

        /// The type of the channel to configure in the request.
        private var channelType: Int = 0

        /// The page number to configure in the request.
        private var page: Int = 1

        /// The number of results per page to configure in the request.
        private var pageSize: Int = 10

        // MARK: - Builder Methods

        /// Sets the channel type.
        ///
        /// - Parameter channelType: The type of the channel.
        /// - Returns: The current builder instance.
        public func channelType(_ channelType: Int) -> Builder {
            self.channelType = channelType
            return self
        }

        /// Sets the page number for paginated results.
        ///
        /// - Parameter page: The page number.
        /// - Returns: The current builder instance.
        public func page(_ page: Int) -> Builder {
            self.page = page
            return self
        }

        /// Sets the number of results per page.
        ///
        /// - Parameter pageSize: The number of results per page.
        /// - Returns: The current builder instance.
        public func pageSize(_ pageSize: Int) -> Builder {
            self.pageSize = pageSize
            return self
        }

        /// Builds and returns a `GetChannelInviteRequest` object.
        ///
        /// - Returns: A fully configured `GetChannelInviteRequest` instance.
        public func build() -> GetChannelInvitesRequest {
            return GetChannelInvitesRequest(
                channelType: channelType,
                page: page,
                pageSize: pageSize
            )
        }
    }

    // MARK: - Builder Conversion

    /// Converts the current `GetChannelInviteRequest` instance into a builder for modification.
    ///
    /// - Returns: A `Builder` initialized with the current request's values.
    public func toBuilder() -> Builder {
        return Builder()
            .channelType(channelType)
            .page(page)
            .pageSize(pageSize)
    }
}
