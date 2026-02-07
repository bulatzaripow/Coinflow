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

    private let currencyService: CurrencyManageServiceProtocol
    private let accountService: AccountManageServiceProtocol
    private let userPreferences: UserPreferences
    private let onAccountAdded: (Account) -> Void
    
    private let accountId: PersistentIdentifier?
    
    @Published var account: Account
    
    private var cancellables = Set<AnyCancellable>()
    @Published var nameError: AccountValidationError?
    @Published var balanceError: AccountValidationError?
    
    @Published var selectedColor: AppColors?
    @Published var selectedPattern: String?
    
    @Published var showSelectCurrencySheet: Bool = false
    @Published var path = NavigationPath()
    
    @Published var showDeleteAlert = false
    
    var canSave: Bool {
        nameError == nil &&
        balanceError == nil
    }
    
    var canDelete: Bool {
        account.modelContext != nil &&
        accountService.fetchAll().count > 1
    }
    
    // MARK: - Init
    
    init(
        account: Account? = nil,
        currencyService: CurrencyManageService,
        accountService: AccountManageServiceProtocol,
        userPreferences: UserPreferences,
        onAccountAdded: @escaping (Account) -> Void,
    ) {
        self.accountId = account?.id
        self.currencyService = currencyService
        self.accountService = accountService
        self.userPreferences = userPreferences
        self.onAccountAdded = onAccountAdded
        
        let defaultCurrency = currencyService.fetchByCode(by: userPreferences.defaultCurrencyCode)

        if let account {
            self.account = account
        } else {
            self.account = Account(
                name: "",
                balance: 0,
                currency: defaultCurrency ?? currencyService.defaultCurrency(),
                icon: "cash",
                sortIndex: accountService.nextSortIndex(),
                isDefault: 0
            )
            self.nameError = .emptyName
        }
        
        setupValidation()
    }
    
    // MARK: - Methods
    
    private func setupValidation() {

        // Name validation
        $account
            .map { $0.name }
            .dropFirst()
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .sink { [weak self] value in
                self?.validateName(value)
            }
            .store(in: &cancellables)

        // Balance validation
        $account
            .map { $0.balance }
            .dropFirst()
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .sink { [weak self] value in
                self?.validateBalance(value)
            }
            .store(in: &cancellables)
    }
    
    func saveAccount() {
        accountService.save(account)
        onAccountAdded(account)
    }
    
    func deleteAccount() {
        let accounts = accountService.fetchAll()

        guard accounts.count > 1 else { return }

        if account.isDefault == 1 {
            let newDefault = accounts
                .filter { $0.id != account.id }
                .sorted { $0.sortIndex < $1.sortIndex }
                .first
            
            if newDefault != nil {
                newDefault?.isDefault = 1
                accountService.save(newDefault!)
            }
        }

        accountService.delete(account)
    }
    
    func selectColor(_ color: AppColors?) {
        account.backgroundColor = color != nil ? color?.rawValue : nil
    }
    
    func selectPattern(_ pattern: String?) {
        account.backgroundPattern = pattern
    }
    
    func selectCurrency(_ currency: Currency) {
        account.currency = currency
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
