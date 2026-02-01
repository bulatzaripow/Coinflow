//
//  Transaction.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import Foundation
import SwiftData

@Model
final class Transaction: Identifiable {
    var note: String? = nil
    var amount: Double = 0
    var date: Date
    var isHidden: Bool = false
    var createdAt: Date = Date()
    var type: TransactionType
    
    @Relationship(deleteRule: .cascade)
    var account: Account
    
    var toAccount: Account? = nil
    var category: Category? = nil
    
    init(
        note: String? = nil,
        amount: Double,
        date: Date,
        type: TransactionType = .expense,
        isHidden: Bool = false,
        createdAt: Date = Date(),
        category: Category? = nil,
        account: Account,
        toAccount: Account? = nil,
    ) {
        self.note = note
        self.amount = amount
        self.date = date
        self.isHidden = isHidden
        self.createdAt = createdAt
        self.type = type
        self.category = category
        self.account = account
        self.toAccount = toAccount
    }
}

enum TransactionType: String, CaseIterable, Codable {
    case income = "income"
    case expense = "expense"
    case transfer = "transfer"
}

extension Transaction {
    func formattedData() -> String {
        return CurrencyFormatter.format(amount, currency: self.account.currency)
    }
}
