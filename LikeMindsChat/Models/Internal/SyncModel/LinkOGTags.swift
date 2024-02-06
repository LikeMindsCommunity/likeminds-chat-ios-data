//
//  _LinkOGTags_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 21/12/23.
//

import Foundation

struct LinkOGTags: Codable {
    
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
    
    class Builder {
        private var title: String?
        private var image: String?
        private var description: String?
        private var url: String?
        
        func title(_ title: String?) -> Builder {
            self.title = title
            return self
        }
        
        func image(_ image: String?) -> Builder {
            self.image = image
            return self
        }
        
        func description(_ description: String?) -> Builder {
            self.description = description
            return self
        }
        
        func url(_ url: String?) -> Builder {
            self.url = url
            return self
        }
        
        func build() -> LinkOGTags {
            return LinkOGTags(
                title: title,
                image: image,
                description: description,
                url: url
            )
        }
    }
    
    func toBuilder() -> Builder {
        return Builder()
            .title(title)
            .image(image)
            .description(description)
            .url(url)
    }
}
