//
//  Transaction.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import Foundation
import SwiftData

extension SchemaV1 {
    @Model
    final class Transaction: Identifiable {
        var note: String?
        var amount: Double = 0
        var date: Date = Date()
        var isHidden: Bool = false
        var createdAt: Date = Date()
        var type: TransactionType

        var account: Account?
        var toAccount: Account?
        var category: Category?

        init(
            note: String? = nil,
            amount: Double = 0,
            date: Date = Date(),
            type: TransactionType = .expense,
            isHidden: Bool = false,
            createdAt: Date = Date(),
            category: Category? = nil,
            account: Account? = nil,
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
}

enum TransactionType: String, CaseIterable, Codable {
    case income
    case expense
    case transfer
}

extension Transaction {
    func formattedData() -> String {
        guard let account else { return "" }
        return CurrencyFormatter.format(amount, currency: account.currency)
    }
}
