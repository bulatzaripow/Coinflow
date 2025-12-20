//
//  Transaction.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import Foundation

struct Transaction: Identifiable {
    let id = UUID()
    var title: String
    var note: String? = nil
    var amount: Double = 0
    var date: Date
    var isHidden: Bool = false
    var createdAt: Date = Date()
    var type: TransactionType
    
    var category: Category? = nil
    var account: Account? = nil
    var toAccount: Account? = nil
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
    
    static let demoTransactions: [Transaction] = [
        Transaction(
            title: "Grocery Store in Canada",
            note: "I bought a new vending machine and new vegitables",
            amount: -451_123.56,
            date: Date(),
            type: .expense,
        ),
        Transaction(
            title: "Salary",
            amount: 2500.00,
            date: Date().addingTimeInterval(-86400),
            type: .income,
        ),
        Transaction(
            title: "Gas Station",
            amount: -45.50,
            date: Date().addingTimeInterval(-172800),
            type: .expense,
        ),
        Transaction(
            title: "Grocery Store",
            amount: -85.30,
            date: Date(),
            type: .expense,
        ),
        Transaction(
            title: "Salary",
            amount: 2500.00,
            date: Date().addingTimeInterval(-86400),
            type: .income,
        ),
        Transaction(
            title: "Gas Station",
            amount: -45.50,
            date: Date().addingTimeInterval(-172800),
            type: .expense,
        ),
        Transaction(
            title: "Grocery Store",
            amount: -85.30,
            date: Date(),
            type: .expense,
        ),
        Transaction(
            title: "Salary",
            amount: 2500.00,
            date: Date().addingTimeInterval(-86400),
            type: .income,
        ),
        Transaction(
            title: "Gas Station",
            amount: -45.50,
            date: Date().addingTimeInterval(-172800),
            type: .expense,
        )
    ]
}
