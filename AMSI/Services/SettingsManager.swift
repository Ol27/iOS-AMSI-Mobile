//
//  SettingsManager.swift
//  AMSI
//
//  Created by Anton Petrov on 13.10.2023.
//

import Foundation

final class SettingsManager {
    static let shared = SettingsManager()
    private let defaults = UserDefaults.standard

    private init() {}

    private func set(_ value: Bool, for key: String) {
        defaults.set(value, forKey: key)
    }

    private func getBool(for key: String) -> Bool {
        return defaults.bool(forKey: key)
    }

    var didShowOnboarding: Bool {
        get { getBool(for: #function) }
        set { set(newValue, for: #function) }
    }

    var didFilledData: Bool {
        get { getBool(for: #function) }
        set { set(newValue, for: #function) }
    }
}
