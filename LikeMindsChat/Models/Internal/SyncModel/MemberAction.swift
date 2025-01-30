//
//  _MemberAction_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 09/01/24.
//

import Foundation

public struct MemberAction: Decodable {
    public var title: String?
    public var route: String?
    
    public init(title: String? = nil, route: String? = nil) {
        self.title = title
        self.route = route
    }
}
