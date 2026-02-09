//
//  TransactionManageViewBuilder.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 05.01.2026.
//

import SwiftData

struct TransactionManageViewBuilder {
    static func build(
        _ transaction: Transaction? = nil,
        activeAccount: Account,
        context: ModelContext,
        onUpdate: @escaping () -> Void
    ) -> TransactionManageView {
        let transactionService = TransactionManageService(context: context)
        let accountService = AccountManageService(context: context)
        let categoryService = CategoryManageService(context: context)

        let viewModel = TransactionManageViewModel(
            transaction: transaction,
            transactionService: transactionService,
            accountService: accountService,
            categoryService: categoryService,
            activeAccount: activeAccount,
        )

        let view = TransactionManageView(
            viewModel: viewModel,
            onUpdate: onUpdate
        )

        return view
    }
}
