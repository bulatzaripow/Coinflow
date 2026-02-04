//
//  HomeViewModel.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import SwiftUI
import Combine
import SwiftData

class HomeViewModel: ObservableObject {
    
    // MARK: - Props
    
    @Published var path = NavigationPath()
    
    @Published var accounts: [Account] = []
    @Published var transactions: [Transaction] = []
    @Published var showSettings: Bool = false
    @Published var showAddAccountSheet: Bool = false
    @Published var showAddTransactionSheet: Bool = false
    @Published var accountToEdit: Account?
    @Published var selectedAccount: Account?
    @Published var transactionToEdit: Transaction?
    @Published var startDate = Date.startOfCurrentMonth {
        didSet { reloadTransactions() }
    }
    @Published var endDate = Date.endOfCurrentMonth {
        didSet { reloadTransactions() }
    }
    
    var dateRangeText: String {
        Date.formatDateRange(startDate: startDate, endDate: endDate)
    }
    
    private var accountService: AccountManageServiceProtocol
    private var transactionService: TransactionManageServiceProtocol
    
    // MARK: - Init
    
    init(
        accountService: AccountManageServiceProtocol,
        transactionService: TransactionManageServiceProtocol,
    ) {
        self.accountService = accountService
        self.transactionService = transactionService
        
        self.accounts = accountService.fetchAll()
        
        reloadTransactions()
    }
    
    // MARK: - Methods
    
    func totalBalance(accounts: [Account]) -> Double {
        accounts.reduce(0) { $0 + $1.balance }
    }
    
    func chooseTransactionToEdit(_ transaction: Transaction) {
        self.transactionToEdit = transaction
    }
    
    func deleteTransactionAction(_ transaction: Transaction) {
        transactionService.delete(transaction)
        reloadTransactions()
    }
    
    func reloadTransactions() {
        if let account = selectedAccount {
            self.transactions = transactionService.fetchByAccountAndDateRange(account: account, startDate: startDate, endDate: endDate)
        }
    }
    
    func onNavigate(_ route: MainRoutes) {
        self.path.append(route)
    }
    
    func setDefaultCurrencyCode(_ code: String, userPreferences: UserPreferences) {
        userPreferences.setDefaultCurrencyCode(code)
    }
    
    func setSelectedAccount(_ selected: Account?) {
        self.selectedAccount = selected
        if let account = selected {
            transactions = transactionService.fetchByAccountAndDateRange(account: account, startDate: startDate, endDate: endDate)
        }
    }
}
