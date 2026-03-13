//
//  TranslateDefaults.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 13.03.2026.
//

import Foundation
import SwiftData

// MARK: - Language change

func translateCategoriesIfLanguageChanged(context: ModelContext, userPreferences: UserPreferences) {
    let currentLocale = Locale.current.language.languageCode?.identifier ?? "en"

    guard currentLocale != userPreferences.currentLocale else { return }
    userPreferences.setCurrentLocale(currentLocale)

    let service = CategoryTranslateService(context: context)
    service.translateDefaultCategories()
}
