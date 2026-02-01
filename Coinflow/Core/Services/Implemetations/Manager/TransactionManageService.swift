//
//  TransactionManageService.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 05.01.2026.
//

import Foundation
import SwiftData

final class TransactionManageService: BaseManageService<Transaction>, TransactionManageServiceProtocol {
    
    func fetchByAccountAndDateRange(account: Account, startDate: Date, endDate: Date) -> [Transaction] {
        let persistentAccountId = account.persistentModelID
        let predicate = #Predicate<Transaction> { tx in
            tx.date >= startDate &&
            tx.date <= endDate &&
            tx.account.persistentModelID == persistentAccountId
        }
        
        let descriptor = FetchDescriptor<Transaction>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        
        return (try? context.fetch(descriptor)) ?? []
    }
}
