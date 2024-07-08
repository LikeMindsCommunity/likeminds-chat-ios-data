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
public class BuildManager {
     public static let environment: BuildEnvironment = .devtest
//    static let environment: BuildEnvironment = .production
    static let buildVersion = "500"
}
