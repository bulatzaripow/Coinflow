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
    var isDefault: Int = 0
    var sortIndex: Int = 0
    var icon: String = "cash"
    var backgroundColor: String? = nil
    var backgroundPattern: String? = nil
    var createdAt: Date = Date()
    
    @Relationship
    var currency: Currency
    
    @Relationship(deleteRule: .cascade, inverse: \Transaction.account)
    var transactions: [Transaction]? = []
    
    init(name: String, balance: Double, currency: Currency) {
        self.name = name
        self.balance = balance
        self.currency = currency
    }
    
    convenience init(
        name: String,
        balance: Double,
        currency: Currency,
        icon: String,
        backgroundPattern: String?
    ) {
        self.init(name: name, balance: balance, currency: currency)
        self.icon = icon
        self.backgroundPattern = backgroundPattern
    }
    
    convenience init(
        name: String,
        balance: Double,
        currency: Currency,
        icon: String,
        sortIndex: Int,
        isDefault: Int = 0,
        backgroundPattern: String? = nil,
        backgroundColor: String? = nil
    ) {
        self.init(
            name: name,
            balance: balance,
            currency: currency,
            icon: icon,
            backgroundPattern: backgroundPattern
        )
        self.sortIndex = sortIndex
        self.isDefault = isDefault
        self.backgroundColor = backgroundColor
    }
}
