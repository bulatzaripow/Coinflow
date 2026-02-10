//
//  ModelContainer.swift
//  CoinflowTests
//
//  Created by Bulat Zaripov on 10.02.2026.
//

import SwiftData
@testable import Coinflow

@MainActor
func makeTestContainer() throws -> ModelContainer {
    let schema = Schema(versionedSchema: SchemaLatestVersion.self)

    let config = ModelConfiguration(
        schema: schema,
        isStoredInMemoryOnly: true
    )

    return try ModelContainer(
        for: schema,
        configurations: [config]
    )
}
