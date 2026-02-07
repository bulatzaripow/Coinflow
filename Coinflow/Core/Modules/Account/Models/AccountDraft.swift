//
//  AccountDraft.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 07.02.2026.
//

import Foundation

struct AccountDraft: Equatable {
    var name: String = ""
    var balance: Double = 0
    var isDefault: Bool = false
    var currency: Currency
    var backgroundColor: String?
    var backgroundPattern: String?
    
    static func from(account: Account) -> AccountDraft {
        AccountDraft(
            name: account.name,
            balance: account.balance,
            isDefault: (account.isDefault != 0),
            currency: account.currency,
            backgroundColor: account.backgroundColor,
            backgroundPattern: account.backgroundPattern
        )
    }
}
