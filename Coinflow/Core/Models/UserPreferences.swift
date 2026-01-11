//
//  UserPreferences.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 11.01.2026.
//

import Foundation

@Observable
class UserPreferences {
    
    // MARK: - Props
    
    var defaultCurrencyCode: String {
        didSet {
            UserDefaults.standard.set(defaultCurrencyCode, forKey: "defaultCurrencyCode")
        }
    }
    
    // MARK: - Init
    
    init() {
        self.defaultCurrencyCode = UserDefaults.standard.string(forKey: "defaultCurrencyCode") ?? "USD"
    }
    
    // MARK: - Methods
    
    func setDefaultCurrencyCode(_ code: String) {
        guard self.defaultCurrencyCode != code else { return }
        self.defaultCurrencyCode = code
    }
}
