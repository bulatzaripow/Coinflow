//
//  TransactionManageServiceProtocol.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 05.01.2026.
//

import Foundation
import SwiftData

protocol TransactionManageServiceProtocol {
    func fetchAll() -> [Transaction]
    func fetchById(_ id: PersistentIdentifier) -> Transaction?
    func save(_ item: Transaction)
    func delete(_ item: Transaction)
    func saveContext() throws

    func fetchByAccountAndDateRange(account: Account, startDate: Date, endDate: Date) -> [Transaction]

    func save(
        _ transaction: Transaction,
        amount: Double,
        note: String,
        type: TransactionType,
        date: Date,
        category: Category?,
        account: Account,
        toAccount: Account?,
    )
}
