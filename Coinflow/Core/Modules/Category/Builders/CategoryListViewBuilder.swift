//
//  CategoryListViewBuilder.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 30.01.2026.
//

import Foundation
import SwiftData

struct CategoryListViewBuilder {
    static func build(
        context: ModelContext
    ) -> CategoryListView {
        let categoryService = CategoryManageService(context: context)

        let viewModel = CategoryListViewModel(
            categoryService: categoryService
        )

        return CategoryListView(viewModel: viewModel)
    }
}
