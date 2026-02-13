//
//  MigrationPlans.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 05.02.2026.
//

import Foundation
import SwiftData

enum UpgradeMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [
            SchemaV1.self
        ]
    }

    static var stages: [MigrationStage] {
        []
    }
}

enum DowngradeMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [
            SchemaV1.self
        ]
    }

    static var stages: [MigrationStage] {
        []
    }
}
