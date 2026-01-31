//
//  CategoryManageService.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 06.01.2026.
//

import SwiftData
import Foundation

final class CategoryManageService: CategoryManageServiceProtocol {
    
    // MARK: - Props
    
    private let context: ModelContext
    
    // MARK: - Init
    
    init(context: ModelContext) {
        self.context = context
    }
    
    // MARK: - Methods
    
    func fetchAll(_ order: SortOrder) -> [Category] {
        let descriptor = FetchDescriptor<Category>(
            sortBy: [
                SortDescriptor(\Category.sortOrder, order: order)
            ]
        )
        let items = try? context.fetch(descriptor)
        return items ?? []
    }
    
    func fetchAllByType(type: CategoryType) -> [Category] {
        let predicate = #Predicate<Category> { category in
            category.typeRaw == type.rawValue
        }
        
        let descriptor = FetchDescriptor<Category>(
            predicate: predicate,
            sortBy: [
                SortDescriptor(\Category.sortOrder, order: .forward)
            ]
        )
        let items = try? context.fetch(descriptor)
        return items ?? []
    }
    
    func save(_ category: Category) {
        context.insert(category)
        
        do {
            try context.save()
        } catch {
            print("Save category error:", error)
        }
    }
    
    func delete(_ category: Category) {
        context.delete(category)
        
        do {
            try context.save()
        } catch {
            print("Delete category error:", error)
        }
    }
}
