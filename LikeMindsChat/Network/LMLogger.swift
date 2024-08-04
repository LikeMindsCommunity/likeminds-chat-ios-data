//
//  LMLogger.swift
//  LMChat
//
//  Created by Pushpendra Singh on 26/02/23.
//

import Foundation
import os

public class LMLogger {
//    private static let logger = Logger(
//        subsystem: Bundle(for: LMLogger.self).bundleIdentifier!,
//        category: String(describing: LMLogger.self)
//    )
    private init(){}
    static func info(_ message: CVarArg) {
        os_log(.info, "Info - ", message)
    }
    
    static func debug(_ message: CVarArg) {
        os_log(.debug, "Debug - ", message)
    }
    
    static func error(_ message: CVarArg) {
        os_log(.error, "Error - ", message)
    }
    
}
