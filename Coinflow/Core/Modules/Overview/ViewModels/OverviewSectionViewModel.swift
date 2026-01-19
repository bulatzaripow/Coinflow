//
//  OverviewSectionViewModel.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 15.01.2026.
//

import Foundation
import Combine

class OverviewSectionViewModel: ObservableObject {
    
    // MARK: - Props
    
    @Published var title: String
    @Published var totalAmount: Double
    @Published var categories: [Category]
    @Published var selectedAccount: Account?
    @Published var type: OverviewSectionViewType
    @Published var defaultCurrency: Currency
    
    private var transactions: [Transaction] = []
    
    var sortedCategories: [Category] {
        return categories.sorted { getTotalAmount(for: $0) > getTotalAmount(for: $1) }
    }
    
    // MARK: - Init
    
    init(
        title: String,
        totalAmount: Double,
        categories: [Category],
        transactions: [Transaction],
        selectedAccount: Account? = nil,
        type: OverviewSectionViewType = .expense
    ) {
        self.title = title
        self.totalAmount = totalAmount
        self.categories = categories
        self.transactions = transactions
        self.selectedAccount = selectedAccount
        self.type = type
        self.defaultCurrency = selectedAccount?.currency ?? Currency(
            code: "USD",
            symbol: "$",
            name: "Dollar",
            sortIndex: 0,
            createdAt: Date()
        )
    }
    
    // MARK: - Methods

    func getTotalAmount(for category: Category) -> Double {
        transactions
            .filter { $0.category?.id == category.id }
            .reduce(Double.zero) { $0 + abs($1.amount) }
    }
}
