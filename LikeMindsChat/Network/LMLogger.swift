//
//  LMLogger.swift
//  LMChat
//
//  Created by Pushpendra Singh on 26/02/23.
//

import Foundation
import os

/// A logging utility class for the LikeMinds Chat SDK that provides different levels of logging functionality.
/// This class uses Apple's unified logging system (`os_log`) for efficient and organized logging.
///
/// Usage Example:
/// ```swift
/// LMLogger.info("User logged in successfully")
/// LMLogger.error("Failed to send message")
/// LMLogger.debug("Message payload: \(payload)")
/// ```
///
/// - Note: All logging methods are static and can be called directly on the class
/// - Important: Logs are automatically categorized by severity level for better debugging
public class LMLogger {
    
    /// Private initializer to prevent instantiation
    /// This ensures the class can only be used through its static methods
    private init() {}
    
    /// Logs an informational message to the console
    /// Use this for general information that could be helpful for tracking app flow
    ///
    /// - Parameter message: The message to be logged
    /// - Note: Uses `.info` log level in os_log
    /// - Important: Messages are prefixed with "Info - " for easy identification
    static func info(_ message: CVarArg) {
        os_log(.info, "Info - ", message)
    }
    
    /// Logs a debug message to the console
    /// Use this for detailed information that is useful during development and debugging
    ///
    /// - Parameter message: The message to be logged
    /// - Note: Uses `.debug` log level in os_log
    /// - Important: Messages are prefixed with "Debug - " for easy identification
    static func debug(_ message: CVarArg) {
        os_log(.debug, "Debug - ", message)
    }
    
    /// Logs an error message to the console
    /// Use this for errors and exceptional conditions that require attention
    ///
    /// - Parameter message: The error message to be logged
    /// - Note: Uses `.error` log level in os_log
    /// - Important: Messages are prefixed with "Error - " for easy identification
    /// - Warning: These logs should be monitored as they indicate potential issues
    static func error(_ message: CVarArg) {
        os_log(.error, "Error - ", message)
    }
}
