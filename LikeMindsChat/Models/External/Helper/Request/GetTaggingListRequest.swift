//
//  GetTaggingListRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 17/01/24.
//

import Foundation

public class GetTaggingListRequest: Encodable {
    let chatroomId: String
    let page: Int
    let pageSize: Int
    let searchName: String?
    
    private init(chatroomId: String, page: Int, pageSize: Int, searchName: String?) {
        self.chatroomId = chatroomId
        self.page = page
        self.pageSize = pageSize
        self.searchName = searchName
    }
    
    public class Builder {
        private var chatroomId: String = ""
        private var page: Int = 1
        private var pageSize: Int = 10
        private var searchName: String? = nil
        
        public func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        public func page(_ page: Int) -> Builder {
            self.page = page
            return self
        }
        
        public func pageSize(_ pageSize: Int) -> Builder {
            self.pageSize = pageSize
            return self
        }
        
        public func searchName(_ searchName: String?) -> Builder {
            self.searchName = searchName
            return self
        }
        
        public func build() -> GetTaggingListRequest {
            return GetTaggingListRequest(
                chatroomId: chatroomId,
                page: page,
                pageSize: pageSize,
                searchName: searchName
            )
        }
    }
    
    public func toBuilder() -> Builder {
        return Builder()
            .chatroomId(chatroomId)
            .page(page)
            .pageSize(pageSize)
            .searchName(searchName)
    }
}
