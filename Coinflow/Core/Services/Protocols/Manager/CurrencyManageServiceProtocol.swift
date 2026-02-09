//
//  CurrencyManageServiceProtocol.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 29.12.2025.
//

import Foundation
import SwiftData

protocol CurrencyManageServiceProtocol {
    func fetchAll() -> [Currency]
    func fetchById(_ id: PersistentIdentifier) -> Currency?
    func save(_ item: Currency)
    func delete(_ item: Currency)
    func saveContext() throws

    func defaultCurrency() -> Currency
    func fetchByCode(by code: String) -> Currency?
}
