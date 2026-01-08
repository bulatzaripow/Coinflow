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
    
    func saveTransaction(_ transaction: Transaction) {
        context.insert(transaction)
        
        do {
            try context.save()
        } catch {
            print("Error saving transaction: \(transaction)")
        }
    }
}
