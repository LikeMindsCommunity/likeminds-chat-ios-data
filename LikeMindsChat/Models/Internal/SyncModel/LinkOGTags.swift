//
//  _LinkOGTags_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 21/12/23.
//

import Foundation

// MARK: LinkOGTags
/// A model representing Open Graph (OG) tags for a link.
///
/// This model encapsulates common OG tag properties such as title, image, description, and URL,
/// which are typically used to provide rich link previews in applications.
///
/// - Note: `LinkOGTags` conforms to `Codable` for easy encoding and decoding from JSON.
public struct LinkOGTags: Codable {

    /// The title of the link.
    public var title: String?

    /// The URL of the image associated with the link.
    public var image: String?

    /// A brief description of the link.
    public var description: String?

    /// The URL of the link.
    public var url: String?

    /**
     Coding keys used to map JSON keys to the corresponding properties.

     In this case, the keys are identical to the property names.
     */
    enum CodingKeys: String, CodingKey {
        case title, image, description, url
    }

    /**
     Initializes a new instance of `LinkOGTags` with the provided values.

     - Parameters:
       - title: The title for the link.
       - image: The URL string for the image.
       - description: A description of the link.
       - url: The URL of the link.
     */
    init(title: String?, image: String?, description: String?, url: String?) {
        self.title = title
        self.image = image
        self.description = description
        self.url = url
    }

    // MARK: - Builder Pattern

    /**
     A builder class for constructing `LinkOGTags` instances.

     This builder provides a fluent interface to set properties for a `LinkOGTags` object and build the final instance.
     */
    public class Builder {
        private var title: String?
        private var image: String?
        private var description: String?
        private var url: String?

        /**
         Sets the title for the `LinkOGTags`.

         - Parameter title: The title to set.
         - Returns: The current `Builder` instance for chaining.
         */
        public func title(_ title: String?) -> Builder {
            self.title = title
            return self
        }

        /**
         Sets the image URL for the `LinkOGTags`.

         - Parameter image: The image URL to set.
         - Returns: The current `Builder` instance for chaining.
         */
        public func image(_ image: String?) -> Builder {
            self.image = image
            return self
        }

        /**
         Sets the description for the `LinkOGTags`.

         - Parameter description: The description to set.
         - Returns: The current `Builder` instance for chaining.
         */
        public func description(_ description: String?) -> Builder {
            self.description = description
            return self
        }

        /**
         Sets the URL for the `LinkOGTags`.

         - Parameter url: The URL to set.
         - Returns: The current `Builder` instance for chaining.
         */
        public func url(_ url: String?) -> Builder {
            self.url = url
            return self
        }

        /**
         Builds and returns a new `LinkOGTags` instance with the configured properties.

         - Returns: A `LinkOGTags` object with the specified properties.
         */
        public func build() -> LinkOGTags {
            return LinkOGTags(
                title: title,
                image: image,
                description: description,
                url: url
            )
        }

        /// Initializes a new `Builder` instance.
        public init() {}
    }

    /**
     Returns a new builder pre-populated with the current `LinkOGTags` properties.

     This is useful for modifying an existing `LinkOGTags` instance using the builder pattern.

     - Returns: A `Builder` instance with the current values.
     */
    public func toBuilder() -> Builder {
        return Builder()
            .title(title)
            .image(image)
            .description(description)
            .url(url)
    }
}
