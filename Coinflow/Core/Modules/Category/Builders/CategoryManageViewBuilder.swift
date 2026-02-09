//
//  CategoryManageViewBuilder.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 30.01.2026.
//

import SwiftData

struct CategoryManageViewBuilder {
    static func build(
        _ category: Category? = nil,
        context: ModelContext,
        onUpdate: @escaping () -> Void
    ) -> CategoryManageView {
        let categoryService = CategoryManageService(context: context)

        let viewModel = CategoryManageViewModel(
            category: category,
            categoryService: categoryService
        )

        return CategoryManageView(
            viewModel: viewModel,
            onUpdate: onUpdate
        )
    }
}
