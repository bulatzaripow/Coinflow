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
                iconName: categoryData.iconName,
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
    
    private func getDefaultCategories() -> [(name: String, iconName: String)] {
        
        return [
            ("Other", "questionmark.circle"),
            ("Groceries", "cart"),
            ("Restaurant", "fork.knife"),
            ("Coffee", "cup.and.saucer"),
            ("Delivery", "car"),
            ("Taxi", "car.fill"),
            ("Public Transport", "bus.fill"),
            ("Fuel", "drop.fill"),
            ("Parking", "p.square"),
            ("Clothing", "tshirt"),
            ("Electronics", "iphone"),
            ("Gifts", "gift"),
            ("Rent", "house"),
            ("Utilities", "bolt"),
            ("Pharmacy", "pills"),
            ("Doctor", "stethoscope"),
            ("Cinema", "film"),
            ("Subscriptions", "bolt.circle"),
            ("Hobbies", "puzzlepiece"),
            ("Courses", "graduationcap"),
            ("Books", "book"),
            ("Pet Care", "dog"),
        ]
    }
}
