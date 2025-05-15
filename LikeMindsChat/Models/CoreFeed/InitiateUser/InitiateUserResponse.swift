//
//  InitiateUserResponse.swift
//  LMCore
//
//  Created by Pushpendra Singh on 15/02/23.
//

import Foundation

public struct InitiateUserResponse: Decodable {
  public let accessToken: String
  public let appAccess: Bool?
  public let community: Community?
  public let hasAnswers: Bool?
  public let refreshToken: String?
  public let user: User?

  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case appAccess = "app_access"
    case community
    case hasAnswers = "has_answers"
    case refreshToken = "refresh_token"
    case user
  }
}

public struct InitialUser: Decodable {
  public let user: User  //user data
  public let community: Community  //community data
}

/// Holds additional client-related data, such as unique IDs that link a user to a
/// particular community.
///
/// This struct is Codable, so it can be easily serialized to/from JSON.
public struct SDKClientInfo: Codable {
  public let community: Int?
  public let user: Int?
  public let userUniqueID: String?
  public let uuid: String?

  enum CodingKeys: String, CodingKey {
    case community, user
    case userUniqueID = "user_unique_id"
    case uuid
  }

  public init(from decoder: Decoder) throws {
    let container: KeyedDecodingContainer<CodingKeys>

    do {
      container = try decoder.container(keyedBy: CodingKeys.self)
    } catch {
      print("Error creating container: \(error)")
      throw error
    }

    do {
      self.community = try container.decodeIfPresent(Int.self, forKey: .community)
    } catch {
      print("Error decoding community: \(error)")
      self.community = nil
    }

    do {
      // First try to decode as String
      if let stringUser = try? container.decode(String.self, forKey: .user) {
        self.user = Int(stringUser)
      } else {
        // If String decode fails, try Int
        self.user = try container.decodeIfPresent(Int.self, forKey: .user)
      }
    } catch {
      print("Error decoding user: \(error)")
      self.user = nil
    }

    do {
      self.userUniqueID = try container.decodeIfPresent(String.self, forKey: .userUniqueID)
    } catch {
      print("Error decoding userUniqueID: \(error)")
      self.userUniqueID = nil
    }

    do {
      self.uuid = try container.decodeIfPresent(String.self, forKey: .uuid)
    } catch {
      print("Error decoding uuid: \(error)")
      self.uuid = nil
    }
  }

  public init(community: Int?, user: Int?, userUniqueID: String?, uuid: String?) {
    self.community = community
    self.user = user
    self.userUniqueID = userUniqueID
    self.uuid = uuid
  }
}
