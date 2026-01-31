//
//  SettingsViewModel.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 09.01.2026.
//

import SwiftUI
import Combine
import SwiftData

class SettingsViewModel: ObservableObject {
    
    // MARK: - Props
    
    @Published var showPrivacyPolicy = false
    @Published var showTermsOfService = false
    var onNavigate: ((MainRoutes) -> Void)?
    
    let privacyPolicyURL = URL(string: "https://google.com")
    let termsURL = URL(string: "https://google.com")
    
    var currentLanguage: String {
        let locale = Locale.current
        guard let languageCode = locale.language.languageCode?.identifier else {
            return "Unknown"
        }
        
        let languageName = locale.localizedString(forLanguageCode: languageCode) ?? languageCode
        
        return languageName.prefix(1).uppercased() + languageName.dropFirst()
    }
    
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    
    // MARK: - Init
    
    init(onNavigate: ((MainRoutes) -> Void)? = nil) {
        self.onNavigate = onNavigate
    }
    
    // MARK: - Methods
    
    func goToCategories() {
        self.onNavigate?(.categories)
    }
    
    func goToCurrencies() {
        self.onNavigate?(.currencies)
    }
}
