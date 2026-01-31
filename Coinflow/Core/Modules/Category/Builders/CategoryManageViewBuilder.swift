//
//  CategoryManageViewBuilder.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 30.01.2026.
//

import SwiftData

struct CategoryManageViewBuilder {
    static func build(
        context: ModelContext,
        onUpdate: @escaping () -> Void
    ) -> CategoryManageView {
        let categoryService = CategoryManageService(context: context)
        
        let vm = CategoryManageViewModel(categoryService: categoryService)
        
        return CategoryManageView(
            viewModel: vm,
            onUpdate: onUpdate
        )
    }
}
