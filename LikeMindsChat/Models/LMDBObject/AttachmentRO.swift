//
//  AttachmentRO.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 01/01/24.
//

import Foundation
import RealmSwift

class AttachmentRO: EmbeddedObject {
    @Persisted var id: String = ""
    @Persisted var name: String?
    @Persisted var type: String?
    @Persisted var index: Int?
    @Persisted var width: Int?
    @Persisted var height: Int?
    @Persisted var awsFolderPath: String?
    @Persisted var localFilePath: String?
    @Persisted var url: String?
    @Persisted var thumbnailUrl: String?
    @Persisted var thumbnailAWSFolderPath: String?
    @Persisted var thumbnailLocalFilePath: String?
    @Persisted var metaRO: AttachmentMetaRO?
    @Persisted var createdAt: Int?
    @Persisted var updatedAt: Int?
    @Persisted var isUploaded: Bool = false
}
