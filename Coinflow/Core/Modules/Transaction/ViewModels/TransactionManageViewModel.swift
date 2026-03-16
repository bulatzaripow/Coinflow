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

    @Published var transaction: Transaction?

    @Published var type: TransactionType = .expense
    @Published var note: String = ""
    @Published var amount: String = ""
    @Published var date: Date = Date()
    @Published var selectedAccount: Account?
    @Published var selectedToAccount: Account?
    @Published var selectedCategory: Category?
    @Published var transferToAccount: Account?
    @Published var showAddCategorySheet: Bool = false

    @Published var isButtonEnabled: Bool = false

    var canModify: Bool {
        guard !amount.isEmpty,
              amount.asDouble != nil else { return false }

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

    var filteredToAccounts: [Account] {
        return accounts.filter {
            $0.currency.code == selectedAccount?.currency.code &&
            $0.id != selectedAccount?.id
        }
    }

    // MARK: - Init

    init(
        transaction: Transaction? = nil,
        transactionService: TransactionManageServiceProtocol,
        accountService: AccountManageServiceProtocol,
        categoryService: CategoryManageServiceProtocol,
        activeAccount: Account
    ) {
        self.transaction = transaction
        self.transactionService = transactionService
        self.accountService = accountService
        self.categoryService = categoryService
        self.activeAccount = activeAccount

        // Fetch
        self.accounts = accountService.fetchAll()
        self.categories = categoryService.fetchAll()

        // Sort
        self.accounts = self.sortAccounts(accounts: accounts)

        if let transaction = self.transaction {
            type = transaction.type
            note = transaction.note ?? ""
            amount = String(transaction.amount)
            date = transaction.date

            selectedAccount = transaction.account
            selectedToAccount = transaction.toAccount
            selectedCategory = transaction.category
        } else {
            self.selectedAccount = accounts.first
            self.selectedCategory = categories.first
        }
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
        guard let account = self.selectedAccount else { return }
        let transaction = self.getTransaction()

        transactionService.save(
            transaction,
            amount: amount.asDouble ?? 0,
            note: note,
            type: type,
            date: date,
            category: selectedCategory,
            account: account,
            toAccount: selectedToAccount
        )
    }

    func onAddCategoryTapped() {
        showAddCategorySheet.toggle()
    }

    private func getTransaction() -> Transaction {
        if let transaction = self.transaction {
            return transaction
        }
        return Transaction(type: type)
    }

    private func sortAccounts(accounts: [Account]) -> [Account] {
        return accounts.sorted { account1, account2 in
            if account1.id == activeAccount.id {
                return true
            }
            if account2.id == activeAccount.id {
                return false
            }
            return account1.sortIndex < account2.sortIndex
        }
    }

}
