//
//  CategoryManageViewModel.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 30.01.2026.
//

import Foundation
import SwiftData
import SwiftUI
import Combine

final class CategoryManageViewModel: ObservableObject {
    
    // MARK: - Props
    
    private let categoryService: CategoryManageServiceProtocol
    
    @Published var category: Category?
    @Published var name: String = ""
    @Published var type: CategoryType = .expense
    @Published var selectedIcon: String?
    
    let gridColumns: [GridItem] = Array(
        repeating: .init(.flexible(), spacing: 12),
        count: 5
    )
    
    var canSave: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        selectedIcon != nil
    }
    
    // MARK: - Init
    
    init(
        category: Category? = nil,
        categoryService: CategoryManageServiceProtocol
    ) {
        self.category = category
        self.categoryService = categoryService
        
        if let category = self.category {
            self.name = category.name
            self.type = category.type
            self.selectedIcon = category.icon
        }
    }
    
    // MARK: - Methods
    
    func saveCategory() {
        guard
            let icon = selectedIcon,
            canSave
        else { return }
        
        let newCategory = Category(
            name: name,
            type: type,
            icon: icon,
            color: "#757575",
            sortOrder: getNextSortOrder(),
            isDefault: false,
            createdAt: Date()
        )
        
        if let category = self.category {
            category.name = name
            category.icon = icon
            
            categoryService.save()
        } else {
            categoryService.save(newCategory)
        }
    }
    
    private func getNextSortOrder() -> Int {
        let categories = categoryService.fetchAll(.reverse)
        return (categories.first?.sortOrder ?? 0) + 1
    }
}

// Icons

extension CategoryManageViewModel {
    
    struct IconGroup {
        let name: String
        let icons: [String]
    }
    
    var icons: [IconGroup] {
        [
            IconGroup(
                name: "Food & Drink",
                icons: [
                    "utensils",
                    "room-service",
                    "mug-hot-alt",
                    "hamburger-soda",
                    "grocery-bag",
                    "hamburger",
                    "croissant",
                    "burrito",
                    "apple-whole",
                    "bowl-chopsticks-noodles",
                    "beer",
                    "glass-cheers",
                    "pepper-hot",
                    "pizza-slice",
                    "sandwich",
                    "bowl-rice",
                    "lunch-box",
                    "fish",
                ],
            ),
            IconGroup(
                name: "Transport",
                icons: [
                    "car-alt",
                    "taxi",
                    "bus-alt",
                    "subway",
                    "gas-pump-alt",
                    "motorcycle",
                    "train-side",
                    "truck-container",
                    "bike",
                    "parking-circle",
                    "helicopter-side",
                    "plane-departure",
                    "scooter",
                    "snowplow",
                    "tractor",
                ],
            ),
            IconGroup(
                name: "Entertainment",
                icons: [
                    "popcorn",
                    "theater-masks",
                    "console-controller",
                    "game-console-crank-handheld",
                    "music",
                    "cards-blank",
                    "chess-knight-alt",
                    "guitars",
                    "microphone-alt",
                    "piano-keyboard",
                    "film",
                    "kite",
                    "puzzle",
                ],
            ),
            IconGroup(
                name: "Sport",
                icons: [
                    "basketball",
                    "volleyball",
                    "tennis",
                    "rugby",
                    "baseball",
                    "boxing-glove",
                    "canoe",
                    "hiking",
                    "hockey-sticks",
                    "ice-skate",
                    "muscle",
                    "shuttlecock",
                    "skiing",
                    "trophy",
                    "uniform-martial-arts",
                    "windsurf",
                    "ping-pong",
                    "mask-snorkel",
                ],
            ),
            IconGroup(
                name: "Home",
                icons: [
                    "house-chimney-window",
                    "rent",
                    "city",
                    "wifi",
                    "couch",
                    "thunder-icon",
                    "home-settings",
                    "hammer-crash",
                    "paint-roller",
                    "wrench-alt",
                    "dog",
                    "cat",
                    "sheep",
                    "toilet-paper-blank",
                ],
            ),
            IconGroup(
                name: "Family",
                icons: [
                    "family",
                    "smiling-baby",
                    "teddy-bear",
                    "cat-dog",
                    "baby-carriage",
                    "balloon",
                    "party-horn",
                    "cake-birthday",
                ],
            ),
            IconGroup(
                name: "Health",
                icons: [
                    "doctor",
                    "stethoscope",
                    "hospital",
                    "ambulance",
                    "user-md",
                    "heart-rate",
                    "tooth",
                    "syringe",
                    "pills",
                ],
            ),
            IconGroup(
                name: "Shopping",
                icons: [
                    "shopping-cart",
                    "shopping-basket",
                    "bags-shopping",
                    "gift-card",
                    "marketplace",
                    "gift",
                    "hand-present",
                    "tshirt",
                ],
            ),
            IconGroup(
                name: "Travel",
                icons: [
                    "globe",
                    "plane-departure",
                    "person-luggage",
                    "ticket-airline",
                    "airplane-journey",
                    "plane-globe",
                    "map-point",
                ],
            ),
            IconGroup(
                name: "Education",
                icons: [
                    "graduation-cap",
                    "book-alt",
                    "books",
                    "lesson",
                    "workshop",
                    "microscope",
                    "pen-clip",
                    "pen-swirl",
                    "ruler-combined",
                    "info",
                ],
            ),
            IconGroup(
                name: "Finance",
                icons: [
                    "briefcase",
                    "coins",
                    "wallet-income",
                    "pig",
                    "payroll-calendar",
                    "investment",
                    "bonus-alt",
                    "cash",
                    "government-budget",
                    "growth-chart-invest",
                    "payroll",
                    "refund-alt",
                    "send-dollars",
                    
                ],
            ),
            IconGroup(
                name: "Other",
                icons: [
                    "interrogation",
                    "bookmark",
                    "folder",
                    "analytics",
                    "apps",
                    "brightness",
                    "cloud",
                    "eye-crossed",
                    "mobile-notch",
                    "laptop",
                    "settings",
                    "snooze",
                    "subscription",
                    "terms-check",
                    "trash",
                    "user-lock",
                    "bolt",
                    "clapper-open",
                ],
            ),
        ]
    }

}
