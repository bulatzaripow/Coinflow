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
    private let onAccountAdded: (Account) -> Void
    
    private let accountId: PersistentIdentifier?
    
    @Published var name: String = ""
    @Published var balance: Double = 0
    @Published var isDefault: Bool = false
    @Published var sortIndex: Int = 0
    @Published var icon: String = "cash"
    @Published var selectedCurrency: Currency
    @Published var backgroundColor: String?
    @Published var backgroundPattern: String?
    
    private var cancellables = Set<AnyCancellable>()
    @Published var nameError: AccountValidationError?
    @Published var balanceError: AccountValidationError?
    
    @Published var selectedColor: AppColors?
    @Published var selectedPattern: String?
    
    @Published var showSelectCurrencySheet: Bool = false
    @Published var path = NavigationPath()
    
    var canSave: Bool {
        nameError == nil &&
        balanceError == nil &&
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    // MARK: - Init
    
    init(
        account: Account? = nil,
        currencyService: CurrencyManageService,
        accountService: AccountManageServiceProtocol,
        onAccountAdded: @escaping (Account) -> Void,
    ) {
        self.accountId = account?.id
        self.account = account
        self.currencyService = currencyService
        self.accountService = accountService
        self.onAccountAdded = onAccountAdded
        
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
        
        setupValidation()
    }
    
    // MARK: - Methods
    
    private func setupValidation() {

        // Name validation
        $name
            .dropFirst()
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .sink { [weak self] value in
                self?.validateName(value)
            }
            .store(in: &cancellables)

        // Balance validation
        $balance
            .dropFirst()
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .sink { [weak self] value in
                self?.validateBalance(value)
            }
            .store(in: &cancellables)
    }
    
    func saveAccount(_ modelContext: ModelContext) {
        if let accountId = accountId {
            do {
                if let existingAccount = accountService.fetchById(accountId) {
                    existingAccount.name = name
                    existingAccount.balance = balance
                    existingAccount.currency = selectedCurrency
                    existingAccount.isDefault = isDefault ? 1 : 0
                    existingAccount.backgroundColor = backgroundColor
                    existingAccount.backgroundPattern = backgroundPattern
                    
                    try accountService.saveContext()
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
                sortIndex: accountService.nextSortIndex(),
                isDefault: isDefault ? 1 : 0,
                backgroundPattern: backgroundPattern,
                backgroundColor: backgroundColor,
            )

            accountService.save(newAccount)
            
            onAccountAdded(newAccount)
        }
    }
    
    func selectColor(_ color: AppColors?) {
        backgroundColor = color != nil ? color?.rawValue : nil
    }
    
    func selectPattern(_ pattern: String?) {
        backgroundPattern = pattern
    }
    
    private func validateName(_ value: String) {

        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.isEmpty {
            nameError = .emptyName
            return
        }

        if let first = trimmed.first, first.isNumber {
            nameError = .nameStartsWithDigit
            return
        }

        nameError = nil
    }


    private func validateBalance(_ value: Double) {

        if !value.isFinite {
            balanceError = .invalidBalance
            return
        }

        balanceError = nil
    }

}
