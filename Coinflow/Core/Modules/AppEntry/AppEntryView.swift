//
//  AppEntryView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import SwiftUI
import SwiftData

struct AppEntryView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        ZStack {
            if hasSeenOnboarding {
                HomeBuilder.build(
                    context: modelContext
                )
                .transition(.move(edge: .trailing))
            } else {
                OnboardingView()
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: hasSeenOnboarding)
    }
}

#Preview {
    let schema = Schema([
        Transaction.self,
        Category.self,
        Account.self,
        Currency.self
    ])
    
    let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: schema, configurations: [config])

    let context = container.mainContext
    
    let currencyService = CurrencyInitializerService(context: context)
    let categoryService = CategoryInitializerService(context: context)
    let accountService = AccountInitializerService(context: context, currencyService: currencyService)
    
    currencyService.setupDefaultCurrenciesIfNeeded()
    categoryService.setupDefaultCategoriesIfNeeded()
    accountService.setupDefaultAccountIfNeeded()
    
    return AppEntryView()
        .modelContainer(container)
}
