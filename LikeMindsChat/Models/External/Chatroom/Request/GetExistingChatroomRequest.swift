//
//  GetExistingChatroomRequest.swift
//  Pods
//
//  Created by Anurag Tyagi on 10/04/25.
//

import Foundation

public class GetExistingDMChatroomRequest: Encodable {
    let userUUID: String

    private init(userUUID: String) {
        self.userUUID = userUUID
    }

    public static func builder() -> Builder {
        return Builder()
    }

    public class Builder {
        private var userUUID: String = ""

        public func userUUID(_ userUUID: String) -> Builder {
            self.userUUID = userUUID
            return self
        }

        public func build() -> GetExistingDMChatroomRequest {
            return GetExistingDMChatroomRequest(userUUID: userUUID)
        }
    }

    public func toBuilder() -> Builder {
        return Builder().userUUID(userUUID)
    }

    enum CodingKeys: String, CodingKey {
        case userUUID = "user_uuid"
    }
}
