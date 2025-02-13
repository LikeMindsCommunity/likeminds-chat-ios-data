//
//  Attachment.swift
//  CollabMates
//
//  Created by Devansh Mohata on 20/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

/// Represents an attachment associated with a chat or content item.
///
/// The `Attachment` struct conforms to `Codable` and supports both decoding from and encoding to JSON.
/// It contains various metadata properties such as the attachment’s URL, dimensions, file paths,
/// and additional metadata through an optional `AttachmentMeta` object.
///
/// The struct also supports an alternative decoding strategy for URLs by looking for alternate keys
/// (e.g. `"file_url"`, `"image_url"`, `"video_url"`) if the primary `"url"` key is not present.
public struct Attachment: Codable {

    /// The unique identifier of the attachment.
    public let id: String?

    /// The name of the attachment (e.g., file name).
    public let name: String?

    /// The URL of the attachment.
    public var url: String?

    /// The type of the attachment (e.g., image, video, etc.).
    public let type: String?

    /// The index of the attachment in a collection.
    public let index: Int?

    /// The width (in pixels) of the attachment if applicable.
    public let width: Int?

    /// The height (in pixels) of the attachment if applicable.
    public let height: Int?

    /// The AWS folder path where the attachment is stored.
    public let awsFolderPath: String?

    /// The local file path for the attachment.
    public let localFilePath: String?

    /// The URL of the thumbnail image for the attachment.
    public let thumbnailUrl: String?

    /// The AWS folder path where the thumbnail is stored.
    public let thumbnailAWSFolderPath: String?

    /// The local file path for the thumbnail image.
    public let thumbnailLocalFilePath: String?

    /// Additional metadata for the attachment.
    public let meta: AttachmentMeta?

    /// The creation timestamp (in Unix time) for the attachment.
    public let createdAt: Int?

    /// The last update timestamp (in Unix time) for the attachment.
    public let updatedAt: Int?

    /**
     The primary coding keys corresponding to the JSON keys.

     These keys are used to map JSON values to the properties of the `Attachment` struct.
     */
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url = "url"
        case type
        case index
        case width
        case height
        case awsFolderPath = "aws_folder_path"
        case localFilePath = "local_file_path"
        case thumbnailUrl = "thumbnail_url"
        case thumbnailAWSFolderPath = "thumbnail_aws_folder_path"
        case thumbnailLocalFilePath = "thumbnail_local_folder_path"
        case meta
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    /**
     Alternate coding keys for URL properties.

     In case the primary key `"url"` is missing, the decoder will attempt to retrieve the URL value
     using these alternate keys.
     */
    enum AlternateKeys: String, CodingKey {
        case fileUrl = "file_url"
        case imageUrl = "image_url"
        case videoUrl = "video_url"
    }

    /**
     Custom initializer to decode an `Attachment` instance from a decoder.

     This initializer first attempts to decode using the primary keys defined in `CodingKeys`. If the
     `"url"` key is not found, it attempts to decode using the alternate keys from `AlternateKeys`.

     - Parameter decoder: The decoder to read data from.
     - Throws: An error if decoding fails.
     */
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let alternativeContainer = try decoder.container(
            keyedBy: AlternateKeys.self)

        id = try container.decodeIntToStringIfPresent(forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        if url == nil {
            url = try alternativeContainer.decodeIfPresent(
                String.self, forKey: .fileUrl)
        }
        if url == nil {
            url = try alternativeContainer.decodeIfPresent(
                String.self, forKey: .imageUrl)
        }
        if url == nil {
            url = try alternativeContainer.decodeIfPresent(
                String.self, forKey: .videoUrl)
        }
        type = try container.decodeIfPresent(String.self, forKey: .type)
        index = try container.decodeIfPresent(Int.self, forKey: .index)
        width = try container.decodeIfPresent(Int.self, forKey: .width)
        height = try container.decodeIfPresent(Int.self, forKey: .height)
        awsFolderPath = try container.decodeIfPresent(
            String.self, forKey: .awsFolderPath)
        localFilePath = try container.decodeIfPresent(
            String.self, forKey: .localFilePath)
        thumbnailUrl = try container.decodeIfPresent(
            String.self, forKey: .thumbnailUrl)
        thumbnailAWSFolderPath = try container.decodeIfPresent(
            String.self, forKey: .thumbnailAWSFolderPath)
        thumbnailLocalFilePath = try container.decodeIfPresent(
            String.self, forKey: .thumbnailLocalFilePath)
        meta = try container.decodeIfPresent(AttachmentMeta.self, forKey: .meta)
        createdAt = try container.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try container.decodeIfPresent(Int.self, forKey: .updatedAt)
    }

