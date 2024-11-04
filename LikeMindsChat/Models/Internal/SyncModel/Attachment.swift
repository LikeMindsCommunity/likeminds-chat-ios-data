//
//  Attachment.swift
//  CollabMates
//
//  Created by Devansh Mohata on 20/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

public struct Attachment: Codable {
    public let id: String?
    public let name: String?
    public var url: String?
    public let type: String?
    public let index: Int?
    public let width: Int?
    public let height: Int?
    public let awsFolderPath: String?
    public let localFilePath: String?
    public let thumbnailUrl: String?
    public let thumbnailAWSFolderPath: String?
    public let thumbnailLocalFilePath: String?
    public let meta: AttachmentMeta?
    public let createdAt: Int?
    public let updatedAt: Int?

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

    enum AlternateKeys: String, CodingKey {
        case fileUrl = "file_url"
        case imageUrl = "image_url"
        case videoUrl = "video_url"
    }

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

    // Custom encoder
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

    public static func builder() -> Builder {
        return Builder()
    }

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

        public func id(_ id: String?) -> Builder {
            self.id = id
            return self
        }

        public func name(_ name: String?) -> Builder {
            self.name = name
            return self
        }

        public func url(_ url: String) -> Builder {
            self.url = url
            return self
        }

        public func type(_ type: String) -> Builder {
            self.type = type
            return self
        }

        public func index(_ index: Int?) -> Builder {
            self.index = index
            return self
        }

        public func width(_ width: Int?) -> Builder {
            self.width = width
            return self
        }

        public func height(_ height: Int?) -> Builder {
            self.height = height
            return self
        }

        public func awsFolderPath(_ awsFolderPath: String?) -> Builder {
            self.awsFolderPath = awsFolderPath
            return self
        }

        public func localFilePath(_ localFilePath: String?) -> Builder {
            self.localFilePath = localFilePath
            return self
        }

        public func thumbnailUrl(_ thumbnailUrl: String?) -> Builder {
            self.thumbnailUrl = thumbnailUrl
            return self
        }

        public func thumbnailAWSFolderPath(_ thumbnailAWSFolderPath: String?)
            -> Builder
        {
            self.thumbnailAWSFolderPath = thumbnailAWSFolderPath
            return self
        }

        public func thumbnailLocalFilePath(_ thumbnailLocalFilePath: String?)
            -> Builder
        {
            self.thumbnailLocalFilePath = thumbnailLocalFilePath
            return self
        }

        public func meta(_ meta: AttachmentMeta?) -> Builder {
            self.meta = meta
            return self
        }

        public func createdAt(_ createdAt: Int?) -> Builder {
            self.createdAt = createdAt
            return self
        }

        public func updatedAt(_ updatedAt: Int?) -> Builder {
            self.updatedAt = updatedAt
            return self
        }

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
