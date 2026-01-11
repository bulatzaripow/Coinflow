//
//  SelectCurrencyViewBuilder.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 29.12.2025.
//

import SwiftData

struct SelectCurrencyViewBuilder {
    static func build(
        context: ModelContext,
        selectedCurrency: String = "USD",
        selectCurrencyAction: @escaping (Currency) -> Void
    ) -> SelectCurrencyView {
        let vm = SelectCurrencyViewModel(
            selectedCurrency: selectedCurrency,
            selectCurrencyAction: selectCurrencyAction
        )
        
        return SelectCurrencyView(viewModel: vm)
    }
}
