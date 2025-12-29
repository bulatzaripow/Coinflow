//
//  AccountManageService.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 29.12.2025.
//

import Foundation
import SwiftData

final class AccountManageService: AccountManageServiceProtocol {
    
    // MARK: - Props
    
    private let context: ModelContext
    
    // MARK: - Init
    
    init(context: ModelContext) {
        self.context = context
    }
    
    // MARK: - Methods
    
    func accountsCount() -> Int {
        let descriptor = FetchDescriptor<Account>()
        
        do {
            let accounts = try context.fetch(descriptor)
            return accounts.count
        } catch {
            print("Error fetching accounts count: \(error)")
            return 0
        }
    }
    
    func saveAccount(_ account: Account) {
        context.insert(account)
        
        if account.isDefault == 1 {
            do {
                try unsetDefaultForOtherAccounts(except: account)
            } catch {
                print("Error unsetting default for other accounts except \(account.id): \(error)")
            }
        }
        
        do {
            try context.save()
        } catch {
            print("Error saving account: \(error)")
        }
    }
    
    private func unsetDefaultForOtherAccounts(except excludedAccount: Account) throws {
        let predicate = #Predicate<Account> { account in
            account.isDefault == 1
        }
        
        let descriptor = FetchDescriptor<Account>(predicate: predicate)
        
        do {
            let defaultAccounts = try context.fetch(descriptor)
            
            let otherDefaultAccounts = defaultAccounts.filter { $0.id != excludedAccount.id }
            
            for account in otherDefaultAccounts {
                account.isDefault = 0
            }
            
            if !otherDefaultAccounts.isEmpty {
                try context.save()
            }
        } catch {
            print("Error unsetting default accounts: \(error)")
            throw error
        }
    }
}
