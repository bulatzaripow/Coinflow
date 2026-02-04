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
    
    override func delete(_ transaction: Transaction) {
        revertChanges(for: transaction)
        context.delete(transaction)
        
        do {
            try context.save()
        } catch {
            print("Delete error:", error)
        }
    }
    
    func save(
        _ transaction: Transaction,
        amount: Double,
        note: String,
        type: TransactionType,
        date: Date,
        category: Category?,
        account: Account,
        toAccount: Account? = nil,
    ) {
        let isNewTransaction = transaction.persistentModelID.storeIdentifier == nil
        
        if !isNewTransaction {
            revertChanges(for: transaction)
        }
        
        transaction.amount = amount
        transaction.type = type
        transaction.note = note
        transaction.date = date
        transaction.account = account
        if let category {
            transaction.category = category
        }
        if let toAccount {
            transaction.toAccount = toAccount
        }
        
        if isNewTransaction {
            context.insert(transaction)
        }
    
        let account = transaction.account
        let toAccount = transaction.toAccount
        let amount = abs(transaction.amount)
        
        switch transaction.type {
        case .expense:
            account.balance -= amount
            
        case .income:
            account.balance += amount
            
        case .transfer:
            account.balance -= amount
            toAccount?.balance += amount
        }
        
        do {
            try saveContext()
        } catch {
            print("Error saving item: \(error)")
        }
    }
    
    private func revertChanges(for transaction: Transaction) {
        let account = transaction.account
        let toAccount = transaction.toAccount
        let amount = abs(transaction.amount)
        
        switch transaction.type {
        case .expense:
            account.balance += amount
            
        case .income:
            account.balance -= amount
            
        case .transfer:
            account.balance += amount
            toAccount?.balance -= amount
        }
    }
}
