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
        modelContext: ModelContext
    ) -> AccountManageView {
        let currencyService = CurrencyManageService(context: modelContext)
        let accountService = AccountManageService(context: modelContext)
        
        let vm = AccountManageViewModel(
            account: account,
            currencyService: currencyService,
            accountService: accountService,
        )
        
        return AccountManageView(viewModel: vm)
    }
}
