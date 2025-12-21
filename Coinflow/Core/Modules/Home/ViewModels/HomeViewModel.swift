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
    @Published var selectedAccountIndex = 0
    
    func totalBalance(accounts: [Account]) -> Double {
        accounts.reduce(0) { $0 + $1.balance }
    }
}
