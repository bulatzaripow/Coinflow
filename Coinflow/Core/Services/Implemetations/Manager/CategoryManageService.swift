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
    
    func fetchCategories() -> [Category] {
        let descriptor = FetchDescriptor<Category>(
            sortBy: [
                SortDescriptor(\Category.sortOrder, order: .forward)
            ]
        )
        let accounts = try? context.fetch(descriptor)
        return accounts ?? []
    }
}
