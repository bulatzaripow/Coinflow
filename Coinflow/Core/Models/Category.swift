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
    var iconName: String = ""
    var sortOrder: Int = 0
    var isDefault: Bool = false
    var createdAt: Date = Date()
    
    init(
        name: String,
        iconName: String,
        sortOrder: Int,
        isDefault: Bool,
        createdAt: Date
    ) {
        self.name = name
        self.iconName = iconName
        self.sortOrder = sortOrder
        self.isDefault = isDefault
        self.createdAt = createdAt
    }
}
