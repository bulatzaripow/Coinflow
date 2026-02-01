//
//  CategoryManageService.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 06.01.2026.
//

import SwiftData
import Foundation

final class CategoryManageService: BaseManageService<Category>, CategoryManageServiceProtocol {
    
    override func fetchAll() -> [Category] {
        let descriptor = FetchDescriptor<Category>(
            sortBy: [
                SortDescriptor(\.sortOrder, order: .forward)
            ]
        )
        let items = try? context.fetch(descriptor)
        return items ?? []
    }
    
    func fetchAllInOrder(_ order: SortOrder) -> [Category] {
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
    
}
