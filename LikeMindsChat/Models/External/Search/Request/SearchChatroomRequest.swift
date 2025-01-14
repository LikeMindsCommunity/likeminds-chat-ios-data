//
//  SearchChatroomRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 18/01/24.
//

import Foundation

/// A request object for searching chatrooms in the LikeMinds Chat SDK.
/// This class provides a flexible builder pattern to configure the search parameters.
///
/// - Note: This class is designed to be immutable once built. Use the `builder` method
///         or `toBuilder()` for constructing or modifying an instance.
public class SearchChatroomRequest: Encodable {

    // MARK: - Properties

    /// The search query string used to find chatrooms.
    var search: String = ""

    /// The follow status filter for the search.
    /// - `true`: Search for chatrooms followed by the user.
    /// - `false`: Search for all chatrooms regardless of follow status.
    var followStatus: Bool = false

    /// The page number for paginated results.
    /// Defaults to `1`.
    var page: Int = 1

    /// The number of results to retrieve per page.
    /// Defaults to `10`.
    var pageSize: Int = 10

    /// The type of search to perform.
    /// This parameter allows you to specify the search criteria, e.g., by topic or chatroom type.
    var searchType: String = ""

    // MARK: - Initializer

    /// Private initializer to enforce the use of the builder pattern.
    private init() {}

    // MARK: - Coding Keys

    /// Custom coding keys for mapping JSON keys to properties.
    private enum CodingKeys: String, CodingKey {
        case search
        case followStatus = "follow_status"
        case page
        case pageSize = "page_size"
        case searchType = "search_type"
    }

    // MARK: - Builder Pattern

    /// Creates a new builder for constructing a `SearchChatroomRequest` object.
    ///
    /// - Returns: An instance of `Builder` to configure the request.
    public static func builder() -> Builder {
        return Builder()
    }

    /// A nested builder class for constructing `SearchChatroomRequest` objects.
    public class Builder {
        private var request: SearchChatroomRequest

        /// Initializes a new builder instance.
        init() {
            request = SearchChatroomRequest()
        }

        /// Sets the search query.
        ///
        /// - Parameter search: The search query string.
        /// - Returns: The current builder instance.
        public func search(_ search: String) -> Builder {
            request.search = search
            return self
        }

        /// Sets the follow status filter.
        ///
        /// - Parameter followStatus: The follow status (`true` for followed chatrooms, `false` otherwise).
        /// - Returns: The current builder instance.
        public func followStatus(_ followStatus: Bool) -> Builder {
            request.followStatus = followStatus
            return self
        }

        /// Sets the page number for paginated results.
        ///
        /// - Parameter page: The page number to retrieve.
        /// - Returns: The current builder instance.
        public func page(_ page: Int) -> Builder {
            request.page = page
            return self
        }

        /// Sets the number of results per page.
        ///
        /// - Parameter pageSize: The number of results to retrieve per page.
        /// - Returns: The current builder instance.
        public func pageSize(_ pageSize: Int) -> Builder {
            request.pageSize = pageSize
            return self
        }

        /// Sets the search type.
        ///
        /// - Parameter searchType: The type of search to perform (e.g., by topic or chatroom type).
        /// - Returns: The current builder instance.
        public func searchType(_ searchType: String) -> Builder {
            request.searchType = searchType
            return self
        }

        /// Builds and returns a `SearchChatroomRequest` object.
        ///
        /// - Returns: A fully configured `SearchChatroomRequest` instance.
        public func build() -> SearchChatroomRequest {
            return request
        }
    }

    /// Converts the current `SearchChatroomRequest` instance into a builder for modification.
    ///
    /// - Returns: A `Builder` initialized with the current request's values.
    public func toBuilder() -> Builder {
        return Builder()
            .search(search)
            .followStatus(followStatus)
            .page(page)
            .pageSize(pageSize)
            .searchType(searchType)
    }
}
