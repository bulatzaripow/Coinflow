//
//  makeAccount.swift
//  CoinflowTests
//
//  Created by Bulat Zaripov on 10.02.2026.
//

import SwiftData
@testable import Coinflow

func makeAccount(
    context: ModelContext,
    name: String = "Cash",
    balance: Double = 0,
    currency: Currency? = nil
) -> Account {
    let account = Account(
        name: name,
        balance: balance,
        currency: currency ?? makeCurrency(context: context)
    )
    context.insert(account)
    return account
}
