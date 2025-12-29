//
//  CurrencyManageServiceProtocol.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 29.12.2025.
//

import Foundation

protocol CurrencyManageServiceProtocol {
    func defaultCurrency() -> Currency
    func findCurrency(by code: String) -> Currency?
}
