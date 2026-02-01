//
//  CategoryManageServiceProtocol.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 06.01.2026.
//

import Foundation
import SwiftData

protocol CategoryManageServiceProtocol {
    func fetchAll() -> [Category]
    func fetchById(_ id: PersistentIdentifier) -> Category?
    func save(_ item: Category)
    func delete(_ item: Category)
    func saveContext() throws
    
    func fetchAllInOrder(_ order: SortOrder) -> [Category]
    func fetchAllByType(type: CategoryType) -> [Category]
}
