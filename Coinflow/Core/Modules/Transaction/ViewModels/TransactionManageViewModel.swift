//
//  TransactionManageViewModel.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 05.01.2026.
//

import SwiftUI
import SwiftData
import Combine

class TransactionManageViewModel: ObservableObject {
    
    // MARK: - Props
    
    private var transactionService: TransactionManageServiceProtocol
    private var accountService: AccountManageServiceProtocol
    private var categoryService: CategoryManageServiceProtocol
    
    var activeAccount: Account
    var accounts: [Account]
    var categories: [Category]
    
    @Published var type: TransactionType = .expense
    @Published var note: String = ""
    @Published var amount: String = ""
    @Published var date: Date = Date()
    @Published var selectedAccount: Account? = nil
    @Published var selectedToAccount: Account? = nil
    @Published var selectedCategory: Category? = nil
    @Published var transferToAccount: Account? = nil
    
    @Published var isButtonEnabled: Bool = false
    
    var canModify: Bool {
        guard !amount.isEmpty,
              let _ = Double(amount) else { return false }
        
        switch type {
        case .expense, .income:
            return selectedAccount != nil && selectedCategory != nil
        case .transfer:
            guard let selectedAccount, let selectedToAccount else { return false }
            return selectedAccount.id != selectedToAccount.id
        }
    }
    
    var filteredCategories: [Category] {
        return categories.filter { $0.type.rawValue == type.rawValue }
    }
    
    // MARK: - Init
    
    init(
        transactionService: TransactionManageServiceProtocol,
        accountService: AccountManageServiceProtocol,
        categoryService: CategoryManageServiceProtocol,
        activeAccount: Account
    ) {
        self.transactionService = transactionService
        self.accountService = accountService
        self.categoryService = categoryService
        self.activeAccount = activeAccount
        
        self.accounts = accountService.fetchAccounts()
        self.categories = categoryService.fetchCategories()
        self.selectedAccount = accounts.first
        self.selectedToAccount = accounts.first
        self.selectedCategory = categories.first
    }
    
    // MARK: - Methods
    
    func setDefaultsIfNeeded(
        categories: [Category]
    ) {
        if selectedCategory == nil {
            selectedCategory = categories.first
        }
    }
    
    func updateSelectedCategory() {
        selectedCategory = filteredCategories.first
    }
    
    func saveTransaction() {
        let transaction = Transaction(
            note: note,
            amount: Double(amount) ?? 0,
            date: date,
            type: type,
            isHidden: false,
            createdAt: Date(),
            category: selectedCategory,
            account: selectedAccount,
        )
        transactionService.saveTransaction(transaction)
    }

}
