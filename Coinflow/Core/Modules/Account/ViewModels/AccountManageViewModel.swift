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
    
    @Published var name: String = "" {
        didSet {
            if let account = account {
                account.name = name
            }
        }
    }
    
    @Published var balance: Double = 0 {
        didSet {
            if let account = account {
                account.balance = balance
            }
        }
    }
    
    @Published var isDefault: Bool = false {
        didSet {
            if let account = account {
                account.isDefault = isDefault ? 1 : 0
            }
        }
    }
    
    @Published var selectedCurrency: Currency {
        didSet {
            if let account = account {
                account.currency = selectedCurrency
            }
        }
    }
    
    @Published var backgroundColor: String? = nil {
        didSet {
            if let account = account {
                account.backgroundColor = backgroundColor
            }
        }
    }
    
    @Published var backgroundPattern: String? = nil {
        didSet {
            if let account = account {
                account.backgroundPattern = backgroundPattern
            }
        }
    }
    
    @Published var selectedColor: AppColors?
    @Published var selectedPattern: String?
    
    @Published var showSelectCurrencySheet: Bool = false
    @Published var path = NavigationPath()
    @Published var route: AccountRoutes = .account
    
    var canSave: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    // MARK: - Init
    
    init(
        account: Account? = nil,
        currencyService: CurrencyManageService,
        accountService: AccountManageServiceProtocol,
    ) {
        self.account = account
        self.currencyService = currencyService
        self.accountService = accountService
        
        self.selectedCurrency = currencyService.defaultCurrency()
        
        if let account = self.account {
            name = account.name
            balance = account.balance
            isDefault = account.isDefault > 0
            backgroundColor = account.backgroundColor
            backgroundColor = account.backgroundPattern
            
            selectedColor = AppColors(rawValue: account.backgroundColor ?? "")
            selectedPattern = account.backgroundPattern
        }
    }
    
    // MARK: - Methods
    
    func saveAccount(_ modelContext: ModelContext) {
        let account = self.account ?? Account(
            name: name,
            balance: balance,
            currency: selectedCurrency,
            sortIndex: accountService.accountsCount(),
            isDefault: isDefault ? 1 : 0,
            backgroundPattern: backgroundPattern,
            backgroundColor: backgroundColor,
        )
        
        accountService.saveAccount(account)
    }
    
    func selectColor(_ color: AppColors?) {
        backgroundColor = color != nil ? color?.rawValue : nil
    }
    
    func selectPattern(_ pattern: String?) {
        backgroundPattern = pattern
    }
}
