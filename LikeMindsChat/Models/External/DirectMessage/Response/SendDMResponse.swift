//
//  SendDMResponse.swift
//  CollabMates
//
//  Created by Pushpendra Singh on 10/10/23.
//  Copyright © 2023 CollabMates. All rights reserved.
//

import Foundation

public class SendDMResponse: Decodable {
    public let conversation: Conversation?
    public var widgets: [String : Widget]?
    
    enum CodingKeys: String, CodingKey {
        case conversation, widgets
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        conversation = try container.decodeIfPresent(Conversation.self, forKey: .conversation)
        widgets = try container.decodeIfPresent([String: Widget].self, forKey: .widgets)
    }
}
