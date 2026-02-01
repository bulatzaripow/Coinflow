//
//  CurrencyManageService.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 29.12.2025.
//

import Foundation
import SwiftData

final class CurrencyManageService: BaseManageService<Currency>, CurrencyManageServiceProtocol {
    
    func fetchByCode(by code: String) -> Currency? {
        let predicate = #Predicate<Currency> { currency in
            currency.code == code
        }
        
        let descriptor = FetchDescriptor<Currency>(
            predicate: predicate,
        )
        
        do {
            let currencies = try context.fetch(descriptor)
            return currencies.first
        } catch {
            print("Error fetching currency: \(error)")
            return nil
        }
    }
    
    func defaultCurrency() -> Currency {
        let userLocale = Locale.current
        let currencyCode = userLocale.currency?.identifier ?? "USD"
        
        return fetchByCode(by: currencyCode) ?? createDefaultCurrency()
    }
    
    private func createDefaultCurrency() -> Currency {
        let defaultCurrency = Currency(
            code: "USD",
            symbol: "$",
            name: "US Dollar"
        )
        
        context.insert(defaultCurrency)
        try? context.save()
        
        return defaultCurrency
    }
    
}
