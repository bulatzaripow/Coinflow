//
//  CoinflowApp.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import SwiftUI
import SwiftData

@main
struct CoinflowApp: App {
    var body: some Scene {
        WindowGroup {
            AppEntryView()
        }
        .modelContainer(sharedModelContainer)
    }
    
    var sharedModelContainer: ModelContainer {
        let schema = Schema([
            Transaction.self,
            Category.self,
            Account.self,
            Currency.self
        ])
        
        do {
            let localConfig = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false
            )
            
            let container = try ModelContainer(for: schema, configurations: [localConfig])
            print("ModelContainer created successfully")
            
            createDefaultDataIfNeeded(context: container.mainContext)
            return container
            
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}

// MARK: - Create defaults func

private func createDefaultDataIfNeeded(context: ModelContext) {
    let hasCreatedDefaults = UserDefaults.standard.bool(forKey: "defaultDataCreated")
        
    guard !hasCreatedDefaults else {
        print("Default data already exists")
        return
    }
    
    print("Creating default data...")
    
    let currencyService: CurrencyInitializerProtocol = CurrencyInitializerService(context: context)
    let categoryService: CategoryInitializerProtocol = CategoryInitializerService(context: context)
    let accountService: AccountInitializerProtocol = AccountInitializerService(context: context, currencyService: currencyService)
    
    currencyService.setupDefaultCurrenciesIfNeeded()
    categoryService.setupDefaultCategoriesIfNeeded()
    accountService.setupDefaultAccountIfNeeded()

    do {
        try context.save()
        UserDefaults.standard.set(true, forKey: "defaultDataCreated")
        print("Default data created successfully")
    } catch {
        print("Error saving default data: \(error)")
    }
}
