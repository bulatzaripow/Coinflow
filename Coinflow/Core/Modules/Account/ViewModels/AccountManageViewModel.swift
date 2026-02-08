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
    
    private(set) var account: Account?
    @Published var accountDraft: AccountDraft
    
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
        account?.modelContext != nil &&
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
        self.account = account
        self.currencyService = currencyService
        self.accountService = accountService
        self.userPreferences = userPreferences
        self.onAccountAdded = onAccountAdded
        
        let defaultCurrency = currencyService.fetchByCode(by: userPreferences.defaultCurrencyCode)
        
        if let account {
            self.accountDraft = AccountDraft.from(account: account)
        } else {
            self.accountDraft = AccountDraft(
                currency: defaultCurrency ?? currencyService.defaultCurrency()
            )
            self.nameError = .emptyName
        }
        
        setupValidation()
    }
    
    // MARK: - Methods
    
    private func setupValidation() {

        // Name validation
        $accountDraft
            .map { $0.name }
            .dropFirst()
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .sink { [weak self] value in
                self?.validateName(value)
            }
            .store(in: &cancellables)

        // Balance validation
        $accountDraft
            .map { $0.balance }
            .dropFirst()
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .sink { [weak self] value in
                self?.validateBalance(value)
            }
            .store(in: &cancellables)
    }
    
    func saveAccount() {
        let account = draftToAccount(
            draft: accountDraft,
            sortIndex: accountService.nextSortIndex(),
            account: account,
        )
        accountService.save(account)
        onAccountAdded(account)
    }
    
    func deleteAccount() {
        let accounts = accountService.fetchAll()

        guard accounts.count > 1 else { return }
        guard let account = self.account else { return }

        if accountDraft.isDefault {
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
        accountDraft.backgroundColor = color != nil ? color?.rawValue : nil
    }
    
    func selectPattern(_ pattern: String?) {
        accountDraft.backgroundPattern = pattern
    }
    
    func selectCurrency(_ currency: Currency) {
        accountDraft.currency = currency
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
    
    private func draftToAccount(draft: AccountDraft, sortIndex: Int, account: Account?) -> Account {
        if let account = account {
            account.name = draft.name
            account.balance = draft.balance
            account.currency = draft.currency
            account.sortIndex = sortIndex
            account.isDefault = draft.isDefault ? 1 : 0
            account.backgroundColor = draft.backgroundColor
            account.backgroundPattern = draft.backgroundPattern
            return account
        } else {
            return Account(
                name: draft.name,
                balance: draft.balance,
                currency: draft.currency,
                icon: "cash",
                sortIndex: sortIndex,
                isDefault: draft.isDefault ? 1 : 0,
                backgroundPattern: draft.backgroundPattern,
                backgroundColor: draft.backgroundColor,
            )
        }
    }

}