    /**
     Private initializer used by the builder to create an `Attachment` instance.

     - Parameters:
       - id: The unique identifier.
       - name: The name of the attachment.
       - url: The URL of the attachment.
       - type: The type of the attachment.
       - index: The index of the attachment.
       - width: The width of the attachment.
       - height: The height of the attachment.
       - awsFolderPath: The AWS folder path.
       - localFilePath: The local file path.
       - thumbnailUrl: The thumbnail URL.
       - thumbnailAWSFolderPath: The AWS folder path for the thumbnail.
       - thumbnailLocalFilePath: The local file path for the thumbnail.
       - meta: The attachment metadata.
       - createdAt: The creation timestamp.
       - updatedAt: The update timestamp.
     */
    private init(
        id: String?, name: String?, url: String, type: String, index: Int?,
        width: Int?, height: Int?, awsFolderPath: String?,
        localFilePath: String?, thumbnailUrl: String?,
        thumbnailAWSFolderPath: String?, thumbnailLocalFilePath: String?,
        meta: AttachmentMeta?, createdAt: Int?, updatedAt: Int?
    ) {
        self.id = id
        self.name = name
        self.url = url
        self.type = type
        self.index = index
        self.width = width
        self.height = height
        self.awsFolderPath = awsFolderPath
        self.localFilePath = localFilePath
        self.thumbnailUrl = thumbnailUrl
        self.thumbnailAWSFolderPath = thumbnailAWSFolderPath
        self.thumbnailLocalFilePath = thumbnailLocalFilePath
        self.meta = meta
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    /**
     Custom encoder to encode an `Attachment` instance to an encoder.

     This method encodes only non-nil values for each property.

     - Parameter encoder: The encoder to write data to.
     - Throws: An error if encoding fails.
     */
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(url, forKey: .url)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(index, forKey: .index)
        try container.encodeIfPresent(width, forKey: .width)
        try container.encodeIfPresent(height, forKey: .height)
        try container.encodeIfPresent(awsFolderPath, forKey: .awsFolderPath)
        try container.encodeIfPresent(localFilePath, forKey: .localFilePath)
        try container.encodeIfPresent(thumbnailUrl, forKey: .thumbnailUrl)
        try container.encodeIfPresent(
            thumbnailAWSFolderPath, forKey: .thumbnailAWSFolderPath)
        try container.encodeIfPresent(
            thumbnailLocalFilePath, forKey: .thumbnailLocalFilePath)
        try container.encodeIfPresent(meta, forKey: .meta)
        try container.encodeIfPresent(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(updatedAt, forKey: .updatedAt)
    }

    // MARK: - Builder Pattern

    /**
     Returns a new `Builder` instance to construct an `Attachment`.

     - Returns: A `Builder` instance.
     */
    public static func builder() -> Builder {
        return Builder()
    }

    /**
     A builder class for constructing `Attachment` instances.

     This class provides a fluent interface to set properties and build the final `Attachment` object.
     */
    public class Builder {
        private var id: String?
        private var name: String?
        private var url: String = ""
        private var type: String = ""
        private var index: Int? = nil
        private var width: Int? = nil
        private var height: Int? = nil
        private var awsFolderPath: String? = nil
        private var localFilePath: String? = nil
        private var thumbnailUrl: String? = nil
        private var thumbnailAWSFolderPath: String? = nil
        private var thumbnailLocalFilePath: String? = nil
        private var meta: AttachmentMeta? = nil
        private var createdAt: Int? = nil
        private var updatedAt: Int? = nil

        /// Initializes a new `Builder` instance.
        public init() {}

        /// Sets the attachment ID.
        public func id(_ id: String?) -> Builder {
            self.id = id
            return self
        }

        /// Sets the attachment name.
        public func name(_ name: String?) -> Builder {
            self.name = name
            return self
        }

        /// Sets the attachment URL.
        public func url(_ url: String) -> Builder {
            self.url = url
            return self
        }

        /// Sets the attachment type.
        public func type(_ type: String) -> Builder {
            self.type = type
            return self
        }

        /// Sets the index of the attachment.
        public func index(_ index: Int?) -> Builder {
            self.index = index
            return self
        }

        /// Sets the width of the attachment.
        public func width(_ width: Int?) -> Builder {
            self.width = width
            return self
        }

        /// Sets the height of the attachment.
        public func height(_ height: Int?) -> Builder {
            self.height = height
            return self
        }

        /// Sets the AWS folder path for the attachment.
        public func awsFolderPath(_ awsFolderPath: String?) -> Builder {
            self.awsFolderPath = awsFolderPath
            return self
        }

        /// Sets the local file path for the attachment.
        public func localFilePath(_ localFilePath: String?) -> Builder {
            self.localFilePath = localFilePath
            return self
        }

        /// Sets the thumbnail URL for the attachment.
        public func thumbnailUrl(_ thumbnailUrl: String?) -> Builder {
            self.thumbnailUrl = thumbnailUrl
            return self
        }

        /// Sets the AWS folder path for the thumbnail.
        public func thumbnailAWSFolderPath(_ thumbnailAWSFolderPath: String?)
            -> Builder
        {
            self.thumbnailAWSFolderPath = thumbnailAWSFolderPath
            return self
        }

        /// Sets the local file path for the thumbnail.
        public func thumbnailLocalFilePath(_ thumbnailLocalFilePath: String?)
            -> Builder
        {
            self.thumbnailLocalFilePath = thumbnailLocalFilePath
            return self
        }

        /// Sets the attachment metadata.
        public func meta(_ meta: AttachmentMeta?) -> Builder {
            self.meta = meta
            return self
        }

        /// Sets the creation timestamp.
        public func createdAt(_ createdAt: Int?) -> Builder {
            self.createdAt = createdAt
            return self
        }

        /// Sets the update timestamp.
        public func updatedAt(_ updatedAt: Int?) -> Builder {
            self.updatedAt = updatedAt
            return self
        }

        /**
         Builds and returns the `Attachment` instance with the configured properties.

         - Returns: An `Attachment` object.
         */
        public func build() -> Attachment {
            return Attachment(
                id: id,
                name: name,
                url: url,
                type: type,
                index: index,
                width: width,
                height: height,
                awsFolderPath: awsFolderPath,
                localFilePath: localFilePath,
                thumbnailUrl: thumbnailUrl,
                thumbnailAWSFolderPath: thumbnailAWSFolderPath,
                thumbnailLocalFilePath: thumbnailLocalFilePath,
                meta: meta,
                createdAt: createdAt,
                updatedAt: updatedAt
            )
        }
    }

    /**
     Returns a builder pre-populated with the current `Attachment`'s properties.

     This is useful for modifying an existing attachment.

     - Returns: A `Builder` instance with the current values.
     */
    public func toBuilder() -> Builder {
        return Builder()
            .id(id)
            .name(name)
            .url(url ?? "")
            .type(type ?? "")
            .index(index)
            .width(width)
            .height(height)
            .awsFolderPath(awsFolderPath)
            .localFilePath(localFilePath)
            .thumbnailUrl(thumbnailUrl)
            .thumbnailAWSFolderPath(thumbnailAWSFolderPath)
            .thumbnailLocalFilePath(thumbnailLocalFilePath)
            .meta(meta)
            .createdAt(createdAt)
            .updatedAt(updatedAt)
    }
}
