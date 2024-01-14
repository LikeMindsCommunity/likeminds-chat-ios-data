//
//  PutMultimediaRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class PutMultimediaRequest {
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
    
    class Builder {
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
        
        func conversationId(_ conversationId: String) -> Builder {
            self.conversationId = conversationId
            return self
        }
        
        func name(_ name: String) -> Builder {
            self.name = name
            return self
        }
        
        func url(_ url: String) -> Builder {
            self.url = url
            return self
        }
        
        func thumbnailUrl(_ thumbnailUrl: String?) -> Builder {
            self.thumbnailUrl = thumbnailUrl
            return self
        }
        
        func type(_ type: String) -> Builder {
            self.type = type
            return self
        }
        
        func filesCount(_ filesCount: Int?) -> Builder {
            self.filesCount = filesCount
            return self
        }
        
        func index(_ index: Int?) -> Builder {
            self.index = index
            return self
        }
        
        func width(_ width: Int?) -> Builder {
            self.width = width
            return self
        }
        
        func height(_ height: Int?) -> Builder {
            self.height = height
            return self
        }
        
        func meta(_ meta: AttachmentMeta?) -> Builder {
            self.meta = meta
            return self
        }
        
        func build() -> PutMultimediaRequest {
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
    
    func toBuilder() -> Builder {
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
