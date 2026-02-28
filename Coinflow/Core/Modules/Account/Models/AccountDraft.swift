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
    var backgroundColor: AppColors?
    var backgroundPattern: String?

    static func from(account: Account) -> AccountDraft {
        let backgroundColor = account.backgroundColor.flatMap { AppColors(rawValue: $0) }
        return AccountDraft(
            name: account.name,
            balance: account.balance,
            isDefault: (account.isDefault != 0),
            currency: account.currency,
            backgroundColor: backgroundColor,
            backgroundPattern: account.backgroundPattern
        )
    }
}
