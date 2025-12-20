//
//  HomeViewModel.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var accounts = Account.demoAccounts
    @Published var transactions = Transaction.demoTransactions
    @Published var selectedAccountIndex = 0
    
    var totalBalance: Double {
        accounts.reduce(0) { $0 + $1.balance }
    }
}
