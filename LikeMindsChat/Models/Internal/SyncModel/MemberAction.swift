//
//  _MemberAction_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 09/01/24.
//

import Foundation

/// Represents an action available for a member in the LikeMindsChat application.
///
/// The `MemberAction` struct encapsulates a title and a route which together define an action
/// that can be performed by or on a member (for example, a menu option). This model conforms to
/// the `Decodable` protocol to support JSON decoding.
///
/// - Properties:
///    - title: The display title of the action.
///    - route: The navigation route or identifier associated with the action.
public struct MemberAction: Decodable {

    /// The display title of the member action.
    public var title: String?

    /// The route (or identifier) associated with the action.
    public var route: String?

    /**
     Initializes a new `MemberAction` instance with the specified title and route.

     - Parameters:
        - title: The title for the action. Defaults to `nil`.
        - route: The route or identifier for the action. Defaults to `nil`.
     */
    public init(title: String? = nil, route: String? = nil) {
        self.title = title
        self.route = route
    }
}
