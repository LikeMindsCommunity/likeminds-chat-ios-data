//
//  RegisterDeviceRequest.swift
//  LMCore
//
//  Created by Pushpendra Singh on 20/02/23.
//

import Foundation

/// Represents a request to register a device with the LikeMinds platform.
/// This class provides a builder pattern for constructing the request object.
public class RegisterDeviceRequest: Encodable {

    // MARK: - Properties

    /// The unique identifier for the device to be registered.
    private(set) var deviceId: String?

    /// The token associated with the device, typically used for push notifications.
    private(set) var token: String?

    // MARK: - Initializer

    /// Private initializer to enforce the use of the builder pattern.
    ///
    /// - Parameter builder: The `Builder` instance containing the configuration for the request.
    private init(builder: Builder) {
        self.deviceId = builder.deviceId
        self.token = builder.token
    }

    // MARK: - Builder Pattern

    /// Creates a new builder for constructing a `RegisterDeviceRequest` object.
    ///
    /// - Returns: An instance of `Builder` to configure the request.
    public static func builder() -> Builder {
        return Builder()
    }

    /// A nested builder class for constructing `RegisterDeviceRequest` objects.
    public class Builder {

        // MARK: - Builder Properties

        /// The unique identifier for the device.
        var deviceId: String?

        /// The token associated with the device.
        var token: String?

        // MARK: - Builder Methods

        /// Sets the device ID.
        ///
        /// - Parameter deviceId: The unique identifier for the device.
        /// - Returns: The current builder instance.
        public func deviceId(_ deviceId: String?) -> Builder {
            self.deviceId = deviceId
            return self
        }

        /// Sets the device token.
        ///
        /// - Parameter token: The token associated with the device.
        /// - Returns: The current builder instance.
        public func token(_ token: String?) -> Builder {
            self.token = token
            return self
        }

        /// Builds and returns a `RegisterDeviceRequest` object.
        ///
        /// - Returns: A fully configured `RegisterDeviceRequest` instance.
        public func build() -> RegisterDeviceRequest {
            return RegisterDeviceRequest(builder: self)
        }
    }

    // MARK: - Builder Conversion

    /// Converts the current `RegisterDeviceRequest` instance into a builder for modification.
    ///
    /// - Returns: A `Builder` initialized with the current request's values.
    public func toBuilder() -> Builder {
        var builder = Builder()
        if let deviceId = self.deviceId {
            builder = builder.deviceId(deviceId)
        }
        if let token = self.token {
            builder = builder.token(token)
        }
        return builder
    }

    // MARK: - Coding Keys

    /// Maps the properties to their respective keys in the JSON request body.
    enum CodingKeys: String, CodingKey {
        case token
        case deviceId = "device_id"
    }
}
