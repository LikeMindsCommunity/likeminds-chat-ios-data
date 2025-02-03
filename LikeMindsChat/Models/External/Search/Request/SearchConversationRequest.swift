//
//  SearchConversationRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 18/01/24.
//

import Foundation

/// A request object for searching conversations in the LikeMinds Chat SDK.
/// This class provides a builder pattern for creating instances with customizable search parameters.
///
/// - Note: Instances of this class are immutable once built. Use the `builder` method to construct or modify an instance.
public class SearchConversationRequest: Encodable {

    // MARK: - Properties

    /// The search query string used to find conversations.
    let search: String
    let chatroomId: String?

    /// The follow status filter for the search.
    /// - `true`: Search for conversations followed by the user.
    /// - `false`: Search for all conversations regardless of follow status.
    let followStatus: Bool?

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
    ///   - search: The search query string.
    ///   - chatroomId: The id of the chatroom
    ///   - followStatus: The follow status filter.
    ///   - page: The page number for paginated results.
    ///   - pageSize: The number of results per page.
    ///
    private init(
        search: String, chatroomId: String?, followStatus: Bool?, page: Int,
        pageSize: Int
    ) {
        self.search = search
        self.followStatus = followStatus
        self.page = page
        self.pageSize = pageSize
        self.chatroomId = chatroomId
    }

    // MARK: - Coding Keys

    /// Maps the properties to their respective keys in the JSON request body.
    private enum CodingKeys: String, CodingKey {
        case search
        case chatroomId = "chatroom_id"
        case followStatus = "follow_status"
        case page
        case pageSize = "page_size"
    }

    // MARK: - Builder Pattern

    /// Creates a new builder for constructing a `SearchConversationRequest` object.
    ///
    /// - Returns: An instance of `Builder` to configure the request.
    public static func builder() -> Builder {
        return Builder()
    }

    /// A nested builder class for constructing `SearchConversationRequest` objects.
    public class Builder {

        // MARK: - Builder Properties

        /// The search query string to configure in the request.
        private var search: String = ""

        private var chatroomId: String?

        /// The follow status filter to configure in the request.
        private var followStatus: Bool?

        /// The page number to configure in the request.
        private var page: Int = 1

        /// The number of results per page to configure in the request.
        private var pageSize: Int = 10

        // MARK: - Builder Methods

        /// Sets the search query.
        ///
        /// - Parameter search: The search query string.
        /// - Returns: The current builder instance.
        public func search(_ search: String) -> Builder {
            self.search = search
            return self
        }

        /// Sets the chatroom id .
        ///
        /// - Parameter chatroomId: The id of chatroom to be search in
        /// - Returns: The current builder instance.
        public func chatroomId(_ chatroomId: String?) -> Builder {
            self.chatroomId = chatroomId
            return self
        }

        /// Sets the follow status filter.
        ///
        /// - Parameter followStatus: The follow status (`true` for followed conversations, `false` otherwise).
        /// - Returns: The current builder instance.
        public func followStatus(_ followStatus: Bool?) -> Builder {
            self.followStatus = followStatus
            return self
        }

        /// Sets the page number for paginated results.
        ///
        /// - Parameter page: The page number to retrieve.
        /// - Returns: The current builder instance.
        public func page(_ page: Int) -> Builder {
            self.page = page
            return self
        }

        /// Sets the number of results per page.
        ///
        /// - Parameter pageSize: The number of results to retrieve per page.
        /// - Returns: The current builder instance.
        public func pageSize(_ pageSize: Int) -> Builder {
            self.pageSize = pageSize
            return self
        }

        /// Builds and returns a `SearchConversationRequest` object.
        ///
        /// - Returns: A fully configured `SearchConversationRequest` instance.
        public func build() -> SearchConversationRequest {
            return SearchConversationRequest(
                search: search,
                chatroomId: chatroomId,
                followStatus: followStatus,
                page: page,
                pageSize: pageSize
            )
        }
    }

    // MARK: - Builder Conversion

    /// Converts the current `SearchConversationRequest` instance into a builder for modification.
    ///
    /// - Returns: A `Builder` initialized with the current request's values.
    public func toBuilder() -> Builder {
        return Builder()
            .search(search)
            .chatroomId(chatroomId)
            .followStatus(followStatus)
            .page(page)
            .pageSize(pageSize)
    }
}
