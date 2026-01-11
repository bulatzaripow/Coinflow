//
//  SelectCurrencyViewModel.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 29.12.2025.
//

import Foundation
import Combine

class SelectCurrencyViewModel: ObservableObject {
    
    // MARK: - Props
    
    @Published var selectedCurrency: String = ""
    @Published var searchText: String = ""

    var selectCurrencyAction: (Currency) -> Void
    
    // MARK: - Init
    
    init(
        selectedCurrency: String,
        selectCurrencyAction: @escaping (Currency) -> Void
    ) {
        self.selectedCurrency = selectedCurrency
        self.selectCurrencyAction = selectCurrencyAction
    }
    
    // MARK: - Methods
    
    func searchCurrencies(_ currencies: [Currency]) -> [Currency] {
        guard !searchText.isEmpty else {
            return currencies
        }
        
        let filtered = currencies.filter { currency in
            currency.code.lowercased().contains(searchText.lowercased()) ||
            currency.name.lowercased().contains(searchText.lowercased())
        }
        
        return filtered
    }
    
    func isSelected(_ currency: Currency) -> Bool {
        selectedCurrency == currency.code
    }
    
    func selectCurrency(_ currency: Currency) {
        self.selectedCurrency = currency.code
        selectCurrencyAction(currency)
    }
}
