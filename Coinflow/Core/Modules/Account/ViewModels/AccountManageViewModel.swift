//
//  AccountManageViewModel.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 28.12.2025.
//

import SwiftUI
import SwiftData
import Combine

class AccountManageViewModel: ObservableObject {
    
    // MARK: - Props
    
    @Published var account: Account?
    private let currencyService: CurrencyManageServiceProtocol
    private let accountService: AccountManageServiceProtocol
    
    private let accountId: UUID?
    
    @Published var name: String = ""
    @Published var balance: Double = 0
    @Published var isDefault: Bool = false
    @Published var sortIndex: Int = 0
    @Published var icon: String = "cash"
    @Published var selectedCurrency: Currency
    @Published var backgroundColor: String?
    @Published var backgroundPattern: String?
    
    @Published var selectedColor: AppColors?
    @Published var selectedPattern: String?
    
    @Published var showSelectCurrencySheet: Bool = false
    @Published var path = NavigationPath()
    
    var canSave: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    // MARK: - Init
    
    init(
        account: Account? = nil,
        currencyService: CurrencyManageService,
        accountService: AccountManageServiceProtocol,
    ) {
        self.accountId = account?.id
        self.account = account
        self.currencyService = currencyService
        self.accountService = accountService
        
        self.selectedCurrency = currencyService.defaultCurrency()
        
        if let account = self.account {
            name = account.name
            balance = account.balance
            sortIndex = account.sortIndex
            isDefault = account.isDefault > 0
            backgroundColor = account.backgroundColor
            backgroundPattern = account.backgroundPattern
            
            selectedColor = AppColors(rawValue: account.backgroundColor ?? "")
            selectedPattern = account.backgroundPattern
        }
    }
    
    // MARK: - Methods
    
    func saveAccount(_ modelContext: ModelContext) {
        if let accountId = accountId {
            do {
                if let existingAccount = accountService.fetchAccount(id: accountId) {
                    existingAccount.name = name
                    existingAccount.balance = balance
                    existingAccount.currency = selectedCurrency
                    existingAccount.isDefault = isDefault ? 1 : 0
                    existingAccount.backgroundColor = backgroundColor
                    existingAccount.backgroundPattern = backgroundPattern
                    
                    try modelContext.save()
                }
            } catch {
                print("Error updating account: \(error)")
            }
        } else {
            let newAccount = Account(
                name: name,
                balance: balance,
                currency: selectedCurrency,
                icon: icon,
                sortIndex: accountService.accountsCount(),
                isDefault: isDefault ? 1 : 0,
                backgroundPattern: backgroundPattern,
                backgroundColor: backgroundColor,
            )
            
            accountService.saveAccount(newAccount)
        }
    }
    
    func selectColor(_ color: AppColors?) {
        backgroundColor = color != nil ? color?.rawValue : nil
    }
    
    func selectPattern(_ pattern: String?) {
        backgroundPattern = pattern
    }
}
