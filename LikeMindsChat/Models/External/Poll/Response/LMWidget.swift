//
//  LMWidget.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 24/07/24.
//

import Foundation

public struct LMWidget: Decodable {
    public let id: String?
    public let parentEntityID: String?
    public let parentEntityType: String?
    public let metadata: [String: Any]?
    public let createdAt: Double?
    public let updatedAt: Double?
    public let lmMeta: LMMeta?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case createdAt = "created_at"
        case metadata
        case parentEntityID = "parent_entity_id"
        case parentEntityType = "parent_entity_type"
        case updatedAt = "updated_at"
        case lmMeta = "_lm_meta"
    }
}

public extension LMWidget {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            id = try container.decodeIfPresent(String.self, forKey: .id)
        } catch {
            print("Error decoding id: \(error)")
            id = nil
        }
        
        do {
            parentEntityID = try container.decodeIfPresent(String.self, forKey: .parentEntityID)
        } catch {
            print("Error decoding parentEntityID: \(error)")
            parentEntityID = nil
        }
        
        do {
            parentEntityType = try container.decodeIfPresent(String.self, forKey: .parentEntityType)
        } catch {
            print("Error decoding parentEntityType: \(error)")
            parentEntityType = nil
        }
        
        do {
            let decodedMetadata = try container.decodeIfPresent([String: AnyDecodable].self, forKey: .metadata)
            metadata = decodedMetadata?.mapValues { $0.value }
        } catch {
            print("Error decoding metadata: \(error)")
            metadata = nil
        }
        
        do {
            createdAt = try container.decodeIfPresent(Double.self, forKey: .createdAt)
        } catch {
            print("Error decoding createdAt: \(error)")
            createdAt = .zero
        }
        
        do {
            updatedAt = try container.decodeIfPresent(Double.self, forKey: .updatedAt)
        } catch {
            print("Error decoding updatedAt: \(error)")
            updatedAt = .zero
        }
        
        do {
            lmMeta = try container.decodeIfPresent(LMMeta.self, forKey: .lmMeta)
        } catch {
            print("Error decoding lmMeta: \(error)")
            lmMeta = nil
        }
    }
}

public struct AnyDecodable: Decodable {
    let value: Any
    
    public init(from decoder: Decoder) throws {
        if let intValue = try? decoder.singleValueContainer().decode(Int.self) {
            value = intValue
        } else if let doubleValue = try? decoder.singleValueContainer().decode(Double.self) {
            value = doubleValue
        } else if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
            value = stringValue
        } else if let boolValue = try? decoder.singleValueContainer().decode(Bool.self) {
            value = boolValue
        } else if let nestedDictionary = try? decoder.singleValueContainer().decode([String: AnyDecodable].self) {
            value = nestedDictionary.mapValues { $0.value }
        } else if let nestedArray = try? decoder.singleValueContainer().decode([AnyDecodable].self) {
            value = nestedArray.map { $0.value }
        } else {
            throw DecodingError.dataCorruptedError(in: try decoder.singleValueContainer(), debugDescription: "Unsupported type")
        }
    }
}
