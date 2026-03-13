//
//  CategoryInitializerService.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 20.12.2025.
//

import Foundation
import SwiftData

final class CategoryInitializerService: CategoryInitializerProtocol {

    // MARK: - Props

    let context: ModelContext

    // MARK: - Init

    init(context: ModelContext) {
        self.context = context
    }

    // MARK: - Methods

    func setupDefaultCategoriesIfNeeded() {
        guard !checkIfCategoriesExists() else {
            print("Categories already exists in database")
            return
        }

        let defaultCategories = getDefaultCategories()
        var sortOrder = 0
        for categoryData in defaultCategories {
            let category = Category(
                name: categoryData.name.localized,
                type: categoryData.type,
                icon: categoryData.icon,
                color: categoryData.color,
                sortOrder: sortOrder,
                isDefault: true,
                localizationName: categoryData.name,
                createdAt: Date()
            )
            sortOrder += 1
            context.insert(category)
        }
    }

    private func checkIfCategoriesExists() -> Bool {
        let descriptor = FetchDescriptor<Category>()

        do {
            let count = try context.fetchCount(descriptor)
            return count > 0
        } catch {
            print("Error checking categories: \(error)")
            return false
        }
    }
}
