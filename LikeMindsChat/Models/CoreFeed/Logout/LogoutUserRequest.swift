//
//  LogoutUserRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 28/06/23.
//

import Foundation

/// Represents a request to log out a user from the LikeMinds platform.
/// This class provides a builder pattern for constructing the request object.
public class LogoutUserRequest: Encodable {

    // MARK: - Properties

    /// The unique identifier for the device being logged out.
    private(set) var deviceId: String?
    
    ///  Refresh Token
    private(set) var refreshToken: String?

    // MARK: - Initializer

    /// Private initializer to enforce the use of the builder pattern.
    ///
    /// - Parameter builder: The `Builder` instance containing the configuration for the request.
    private init(builder: Builder) {
        self.deviceId = builder.deviceId
        self.refreshToken = builder.refreshToken
    }

    // MARK: - Builder Pattern

    /// Creates a new builder for constructing a `LogoutUserRequest` object.
    ///
    /// - Returns: An instance of `Builder` to configure the request.
    public static func builder() -> Builder {
        return Builder()
    }

    /// A nested builder class for constructing `LogoutUserRequest` objects.
    public class Builder {

        // MARK: - Builder Properties

        /// The unique identifier for the device being logged out.
        var deviceId: String?
        
        /// Refresh Token
        var refreshToken: String?

        // MARK: - Builder Methods

        /// Sets the device ID.
        ///
        /// - Parameter deviceId: The unique identifier for the device.
        /// - Returns: The current builder instance.
        public func deviceId(_ deviceId: String?) -> Builder {
            self.deviceId = deviceId
            return self
        }
        
        /// Sets the refresh token.
        ///
        /// - Parameter refreshToken: refresh token for the session
        /// - Returns: The current builder instance.
        public func refreshToken(_ refreshToken: String?) -> Builder {
            self.refreshToken = refreshToken
            return self
        }

        /// Builds and returns a `LogoutUserRequest` object.
        ///
        /// - Returns: A fully configured `LogoutUserRequest` instance.
        public func build() -> LogoutUserRequest {
            return LogoutUserRequest(builder: self)
        }
    }

    // MARK: - Builder Conversion

    /// Converts the current `LogoutUserRequest` instance into a builder for modification.
    ///
    /// - Returns: A `Builder` initialized with the current request's values.
    public func toBuilder() -> Builder {
        var builder = Builder()
        if let deviceId = self.deviceId {
            builder = builder.deviceId(deviceId)
        }
        if let refreshToken = self.refreshToken {
            builder = builder.refreshToken(refreshToken)
        }
        return builder
    }

    // MARK: - Coding Keys

    /// Maps the properties to their respective keys in the JSON request body.
    enum CodingKeys: String, CodingKey {
        case deviceId = "device_id"
        case refreshToken = "refresh_token"
    }
}
