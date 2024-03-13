//
//  AppManager.swift
//  LMCore
//
//  Created by Pushpendra Singh on 15/02/23.
//

import Foundation

enum BuildEnvironment {
    case production
    case devtest
}
class BuildManager {
    static let environment: BuildEnvironment = .devtest
//    static let environment: BuildEnvironment = .production
    static let buildVersion = "1000"
}
