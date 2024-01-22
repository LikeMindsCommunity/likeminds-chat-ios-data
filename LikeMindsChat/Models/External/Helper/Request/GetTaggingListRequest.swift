//
//  GetTaggingListRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 17/01/24.
//

import Foundation

class GetTaggingListRequest: Encodable {
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
    
    class Builder {
        private var chatroomId: String = ""
        private var page: Int = 1
        private var pageSize: Int = 10
        private var searchName: String? = nil
        
        func chatroomId(_ chatroomId: String) -> Builder {
            self.chatroomId = chatroomId
            return self
        }
        
        func page(_ page: Int) -> Builder {
            self.page = page
            return self
        }
        
        func pageSize(_ pageSize: Int) -> Builder {
            self.pageSize = pageSize
            return self
        }
        
        func searchName(_ searchName: String?) -> Builder {
            self.searchName = searchName
            return self
        }
        
        func build() -> GetTaggingListRequest {
            return GetTaggingListRequest(
                chatroomId: chatroomId,
                page: page,
                pageSize: pageSize,
                searchName: searchName
            )
        }
    }
    
    func toBuilder() -> Builder {
        return Builder()
            .chatroomId(chatroomId)
            .page(page)
            .pageSize(pageSize)
            .searchName(searchName)
    }
}
