//
//  UserDefaultsBacked.swift
//  LikeMindsChatData
//
//  Created by Anurag Tyagi on 03/07/24.
//

import Foundation

import Foundation

@propertyWrapper
struct UserDefaultsBacked<Value: Codable> {
    let key: String
    let userDefaults: UserDefaults

    init(key: String, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.userDefaults = userDefaults
    }

    var wrappedValue: Value? {
        get {
            guard let data = userDefaults.data(forKey: key) else {
                return nil
            }
            let decoder = JSONDecoder()
            return try? decoder.decode(Value.self, from: data)
        }
        set {
            let encoder = JSONEncoder()
            if let value = newValue,
                let data = try? encoder.encode(value) {
                userDefaults.set(data, forKey: key)
            } else {
                userDefaults.removeObject(forKey: key)
            }
            
            userDefaults.synchronize()
        }
    }
}
