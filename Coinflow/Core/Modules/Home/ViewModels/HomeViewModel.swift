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
    
    @Published var showSettings: Bool = false
    @Published var showAddAccountSheet: Bool = false
    @Published var showAddTransactionSheet: Bool = false
    @Published var accountToEdit: Account?
    @Published var selectedAccount: Account?
    @Published var transactionToEdit: Transaction?
    
    private var transactionService: TransactionManageServiceProtocol
    
    // MARK: - Init
    
    init(transactionService: TransactionManageServiceProtocol) {
        self.transactionService = transactionService
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
}
