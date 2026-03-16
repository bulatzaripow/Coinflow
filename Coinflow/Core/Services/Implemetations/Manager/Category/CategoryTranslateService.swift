//
//  CategoryTranslateService.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 13.03.2026.
//

import SwiftData
import Foundation

final class CategoryTranslateService: CategoryTranslateServiceProtocol {

    // MARK: - Props

    let context: ModelContext

    // MARK: - Init

    init(context: ModelContext) {
        self.context = context
    }

    // MARK: - Methods

    func translateDefaultCategories() {
        let predicate = #Predicate<Category> {
            $0.isDefault == true && $0.isModified == false
        }
        let descriptor = FetchDescriptor<Category>(predicate: predicate)

        guard let categories = try? context.fetch(descriptor) else { return }

        for category in categories {
            if !category.localizationName.isEmpty {
                category.name = category.localizationName.localized
            } else if let key = findLocalizationKey(for: category) {
                category.localizationName = key
                category.name = key.localized
            }
        }

        try? context.save()
    }

    // MARK: - Private

    private func findLocalizationKey(for category: Category) -> String? {
        let defaultCategories = getDefaultCategories()
        let currentLocale = Locale.current.language.languageCode?.identifier
        let supportedLanguages = ["en", "ru", "tt"].filter { $0 != currentLocale }

        return defaultCategories.first { data in
            guard data.type == category.type else { return false }

            return supportedLanguages.contains { locale in
                guard let locale = locale else { return false }
                return data.name.localized(in: locale) == category.name
            }
        }?.name
    }

}
