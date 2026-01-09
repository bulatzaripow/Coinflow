//
//  TransactionManageService.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 05.01.2026.
//

import Foundation
import SwiftData

final class TransactionManageService: TransactionManageServiceProtocol {

    // MARK: - Props
    
    private let context: ModelContext
    
    // MARK: - Init
    
    init(context: ModelContext) {
        self.context = context
    }
    
    // MARK: - Methods
    
    func fetch(id: UUID) -> Transaction? {
        let predicate = #Predicate<Transaction> { $0.id == id }
        let descriptor = FetchDescriptor<Transaction>(predicate: predicate)
        return try? context.fetch(descriptor).first
    }
    
    func save(_ transaction: Transaction) {
        do {
            try context.save()
        } catch {
            print("Error saving transaction: \(transaction)")
        }
    }
    
    func create(_ transaction: Transaction) {
        context.insert(transaction)
        
        do {
            try context.save()
        } catch {
            print("Error creating transaction: \(transaction)")
        }
    }
    
    func delete(_ transaction: Transaction) {
        context.delete(transaction)
        
        do {
            try context.save()
        } catch {
            print("Error deleting transaction: \(transaction)")
        }
    }
}
