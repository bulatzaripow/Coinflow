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
    
    var transactions: [Transaction] = []
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
    
    private var transactionService: TransactionManageServiceProtocol
    
    // MARK: - Init
    
    init(transactionService: TransactionManageServiceProtocol) {
        self.transactionService = transactionService
        
        self.transactions = transactionService.fetch(startDate: startDate, endDate: endDate)
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
    }
    
    func hideTransactionAction(_ transaction: Transaction) {
        transaction.isHidden.toggle()
        transactionService.save(transaction)
    }
    
    func reloadTransactions() {
        transactions = transactionService.fetch(startDate: startDate, endDate: endDate)
    }
    
    func onNavigate(_ route: MainRoutes) {
        self.path.append(route)
    }
    
    func setDefaultCurrencyCode(_ code: String, userPreferences: UserPreferences) {
        userPreferences.setDefaultCurrencyCode(code)
    }
}
