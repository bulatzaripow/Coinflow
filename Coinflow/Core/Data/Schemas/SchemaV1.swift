//
//  SchemaV1.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 05.02.2026.
//

import Foundation
import SwiftData

enum SchemaV1: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [
            SchemaV1.Account.self,
            SchemaV1.Transaction.self,
            SchemaV1.Category.self,
            SchemaV1.Currency.self,
        ]
    }
    
    static let versionIdentifier = Schema.Version(1, 0, 0)
}
