//
//  makeCurrency.swift
//  CoinflowTests
//
//  Created by Bulat Zaripov on 10.02.2026.
//

import SwiftData
@testable import Coinflow

func makeCurrency(
    context: ModelContext,
    code: String = "USD",
    symbol: String = "$",
    name: String = "US Dollar",
    sortIndex: Int = 0
) -> Currency {
    let currency = Currency(
        code: code,
        symbol: symbol,
        name: name,
        sortIndex: sortIndex
    )
    context.insert(currency)
    return currency
}
