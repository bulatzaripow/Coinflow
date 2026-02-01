//
//  BaseManageService.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 01.02.2026.
//

import Foundation
import SwiftData

class BaseManageService<Item: PersistentModel> {
    
    // MARK: - Props
    
    let context: ModelContext
    
    // MARK: - Init
    
    init(context: ModelContext) {
        self.context = context
    }
    
    // MARK: - Base methods
    
    func fetchAll() -> [Item] {
        let descriptor = FetchDescriptor<Item>()
        let items = try? context.fetch(descriptor)
        return items ?? []
    }
    
    func fetchById(_ id: PersistentIdentifier) -> Item? {
        let predicate = #Predicate<Item> { $0.id == id }
        let descriptor = FetchDescriptor<Item>(predicate: predicate)
        return try? context.fetch(descriptor).first
    }
    
    func save(_ item: Item) {
        context.insert(item)
        
        do {
            try saveContext()
        } catch {
            print("Error saving item: \(error)")
        }
    }
    
    func saveContext() throws {
        try context.save()
    }
    
    func delete(_ item: Item) {
        context.delete(item)
        
        do {
            try context.save()
        } catch {
            print("Delete error:", error)
        }
    }
    
}
