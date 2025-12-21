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
    var id = UUID()
    var title: String
    var note: String? = nil
    var amount: Double = 0
    var date: Date
    var isHidden: Bool = false
    var createdAt: Date = Date()
    var type: TransactionType
    
    var account: Account? = nil
    var category: Category? = nil
    
    init(
        title: String,
        note: String? = nil,
        amount: Double,
        date: Date,
        isHidden: Bool = false,
        createdAt: Date = Date(),
        type: TransactionType = .expense,
        category: Category? = nil,
        account: Account? = nil,
    ) {
        self.title = title
        self.note = note
        self.amount = amount
        self.date = date
        self.isHidden = isHidden
        self.createdAt = createdAt
        self.type = type
        self.category = category
        self.account = account
    }
}

enum TransactionType: String, CaseIterable, Codable {
    case income = "income"
    case expense = "expense"
    case transfer = "transfer"
}

extension Transaction {
    func formattedData() -> String {
        let currency = self.account?.currency ?? Currency(
            code: "USD",
            symbol: "$",
            name: "US Dollar",
        )
        return CurrencyFormatter.format(amount, currency: currency)
    }
}
