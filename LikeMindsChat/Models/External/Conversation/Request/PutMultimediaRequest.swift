//
//  PutMultimediaRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

public class PutMultimediaRequest: Encodable {
    let conversationId: String
    let name: String
    let url: String
    let thumbnailUrl: String?
    let type: String
    let filesCount: Int?
    let index: Int?
    let width: Int?
    let height: Int?
    let meta: AttachmentMeta?
    
    private init(conversationId: String, name: String, url: String, thumbnailUrl: String?, type: String, filesCount: Int?, index: Int?, width: Int?, height: Int?, meta: AttachmentMeta?) {
        self.conversationId = conversationId
        self.name = name
        self.url = url
        self.thumbnailUrl = thumbnailUrl
        self.type = type
        self.filesCount = filesCount
        self.index = index
        self.width = width
        self.height = height
        self.meta = meta
    }
    
    public static func builder() -> Builder {
        Builder()
    }
    
    public class Builder {
        private var conversationId: String = ""
        private var name: String = ""
        private var url: String = ""
        private var thumbnailUrl: String? = nil
        private var type: String = ""
        private var filesCount: Int? = nil
        private var index: Int? = nil
        private var width: Int? = nil
        private var height: Int? = nil
        private var meta: AttachmentMeta? = nil
        
        public func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        public func name(_ name: String) -> Builder {
            self.name = name
            return self
        }
        
        public func url(_ url: String) -> Builder {
            self.url = url
            return self
        }
        
        public func thumbnailUrl(_ thumbnailUrl: String?) -> Builder {
            self.thumbnailUrl = thumbnailUrl
            return self
        }
        
        public func type(_ type: String) -> Builder {
            self.type = type
            return self
        }
        
        public func filesCount(_ filesCount: Int?) -> Builder {
            self.filesCount = filesCount
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
        
        public func meta(_ meta: AttachmentMeta?) -> Builder {
            self.meta = meta
            return self
        }
        
        public func build() -> PutMultimediaRequest {
            return PutMultimediaRequest(
                conversationId: conversationId,
                name: name,
                url: url,
                thumbnailUrl: thumbnailUrl,
                type: type,
                filesCount: filesCount,
                index: index,
                width: width,
                height: height,
                meta: meta
            )
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder()
            .conversationId(conversationId)
            .name(name)
            .url(url)
            .thumbnailUrl(thumbnailUrl)
            .type(type)
            .filesCount(filesCount)
            .index(index)
            .width(width)
            .height(height)
            .meta(meta)
    }
}
