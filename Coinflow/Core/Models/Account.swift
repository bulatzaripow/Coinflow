//
//  Account.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import Foundation
import SwiftData

@Model
final class Account: Identifiable {
    var id = UUID()
    var name: String
    var balance: Double = 0
    var isDefault: Bool = false
//    var currency: Currency?
    var accountBackgroundPattern: String? = nil
    var createdAt: Date = Date()
    
    @Relationship(deleteRule: .nullify)
    var currency: Currency?
    
    @Relationship(deleteRule: .cascade, inverse: \Transaction.account)
    var transactions: [Transaction]? = []
    
    init(name: String, balance: Double) {
        self.name = name
        self.balance = balance
    }
    
    convenience init(name: String, balance: Double, accountBackgroundPattern: String?) {
        self.init(name: name, balance: balance)
        self.accountBackgroundPattern = accountBackgroundPattern
    }
    
    convenience init(
        name: String,
        balance: Double,
        currency: Currency,
        isDefault: Bool = false,
        accountBackgroundPattern: String? = nil
    ) {
        self.init(name: name, balance: balance, accountBackgroundPattern: accountBackgroundPattern)
        self.isDefault = isDefault
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
}
