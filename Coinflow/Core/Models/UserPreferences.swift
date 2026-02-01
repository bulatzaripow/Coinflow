//
//  UserPreferences.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 11.01.2026.
//

import Foundation
import SwiftUI

@Observable
class UserPreferences {
    
    // MARK: - Props
    
    private(set) var defaultCurrencyCode: String {
        didSet {
            UserDefaults.standard.set(defaultCurrencyCode, forKey: "defaultCurrencyCode")
        }
    }
    
    private(set) var hasSeenOnboarding: Bool = false {
        didSet {
            UserDefaults.standard.set(hasSeenOnboarding, forKey: "hasSeenOnboarding")
        }
    }
    
    // MARK: - Init
    
    init() {
        self.defaultCurrencyCode = UserDefaults.standard.string(forKey: "defaultCurrencyCode") ?? "USD"
        self.hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
    }
    
    // MARK: - Methods
    
    func setDefaultCurrencyCode(_ code: String) {
        guard self.defaultCurrencyCode != code else { return }
        self.defaultCurrencyCode = code
    }
    
    func setHasSeenOnboarding(_ hasSeen: Bool) {
        self.hasSeenOnboarding = hasSeen
    }
}
