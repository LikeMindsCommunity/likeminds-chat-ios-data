//
//  LogoutRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 28/06/23.
//

import Foundation

/// Represents a request to log out a user from the LikeMinds platform.
/// This class provides a builder pattern for constructing the request object.
public class LogoutRequest: Encodable {

    // MARK: - Properties

    /// The refresh token associated with the user's session.
    private(set) var refreshToken: String?

    /// The unique identifier for the device being logged out.
    private(set) var deviceId: String?

    // MARK: - Initializer

    /// Private initializer to enforce the use of the builder pattern.
    ///
    /// - Parameter builder: The `Builder` instance containing the configuration for the request.
    private init(builder: Builder) {
        self.refreshToken = builder.refreshToken
        self.deviceId = builder.deviceId
    }

    // MARK: - Builder Pattern

    /// Creates a new builder for constructing a `LogoutRequest` object.
    ///
    /// - Returns: An instance of `Builder` to configure the request.
    public static func builder() -> Builder {
        return Builder()
    }

    /// A nested builder class for constructing `LogoutRequest` objects.
    public class Builder {

        // MARK: - Builder Properties

        /// The refresh token associated with the user's session.
        var refreshToken: String?

        /// The unique identifier for the device being logged out.
        var deviceId: String?

        // MARK: - Builder Methods

        /// Sets the refresh token.
        ///
        /// - Parameter refreshToken: The refresh token to log out the user.
        /// - Returns: The current builder instance.
        public func refreshToken(_ refreshToken: String?) -> Builder {
            self.refreshToken = refreshToken
            return self
        }

        /// Sets the device ID.
        ///
        /// - Parameter deviceId: The unique identifier for the device.
        /// - Returns: The current builder instance.
        public func deviceId(_ deviceId: String?) -> Builder {
            self.deviceId = deviceId
            return self
        }

        /// Builds and returns a `LogoutRequest` object.
        ///
        /// - Returns: A fully configured `LogoutRequest` instance.
        public func build() -> LogoutRequest {
            return LogoutRequest(builder: self)
        }
    }

    // MARK: - Builder Conversion

    /// Converts the current `LogoutRequest` instance into a builder for modification.
    ///
    /// - Returns: A `Builder` initialized with the current request's values.
    public func toBuilder() -> Builder {
        var builder = Builder()
        if let refreshToken = self.refreshToken {
            builder = builder.refreshToken(refreshToken)
        }
        if let deviceId = self.deviceId {
            builder = builder.deviceId(deviceId)
        }
        return builder
    }

    // MARK: - Coding Keys

    /// Maps the properties to their respective keys in the JSON request body.
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
        case deviceId = "device_token"
    }
}
