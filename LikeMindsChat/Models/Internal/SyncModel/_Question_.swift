//
//  _Question_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 09/01/24.
//

import Foundation

struct _Question_: Decodable {
    
    let id: Int?
    let questionTitle: String?
    let state: Int?
    let value: String?
    let optional: Bool
    let helpText: String?
    let field: Bool?
    let isCompulsory: Bool?
    let isHidden: Bool?
    let communityId: String?
    let memberId: String?
    let directoryFields: Bool?
    let imageUrl: String?
    let canAddOtherOptions: Bool?
    let questionChangeState: Int?
    let isAnswerEditable: Bool
    
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        questionTitle = try container.decode(String.self, forKey: .questionTitle)
        state = try container.decode(Int.self, forKey: .state)
        value = try container.decodeIfPresent(String.self, forKey: .value)
        optional = try container.decode(Bool.self, forKey: .optional)
        helpText = try container.decodeIfPresent(String.self, forKey: .helpText)
        field = try container.decodeIfPresent(Bool.self, forKey: .field)
        isCompulsory = try container.decodeIfPresent(Bool.self, forKey: .isCompulsory)
        isHidden = try container.decodeIfPresent(Bool.self, forKey: .isHidden)
        communityId = try container.decodeIfPresent(String.self, forKey: .communityId)
        memberId = try container.decodeIfPresent(String.self, forKey: .memberId)
        directoryFields = try container.decodeIfPresent(Bool.self, forKey: .directoryFields)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        canAddOtherOptions = try container.decodeIfPresent(Bool.self, forKey: .canAddOtherOptions)
        questionChangeState = try container.decodeIfPresent(Int.self, forKey: .questionChangeState)
        isAnswerEditable = try container.decode(Bool.self, forKey: .isAnswerEditable)
    }
}
