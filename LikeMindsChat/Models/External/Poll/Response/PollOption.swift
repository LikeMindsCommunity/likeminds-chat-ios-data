//
//  PollOption.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 24/07/24.
//

import Foundation

public struct PollOption: Decodable {
    public let id: String?
    public let text: String?
    public let isSelected: Bool
    public let percentage: Double
    public let uuid: String?
    public let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case text
        case isSelected = "is_selected"
        case percentage
        case uuid
        case voteCount = "vote_count"
    }
    
    public func toDictionary() -> [String: Any] {
           var dict: [String: Any] = [:]
           
           dict["_id"] = id
           dict["text"] = text
           dict["is_selected"] = isSelected
           dict["percentage"] = percentage
           dict["uuid"] = uuid
           dict["vote_count"] = voteCount
           
           return dict
       }
}

public extension PollOption {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            id = try container.decodeIfPresent(String.self, forKey: .id)
        } catch {
            id = nil
            print("Error decoding id: \(error)")
        }
        
        do {
            text = try container.decodeIfPresent(String.self, forKey: .text)
        } catch {
            text = nil
            print("Error decoding text: \(error)")
        }
        
        do {
            isSelected = try container.decodeIfPresent(Bool.self, forKey: .isSelected) ?? false
        } catch {
            isSelected = false
        }
        
        do {
            percentage = try container.decodeIfPresent(Double.self, forKey: .percentage) ?? .zero
        } catch {
            percentage = .zero
        }
        
        do {
            uuid = try container.decodeIfPresent(String.self, forKey: .uuid)
        } catch {
            uuid = nil
            print("Error decoding uuid: \(error)")
        }
        
        do {
            voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount) ?? .zero
        } catch {
            voteCount = .zero
        }
    }
}
