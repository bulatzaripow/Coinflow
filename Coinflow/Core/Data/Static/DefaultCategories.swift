//
//  DefaultCategories.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 13.03.2026.
//

import Foundation

func getDefaultCategories() -> [(name: String, icon: String, type: CategoryType, color: String)] {

    return [
        // Expenses
        ("categoryOther", "interrogation", CategoryType.expense, "#757575"),
        ("categoryGroceries", "grocery-bag", CategoryType.expense, "#4CAF50"),
        ("categoryRestaurant", "utensils", CategoryType.expense, "#FF9800"),
        ("categoryShopping", "shopping-cart", CategoryType.expense, "#2196F3"),
        ("categoryCoffee", "mug-hot-alt", CategoryType.expense, "#795548"),
        ("categoryDelivery", "car-alt", CategoryType.expense, "#FF7043"),
        ("categoryTaxi", "taxi", CategoryType.expense, "#FF5722"),
        ("categoryPublicTransport", "bus-alt", CategoryType.expense, "#42A5F5"),
        ("categoryFuel", "gas-pump-alt", CategoryType.expense, "#FFB300"),
        ("categoryParking", "parking-circle", CategoryType.expense, "#5C6BC0"),
        ("categoryClothing", "tshirt", CategoryType.expense, "#EC407A"),
        ("categoryElectronics", "mobile-notch", CategoryType.expense, "#00ACC1"),
        ("categoryGifts", "gift", CategoryType.expense, "#AB47BC"),
        ("categoryRent", "city", CategoryType.expense, "#7E57C2"),
        ("categoryUtilities", "bolt", CategoryType.expense, "#FFEE58"),
        ("categoryPharmacy", "pills", CategoryType.expense, "#66BB6A"),
        ("categoryDoctor", "stethoscope", CategoryType.expense, "#EF5350"),
        ("categoryCinema", "clapper-open", CategoryType.expense, "#BA68C8"),
        ("categorySubscriptions", "subscription", CategoryType.expense, "#26A69A"),
        ("categoryHobbies", "puzzle", CategoryType.expense, "#FFA726"),
        ("categoryCourses", "lesson", CategoryType.expense, "#5C6BC0"),
        ("categoryBooks", "books", CategoryType.expense, "#8D6E63"),
        ("categoryPetCare", "dog", CategoryType.expense, "#FF8A65"),

        // Income
        ("categoryOtherIncome", "interrogation", CategoryType.income, "#757575"),
        ("categorySalary", "wallet-income", CategoryType.income, "#2E7D32"),
        ("categoryBonus", "bonus-alt", CategoryType.income, "#FF8F00"),
        ("categoryBusiness", "briefcase", CategoryType.income, "#546E7A"),
        ("categoryInvestmentIncome", "growth-chart-invest", CategoryType.income, "#00897B"),
        ("categoryGiftReceived", "hand-present", CategoryType.income, "#D81B60"),
        ("categoryCashbackRefund", "refund-alt", CategoryType.income, "#7CB342"),
        ("categoryDividends", "investment", CategoryType.income, "#00695C"),
        ("categoryRentalIncome", "rent", CategoryType.income, "#5E35B1"),
        ("categoryGovernmentSupport", "government-budget", CategoryType.income, "#455A64")
    ]
}
