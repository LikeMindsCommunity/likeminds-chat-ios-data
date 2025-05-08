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
public struct MemberAction: Codable {
  public var title: String?
  public var route: String?

  enum CodingKeys: String, CodingKey {
    case title
    case route
  }
    
  public init(title: String?, route: String?){
     self.title = title
     self.route = route
  }
 

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    title = try container.decodeIfPresent(String.self, forKey: .title)
    route = try container.decodeIfPresent(String.self, forKey: .route)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encodeIfPresent(title, forKey: .title)
    try container.encodeIfPresent(route, forKey: .route)
  }
}
