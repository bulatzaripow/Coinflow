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
    @Published var showSettings: Bool = false
    @Published var showAddAccountSheet: Bool = false
    @Published var showAddTransactionSheet: Bool = true
    @Published var accountToEdit: Account?
    @Published var selectedAccount: Account?
    
    func totalBalance(accounts: [Account]) -> Double {
        accounts.reduce(0) { $0 + $1.balance }
    }
}
