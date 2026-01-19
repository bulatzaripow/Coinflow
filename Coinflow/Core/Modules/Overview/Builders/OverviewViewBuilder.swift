//
//  OverviewViewBuilder.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 11.01.2026.
//

import SwiftUI
import SwiftData

struct OverviewViewBuilder {
    static func build(
        context: ModelContext,
        selectedAccount: Account?
    ) -> OverviewView {
        let accountService = AccountManageService(context: context)
        let categoryService = CategoryManageService(context: context)
        let transactionService = TransactionManageService(context: context)
        
        let vm = OverviewViewModel(
            context: context,
            selectedAccount: selectedAccount,
            accountService: accountService,
            categoryService: categoryService,
            transactionService: transactionService
        )
        
        return OverviewView(viewModel: vm)
    }
}
