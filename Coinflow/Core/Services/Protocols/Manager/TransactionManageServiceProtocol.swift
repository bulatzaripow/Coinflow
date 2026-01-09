//
//  TransactionManageServiceProtocol.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 05.01.2026.
//

import Foundation

protocol TransactionManageServiceProtocol {
    func fetch(id: UUID) -> Transaction?
    func save(_ transaction: Transaction)
    func create(_ transaction: Transaction)
    func delete(_ transaction: Transaction)
}
