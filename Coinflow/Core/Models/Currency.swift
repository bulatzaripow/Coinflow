//
//  Currency.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 19.12.2025.
//

import Foundation

final class Currency {
    var code: String = ""
    var symbol: String = ""
    var name: String = ""
    var createdAt: Date = Date()

    init(code: String, symbol: String, name: String, createdAt: Date = Date()) {
        self.code = code
        self.symbol = symbol
        self.name = name
        self.createdAt = createdAt
    }
}

extension Currency {
    static let demoCurrencies = [
        Currency(code: "EUR", symbol: "€", name: "currency_euro".localized),
        Currency(code: "JPY", symbol: "¥", name: "currency_japanese_yen".localized),
        Currency(code: "GBP", symbol: "£", name: "currency_british_pound".localized),
        Currency(code: "CNY", symbol: "¥", name: "currency_chinese_yuan".localized),
    ]
}
