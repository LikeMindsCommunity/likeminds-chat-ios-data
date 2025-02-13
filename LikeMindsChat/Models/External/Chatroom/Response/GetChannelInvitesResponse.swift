//
//  GetChannelInviteResponse.swift
//  LikeMindsChat
//
//  Created by Anurag Tyagi on 17/01/25.
//


//
//  GetChannelInviteResponse.swift
//  LikeMindsChat
//
//  Created by Your Name on 18/01/24.
//

import Foundation

/// A response object containing a list of channel invites in the LikeMinds Chat SDK.
public struct GetChannelInvitesResponse: Decodable {

    // MARK: - Properties

    /// An array of `ChannelInvite` objects representing individual invites.
    public let channelInvites: [ChannelInvite]

    // MARK: - Coding Keys

    /// Maps the properties to their respective keys in the JSON response body.
    private enum CodingKeys: String, CodingKey {
        case channelInvites = "user_invites"
    }
}

/// A model representing an individual channel invite in the LikeMinds Chat SDK.
public struct ChannelInvite: Decodable {

    // MARK: - Properties

    /// The chatroom associated with this invite.
    public let chatroom: Chatroom

    /// The timestamp when the invite was created.
    public let createdAt: Int64

    /// The unique identifier of the invite.
    public let id: Int

    /// The status of the invite.
    public let inviteStatus: Int

    /// The timestamp when the invite was last updated.
    public let updatedAt: Int64

    /// The member who sent the invite.
    public let inviteSender: Member

    /// The member who received the invite.
    public let inviteReceiver: Member

    // MARK: - Coding Keys

    /// Maps the properties to their respective keys in the JSON response body.
    private enum CodingKeys: String, CodingKey {
        case chatroom
        case createdAt = "created_at"
        case id
        case inviteStatus = "invite_status"
        case updatedAt = "updated_at"
        case inviteSender = "invite_sender"
        case inviteReceiver = "invite_receiver"
    }
}
