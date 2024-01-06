//
//  _LinkOGTags_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 21/12/23.
//

import Foundation

struct _LinkOGTags_: Decodable {
    
    var title: String?
    var image: String?
    var description: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case title, image, description, url
    }
    
    init(title: String?, image: String?, description: String?, url: String?) {
        self.title = title
        self.image = image
        self.description = description
        self.url = url
    }
}
