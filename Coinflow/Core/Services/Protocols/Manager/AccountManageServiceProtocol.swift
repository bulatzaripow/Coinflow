//
//  AccountManageServiceProtocol.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 29.12.2025.
//

import Foundation
import SwiftData

protocol AccountManageServiceProtocol {
    func fetchAll() -> [Account]
    func fetchById(_ id: UUID) -> Account?
    func save(_ item: Account)
    func delete(_ item: Account)
    func saveContext() throws
    func nextSortIndex() -> Int
}
