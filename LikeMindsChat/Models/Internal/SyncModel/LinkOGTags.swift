//
//  _LinkOGTags_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 21/12/23.
//

import Foundation

public struct LinkOGTags: Codable {
    
    public var title: String?
    public var image: String?
    public var description: String?
    public var url: String?
    
    enum CodingKeys: String, CodingKey {
        case title, image, description, url
    }
    
    init(title: String?, image: String?, description: String?, url: String?) {
        self.title = title
        self.image = image
        self.description = description
        self.url = url
    }
    
    public class Builder {
        private var title: String?
        private var image: String?
        private var description: String?
        private var url: String?
        
        public func title(_ title: String?) -> Builder {
            self.title = title
            return self
        }
        
        public func image(_ image: String?) -> Builder {
            self.image = image
            return self
        }
        
        public func description(_ description: String?) -> Builder {
            self.description = description
            return self
        }
        
        public func url(_ url: String?) -> Builder {
            self.url = url
            return self
        }
        
        public func build() -> LinkOGTags {
            return LinkOGTags(
                title: title,
                image: image,
                description: description,
                url: url
            )
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder()
            .title(title)
            .image(image)
            .description(description)
            .url(url)
    }
}
