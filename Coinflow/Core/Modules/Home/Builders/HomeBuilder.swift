//
//  HomeBuilder.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import Foundation
import SwiftData

struct HomeBuilder {
    static func build(
        context: ModelContext
    ) -> HomeView {
        let accountService = AccountManageService(context: context)
        let transactionService = TransactionManageService(context: context)
        
        let viewModel = HomeViewModel(
            accountService: accountService,
            transactionService: transactionService
        )
        
        let view = HomeView(viewModel: viewModel)
        
        return view
    }
}
