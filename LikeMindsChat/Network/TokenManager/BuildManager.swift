//
//  AppManager.swift
//  LMCore
//
//  Created by Pushpendra Singh on 15/02/23.
//

import Foundation

public enum BuildEnvironment {
    case production
    case devtest
}

/// Manages build-specific configurations and environment settings for the SDK.
/// This class provides static access to build information and environment configuration.
///
/// Usage Example:
/// ```swift
/// if BuildManager.environment == .devtest {
///     // Enable additional logging
///     // Use development API endpoints
/// }
/// ```
///
/// - Note: All properties are static and can be accessed directly on the class
/// - Important: Ensure correct environment is set before deployment
public class BuildManager {
    /// The current environment in which the SDK is running
    /// - Note: Defaults to `.devtest` for development safety
    /// - Important: Should be set to `.production` for release builds
        
    // static let environment: BuildEnvironment = .devtest
   static let environment: BuildEnvironment = .production
    
    /// The current version number of the build
    /// - Note: This should be updated with each release
    static let buildVersion = "513"
}
