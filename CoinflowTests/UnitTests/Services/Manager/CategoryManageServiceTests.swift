//
//  CategoryManageServiceTests.swift
//  CoinflowTests
//
//  Created by Bulat Zaripov on 10.02.2026.
//

import XCTest
import SwiftData
@testable import Coinflow

@MainActor
final class CategoryManageServiceTests: XCTestCase {

    // MARK: - Props

    var container: ModelContainer!
    var context: ModelContext!
    var service: CategoryManageService!
    
    // MARK: - Setup

    override func setUpWithError() throws {
        container = try makeTestContainer()
        context = ModelContext(container)
        service = CategoryManageService(context: context)
    }

    // MARK: - Tests

    func testFetchAllSortedByOrder() {
        let a = Category(
            name: "Food",
            type: .expense,
            icon: "grocery-bag",
            color: "red",
            sortOrder: 2,
            isDefault: false,
            createdAt: .now
        )

        let b = Category(
            name: "Salary",
            type: .income,
            icon: "wallet-income",
            color: "green",
            sortOrder: 1,
            isDefault: false,
            createdAt: .now
        )

        service.save(a)
        service.save(b)

        let result = service.fetchAll()
        XCTAssertEqual(result.map(\.name), ["Salary", "Food"])
    }

    func testFetchAllInReverseOrder() {
        let a = Category(
            name: "A",
            type: .expense,
            icon: "",
            color: "",
            sortOrder: 1,
            isDefault: false,
            createdAt: .now
        )

        let b = Category(
            name: "B",
            type: .expense,
            icon: "",
            color: "",
            sortOrder: 2,
            isDefault: false,
            createdAt: .now
        )

        service.save(a)
        service.save(b)

        let result = service.fetchAllInOrder(.reverse)
        XCTAssertEqual(result.map(\.name), ["B", "A"])
    }

    func testFetchByType() {
        let income = Category(
            name: "Salary",
            type: .income,
            icon: "",
            color: "",
            sortOrder: 1,
            isDefault: false,
            createdAt: .now
        )

        let expense = Category(
            name: "Food",
            type: .expense,
            icon: "",
            color: "",
            sortOrder: 2,
            isDefault: false,
            createdAt: .now
        )

        service.save(income)
        service.save(expense)

        let result = service.fetchAllByType(type: .income)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Salary")
    }
}

