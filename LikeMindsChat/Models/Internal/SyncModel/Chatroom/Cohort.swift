//
//  _Cohort_.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 09/01/24.
//

import Foundation

/// A model representing a cohort within the chat application.
///
/// The `Cohort` struct encapsulates information about a group of members (cohort), including its identifier,
/// the total number of members, the name of the cohort, and an array of its members. It conforms to the
/// `Decodable` protocol to support decoding from JSON data.
public struct Cohort: Decodable {

    /// The unique identifier of the cohort.
    public let id: Int?

    /// The total number of members in the cohort.
    public let totalMembers: Int?

    /// The name of the cohort.
    public let name: String?

    /// An array of `Member` objects representing the members of the cohort.
    public let members: [Member]?

    /**
     Coding keys used to map JSON keys to the corresponding properties.

     - Note: The JSON keys differ from the property names for `id` and `totalMembers`, so custom mappings
       are provided.
     */
    private enum CodingKeys: String, CodingKey {
        case id = "cohort_id"
        case totalMembers = "total_members"
        case name
        case members
    }

    /**
     Initializes a new `Cohort` instance with the provided values.

     - Parameters:
        - id: The unique identifier for the cohort.
        - totalMembers: The total number of members in the cohort.
        - name: The name of the cohort.
        - members: An array of `Member` objects representing the cohort members.
     */
    public init(id: Int?, totalMembers: Int?, name: String?, members: [Member]?)
    {
        self.id = id
        self.totalMembers = totalMembers
        self.name = name
        self.members = members
    }
}

extension Cohort {
    /**
     Creates a new `Cohort` instance by decoding from the given decoder.

     This initializer uses the custom `CodingKeys` to map JSON keys to the properties of `Cohort`.

     - Parameter decoder: The decoder to read data from.
     - Throws: An error if any required keys are missing or if the data is corrupted.
     */
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(Int.self, forKey: .id)
        totalMembers = try container.decodeIfPresent(
            Int.self, forKey: .totalMembers)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        members = try container.decodeIfPresent([Member].self, forKey: .members)
    }
}
