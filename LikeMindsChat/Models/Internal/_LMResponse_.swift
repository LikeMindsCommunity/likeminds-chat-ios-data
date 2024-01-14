//
//  _LMResponse_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/01/24.
//

import Foundation

public typealias _LMClientResponse_<T:Decodable> = (_LMResponse_<T>) -> (Void)

public struct _LMResponse_<T: Decodable>: Decodable {
    public let success: Bool
    public let errorMessage: String?
    public let data: T?
    
    enum CodingKeys: String, CodingKey {
        case success, data
        case errorMessage = "error_message"
    }
    private init(_ success: Bool, errorMessage: String) {
        self.success = success
        self.errorMessage = errorMessage
        self.data = nil
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent(T.self, forKey: .data)
    }
    
    static func failureResponse(_ errorMessage: String) -> _LMResponse_ {
        return _LMResponse_(false, errorMessage: errorMessage)
    }
}

public struct _NoData_: Decodable {}
