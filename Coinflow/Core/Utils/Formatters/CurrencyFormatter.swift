//
//  CurrencyFormatter.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 18.12.2025.
//

import Foundation

struct CurrencyFormatter {
    static func format(_ amount: Double, currency: Currency) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency.code
        formatter.currencySymbol = currency.symbol
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2

        formatter.currencySymbol = " " + currency.symbol
        formatter.positivePrefix = ""
        formatter.negativePrefix = "-"
        formatter.positiveSuffix = " " + currency.symbol
        formatter.negativeSuffix = " " + currency.symbol

        return formatter.string(from: amount as NSNumber) ?? "0 \(currency.symbol)"
    }
}
