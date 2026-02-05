//
//  AccountManageService.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 29.12.2025.
//

import Foundation
import SwiftData

final class AccountManageService: BaseManageService<Account>, AccountManageServiceProtocol {
    
    override func save(_ item: Account) {
        // Set other items not default
        if item.isDefault == 1 {
            let accounts = fetchAll()
            accounts.filter { $0.id != item.id && $0.isDefault == 1 }.forEach { $0.isDefault = 0 }
        }
        
        super.save(item)
    }
    
    override func fetchAll() -> [Account] {
        let descriptor = FetchDescriptor<Account>(
            sortBy: [
                SortDescriptor(\.sortIndex, order: .forward)
            ]
        )
        let items = try? context.fetch(descriptor)
        return items ?? []
    }
    
    func nextSortIndex() -> Int {
        let descriptor = FetchDescriptor<Account>()
        
        do {
            let accounts = try context.fetch(descriptor)
            return accounts.map(\.sortIndex).max() ?? 0 + 1
        } catch {
            print("Error fetching accounts count: \(error)")
            return 0
        }
    }
    
}
