//
//  OverviewViewModel.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 11.01.2026.
//

import Foundation
import Combine
import SwiftUI
import SwiftData

final class OverviewViewModel: ObservableObject {
    
    // MARK: - Props
    
    @Published var selectedAccount: Account?
    @Published var startDate = Date.startOfCurrentMonth {
        didSet { reloadTransactions() }
    }
    @Published var endDate = Date.endOfCurrentMonth {
        didSet { reloadTransactions() }
    }
    
    var categories: [Category] = []
    var transactions: [Transaction] = []
    
    private var context: ModelContext
    private let accountService: AccountManageServiceProtocol
    private let categoryService: CategoryManageServiceProtocol
    private let transactionService: TransactionManageServiceProtocol
    
    var incomeCategories: [Category] {
        categories
            .filter { $0.type == .income && hasTransactions(for: $0) }
    }
    
    var expenseCategories: [Category] {
        categories
            .filter { $0.type == .expense && hasTransactions(for: $0) }
    }
    
    var dateRangeText: String {
        Date.formatDateRange(startDate: startDate, endDate: endDate)
    }
    
    // MARK: - Init
    
    init(
        context: ModelContext,
        selectedAccount: Account?,
        accountService: AccountManageServiceProtocol,
        categoryService: CategoryManageServiceProtocol,
        transactionService: TransactionManageServiceProtocol,
    ) {
        self.context = context
        self.selectedAccount = selectedAccount
        self.accountService = accountService
        self.categoryService = categoryService
        self.transactionService = transactionService
        self.categories = categoryService.fetchCategories()
        self.transactions = transactionService.fetch(startDate: startDate, endDate: endDate)
    }
    
    // MARK: - Methods
    
    func reloadTransactions() {
        transactions = transactionService.fetch(startDate: startDate, endDate: endDate)
    }
    
    func getTransactions(for type: CategoryType) -> [Transaction] {
        transactions.filter { transaction in
            transaction.category?.type == type &&
            transaction.account?.id == selectedAccount?.id
        }
    }
    
    func getTotalAmount(for type: CategoryType) -> Double {
        transactions
            .filter { transaction in
                transaction.category?.type == type &&
                transaction.account?.id == selectedAccount?.id
            }
            .reduce(Double.zero) { $0 + abs($1.amount) }
    }
    
    private func hasTransactions(for category: Category) -> Bool {
        transactions.contains { transaction in
            transaction.category?.id == category.id &&
            transaction.account?.id == selectedAccount?.id
        }
    }
}
