//
//  Category.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import Foundation
import SwiftData

@Model
final class Category {
    var id: UUID = UUID()
    var name: String = ""
    var type: CategoryType
    var icon: String = ""
    var color: String = ""
    var sortOrder: Int = 0
    var isDefault: Bool = false
    var createdAt: Date = Date()
    
    init(
        name: String,
        type: CategoryType,
        icon: String,
        color: String,
        sortOrder: Int,
        isDefault: Bool,
        createdAt: Date
    ) {
        self.name = name
        self.type = type
        self.icon = icon
        self.color = color
        self.sortOrder = sortOrder
        self.isDefault = isDefault
        self.createdAt = createdAt
    }
}

enum CategoryType: String, CaseIterable, Codable {
    case income = "income"
    case expense = "expense"
}
