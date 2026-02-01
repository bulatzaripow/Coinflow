//
//  Currency.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 19.12.2025.
//

import Foundation
import SwiftData

@Model
final class Currency: Identifiable {
    var code: String = ""
    var symbol: String = ""
    var name: String = ""
    var isBaseCurrency: Bool = false
    var sortIndex: Int = 0
    var createdAt: Date = Date()

    init(
        code: String,
        symbol: String,
        name: String,
        sortIndex: Int = 0,
        createdAt: Date = Date()
    ) {
        self.code = code
        self.symbol = symbol
        self.name = name
        self.sortIndex = sortIndex
        self.createdAt = createdAt
    }
}
