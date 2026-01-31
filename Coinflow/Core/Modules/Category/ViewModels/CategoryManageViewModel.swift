//
//  CategoryManageViewModel.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 30.01.2026.
//

import Foundation
import SwiftData
import SwiftUI
import Combine

final class CategoryManageViewModel: ObservableObject {
    
    // MARK: - Props
    
    private let categoryService: CategoryManageServiceProtocol
    
    @Published var name: String = ""
    @Published var type: CategoryType = .expense
    @Published var selectedIcon: String?
    
    let gridColumns: [GridItem] = Array(
        repeating: .init(.flexible(), spacing: 12),
        count: 5
    )
    
    var canSave: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        selectedIcon != nil
    }
    
    // MARK: - Init
    
    init(categoryService: CategoryManageServiceProtocol) {
        self.categoryService = categoryService
    }
    
    // MARK: - Methods
    
    func saveCategory() {
        guard
            let icon = selectedIcon,
            canSave
        else { return }
        
        let category = Category(
            name: name,
            type: type,
            icon: icon,
            color: "#757575",
            sortOrder: getNextSortOrder(),
            isDefault: false,
            createdAt: Date()
        )
        
        categoryService.save(category)
    }
    
    private func getNextSortOrder() -> Int {
        let categories = categoryService.fetchAll(.reverse)
        return (categories.first?.sortOrder ?? 0) + 1
    }
}

// Icons

extension CategoryManageViewModel {
    
    struct IconGroup {
        let name: String
        let icons: [String]
    }
    
    var icons: [IconGroup] {
        [
            IconGroup(
                name: "Food & Drink",
                icons: [
                    "grocery-bag",
                    "utensils",
                    "mug-hot-alt",
                ],
            ),
        ]
    }

}
