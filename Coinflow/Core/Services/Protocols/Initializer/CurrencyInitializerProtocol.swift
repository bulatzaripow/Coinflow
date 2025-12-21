//
//  CurrencyInitializerProtocol.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 21.12.2025.
//

import SwiftData

protocol CurrencyInitializerProtocol {
    
    // MARK: - Props
    
    var context: ModelContext { get }
    
    // MARK: - Methods
    
    func setupDefaultCurrenciesIfNeeded()
    func detectUserCurrency() -> String
}
