//
//  AppStorageManager.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 28/06/24.
//

import SwiftUI

struct AppStorageManager {
    static func value<T>(forKey key: String, defaultValue: T) -> T where T: Equatable {
        if let storedValue = UserDefaults.standard.object(forKey: key) as? T {
            return storedValue
        }
        return defaultValue
    }

    static func setValue<T>(_ value: T, forKey key: String) where T: Equatable {
        UserDefaults.standard.set(value, forKey: key)
    }
}

