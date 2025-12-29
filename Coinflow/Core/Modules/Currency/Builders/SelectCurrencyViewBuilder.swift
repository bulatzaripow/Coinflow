//
//  SelectCurrencyViewBuilder.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 29.12.2025.
//

import SwiftData

struct SelectCurrencyViewBuilder {
    static func build(
        modelContext: ModelContext,
        selectCurrency: @escaping (Currency) -> Void
    ) -> SelectCurrencyView {
        let currencyService = CurrencyManageService(
            context: modelContext
        )
        
        let vm = SelectCurrencyViewModel(
            currencyService: currencyService,
            selectCurrency: selectCurrency
        )
        
        return SelectCurrencyView(viewModel: vm)
    }
}
