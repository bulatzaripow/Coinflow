//
//  Account.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import Foundation

final class Account: Identifiable {
    let id = UUID()
    var name: String
    var balance: Double = 0
    var isDefault: Bool = false
    var currency: Currency?
    var accountPattern: String? = nil
    var createdAt: Date = Date()
    
    init(name: String, balance: Double) {
        self.name = name
        self.balance = balance
    }
    
    convenience init(name: String, balance: Double, accountPattern: String) {
        self.init(name: name, balance: balance)
        self.accountPattern = accountPattern
    }
}

extension Account {
    func formattedBalance() -> String {
        let currency = self.currency ?? Currency(
            code: "USD",
            symbol: "$",
            name: "US Dollar",
        )
        return CurrencyFormatter.format(balance, currency: currency)
    }
    
    static let demoAccounts = [
        Account(name: "Cash Wallet", balance: 250.146, accountPattern: "formal-invitation"),
        Account(name: "Main Bank", balance: 4500.0, accountPattern: "brick-wall"),
        Account(name: "Credit Card", balance: -320.0, accountPattern: "charlie-brown"),
    ]
}
