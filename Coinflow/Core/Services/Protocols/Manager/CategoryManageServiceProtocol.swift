//
//  CategoryManageServiceProtocol.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 06.01.2026.
//

import Foundation

protocol CategoryManageServiceProtocol {
    func fetchAll(_ order: SortOrder) -> [Category]
    func fetchAllByType(type: CategoryType) -> [Category]
    func save()
    func save(_ category: Category)
    func delete(_ category: Category)
}

extension CategoryManageServiceProtocol {
    func fetchAll() -> [Category] {
        self.fetchAll(.forward)
    }
}
