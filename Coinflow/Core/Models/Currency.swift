//
//  Currency.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 19.12.2025.
//

import Foundation
import SwiftData

@Model
final class Currency {
    var id: UUID = UUID()
    var code: String = ""
    var symbol: String = ""
    var name: String = ""
    var isBaseCurrency: Bool = false
    var createdAt: Date = Date()

    init(code: String, symbol: String, name: String, createdAt: Date = Date()) {
        self.code = code
        self.symbol = symbol
        self.name = name
        self.createdAt = createdAt
    }
}
