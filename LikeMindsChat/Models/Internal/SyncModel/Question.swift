//
//  _Question_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 09/01/24.
//

import Foundation

public struct Question: Decodable {
    
    public let id: Int?
    public let questionTitle: String?
    public let state: Int?
    public let value: String?
    public let optional: Bool?
    public let helpText: String?
    public let field: Bool?
    public let isCompulsory: Bool?
    public let isHidden: Bool?
    public let communityId: String?
    public let memberId: String?
    public let directoryFields: Bool?
    public let imageUrl: String?
    public let canAddOtherOptions: Bool?
    public let questionChangeState: Int?
    public let isAnswerEditable: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case questionTitle = "question_title"
        case state
        case value
        case optional
        case helpText = "help_text"
        case field
        case isCompulsory = "is_compulsory"
        case isHidden = "is_hidden"
        case communityId = "community_id"
        case memberId = "member_id"
        case directoryFields = "directory_fields"
        case imageUrl = "image_url"
        case canAddOtherOptions = "can_add_options"
        case questionChangeState = "question_change_state"
        case isAnswerEditable = "is_answer_editable"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        questionTitle = try container.decode(String.self, forKey: .questionTitle)
        state = try container.decodeIfPresent(Int.self, forKey: .state)
        value = try container.decodeIfPresent(String.self, forKey: .value)
        optional = try container.decodeIfPresent(Bool.self, forKey: .optional)
        helpText = try container.decodeIfPresent(String.self, forKey: .helpText)
        field = try container.decodeIfPresent(Bool.self, forKey: .field)
        isCompulsory = try container.decodeIfPresent(Bool.self, forKey: .isCompulsory)
        isHidden = try container.decodeIfPresent(Bool.self, forKey: .isHidden)
        communityId = try container.decodeIntToStringIfPresent(forKey: .communityId)
        memberId = try container.decodeIntToStringIfPresent(forKey: .memberId)
        directoryFields = try container.decodeIfPresent(Bool.self, forKey: .directoryFields)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        canAddOtherOptions = try container.decodeIfPresent(Bool.self, forKey: .canAddOtherOptions)
        questionChangeState = try container.decodeIfPresent(Int.self, forKey: .questionChangeState)
        isAnswerEditable = try container.decodeIfPresent(Bool.self, forKey: .isAnswerEditable)
    }
}
