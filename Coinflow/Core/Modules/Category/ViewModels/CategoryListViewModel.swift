//
//  CategoryListViewModel.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 30.01.2026.
//

import Foundation
import Combine
import SwiftUI

final class CategoryListViewModel: ObservableObject {
    
    // MARK: - Props
    
    @Published var selectedType: CategoryType = .expense
    @Published var editMode = EditMode.inactive
    @Published var showAddCategorySheet: Bool = false
    @Published var categories: [Category] = []
    @Published var categoryToEdit: Category? = nil
    
    private let categoryService: CategoryManageServiceProtocol
    
    // MARK: - Init
    
    init(categoryService: CategoryManageServiceProtocol) {
        self.categoryService = categoryService
        
        loadCategories()
    }
    
    // MARK: - Methods
    
    func loadCategories() {
        categories = categoryService.fetchAllByType(type: selectedType)
            .sorted { $0.sortOrder < $1.sortOrder }
    }
    
    
    func changeType(_ type: CategoryType) {
        selectedType = type
        loadCategories()
    }
    
    func delete(at offsets: IndexSet) {
        
        offsets.forEach { index in
            let category = categories[index]
            categoryService.delete(category)
        }
        
        loadCategories()
    }
    
    func move(from source: IndexSet, to destination: Int) {
        categories.move(fromOffsets: source, toOffset: destination)
        
        for (index, category) in categories.enumerated() {
            category.sortOrder = index
            categoryService.save(category)
        }
    }
    
    func addNewCategory() {
        showAddCategorySheet.toggle()
    }
    
    func onTapAction(_ category: Category) {
        self.categoryToEdit = category
    }
}

