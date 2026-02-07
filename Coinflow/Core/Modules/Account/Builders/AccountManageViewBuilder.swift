//
//  AccountManageViewBuilder.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 28.12.2025.
//

import SwiftData

struct AccountManageViewBuilder {
    static func build(
        _ account: Account? = nil,
        modelContext: ModelContext,
        userPreferences: UserPreferences,
        onAccountAdded: @escaping (Account) -> Void
    ) -> AccountManageView {
        let currencyService = CurrencyManageService(context: modelContext)
        let accountService = AccountManageService(context: modelContext)
        
        let vm = AccountManageViewModel(
            account: account,
            currencyService: currencyService,
            accountService: accountService,
            userPreferences: userPreferences,
            onAccountAdded: onAccountAdded
        )
        
        return AccountManageView(viewModel: vm)
    }
}
