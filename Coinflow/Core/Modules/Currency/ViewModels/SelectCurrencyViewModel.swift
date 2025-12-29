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
    
    @Published var selectedCurrency: Currency?
    @Published var searchText: String = ""
    
    private let currencyService: CurrencyManageService
    var selectCurrency: (Currency) -> Void
    
    // MARK: - Init
    
    init(
        currencyService: CurrencyManageService,
        selectCurrency: @escaping (Currency) -> Void
    ) {
        self.currencyService = currencyService
        self.selectCurrency = selectCurrency
        
        self.selectedCurrency = currencyService.defaultCurrency()
    }
    
    // MARK: - Methods
    
    func searchCurrencies(_ currencies: [Currency]) -> [Currency] {
        if searchText.isEmpty {
            return currencies.sorted { ($0.id == selectedCurrency?.id) && ($1.id != selectedCurrency?.id) }
        }
        
        let filtered = currencies.filter { currency in
            currency.code.lowercased().contains(searchText.lowercased()) ||
            currency.name.lowercased().contains(searchText.lowercased())
        }
        
        return filtered.sorted { ($0.id == selectedCurrency?.id) && ($1.id != selectedCurrency?.id) }
    }
    
    func isSelected(_ currency: Currency) -> Bool {
        selectedCurrency?.code == currency.code
    }
}
