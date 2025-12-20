//
//  Category.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import Foundation

final class Category {
    var id: UUID = UUID()
    var name: String = ""
    var iconName: String = ""
    var sortOrder: Int = 0
    var isDefault: Bool = false
    var createdAt: Date = Date()
}
