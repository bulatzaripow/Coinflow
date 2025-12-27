//
//  AccountInitializerService.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 21.12.2025.
//

import Foundation
import SwiftData

final class AccountInitializerService: AccountInitializerProtocol {
    
    // MARK: - Props
    
    let context: ModelContext
    let currencyService: CurrencyInitializerProtocol
    
    // MARK: - Init
    
    init(
        context: ModelContext,
        currencyService: CurrencyInitializerProtocol
    ) {
        self.context = context
        self.currencyService = currencyService
    }
    
    // MARK: - Methods
    
    func setupDefaultAccountIfNeeded() {
        guard !checkIfAccountExists() else {
            print("Accounts already exists in database")
            return
        }
        
        // Default currency
        let preferredCurrencyCode = currencyService.detectUserCurrency()
        let currencyDescriptor = FetchDescriptor<Currency>(
            predicate: #Predicate<Currency> {
                $0.code == preferredCurrencyCode
            }
        )
        let currencies = (try? context.fetch(currencyDescriptor)) ?? []
        guard let defaultCurrency = currencies.first(where: { $0.code == preferredCurrencyCode }) ?? currencies.first else {
            print("No currencies available to create default account")
            return
        }
        
        // Default Account
        let mainAccount = Account(
            name: "Default",
            balance: 0,
            currency: defaultCurrency,
            isDefault: true,
        )
        
        // Insert account
        context.insert(mainAccount)
    }
    
    private func checkIfAccountExists() -> Bool {
        let descriptor = FetchDescriptor<Account>()
        
        do {
            let count = try context.fetchCount(descriptor)
            return count > 0
        } catch {
            print("Error checking accounts: \(error)")
            return false
        }
    }
    
}
