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
                name: categoryData.name,
                type: categoryData.type,
                icon: categoryData.icon,
                color: categoryData.color,
                sortOrder: sortOrder,
                isDefault: true,
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
    
    private func getDefaultCategories() -> [(name: String, icon: String, type: CategoryType, color: String)] {
        
        return [
            // Expenses
            ("Other", "interrogation", CategoryType.expense, "#757575"),
            ("Groceries", "grocery-bag", CategoryType.expense, "#4CAF50"),
            ("Restaurant", "utensils", CategoryType.expense, "#FF9800"),
            ("Shopping", "shopping-cart", CategoryType.expense, "#2196F3"),
            ("Coffee", "mug-hot-alt", CategoryType.expense, "#795548"),
            ("Delivery", "car-alt", CategoryType.expense, "#FF7043"),
            ("Taxi", "taxi", CategoryType.expense, "#FF5722"),
            ("Public Transport", "bus-alt", CategoryType.expense, "#42A5F5"),
            ("Fuel", "gas-pump-alt", CategoryType.expense, "#FFB300"),
            ("Parking", "parking-circle", CategoryType.expense, "#5C6BC0"),
            ("Clothing", "tshirt", CategoryType.expense, "#EC407A"),
            ("Electronics", "mobile-notch", CategoryType.expense, "#00ACC1"),
            ("Gifts", "gift", CategoryType.expense, "#AB47BC"),
            ("Rent", "city", CategoryType.expense, "#7E57C2"),
            ("Utilities", "bolt", CategoryType.expense, "#FFEE58"),
            ("Pharmacy", "pills", CategoryType.expense, "#66BB6A"),
            ("Doctor", "stethoscope", CategoryType.expense, "#EF5350"),
            ("Cinema", "clapper-open", CategoryType.expense, "#BA68C8"),
            ("Subscriptions", "subscription", CategoryType.expense, "#26A69A"),
            ("Hobbies", "puzzle", CategoryType.expense, "#FFA726"),
            ("Courses", "lesson", CategoryType.expense, "#5C6BC0"),
            ("Books", "books", CategoryType.expense, "#8D6E63"),
            ("Pet Care", "dog", CategoryType.expense, "#FF8A65"),

            // Income
            ("Salary", "wallet-income", CategoryType.income, "#2E7D32"),
            ("Bonus", "bonus-alt", CategoryType.income, "#FF8F00"),
            ("Business", "briefcase", CategoryType.income, "#546E7A"),
            ("Investment Income", "growth-chart-invest", CategoryType.income, "#00897B"),
            ("Gift Received", "hand-present", CategoryType.income, "#D81B60"),
            ("Cashback / Refund", "refund-alt", CategoryType.income, "#7CB342"),
            ("Dividends", "investment", CategoryType.income, "#00695C"),
            ("Rental Income", "rent", CategoryType.income, "#5E35B1"),
            ("Government Support", "government-budget", CategoryType.income, "#455A64"),
        ]
    }
}
