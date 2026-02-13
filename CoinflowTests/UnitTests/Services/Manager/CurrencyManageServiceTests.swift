//
//  CurrencyManageServiceTests.swift
//  CoinflowTests
//
//  Created by Bulat Zaripov on 10.02.2026.
//

import XCTest
import SwiftData
@testable import Coinflow

@MainActor
final class CurrencyManageServiceTests: XCTestCase {

    // MARK: - Props

    var container: ModelContainer!
    var context: ModelContext!
    var service: CurrencyManageService!

    // MARK: - Setup

    override func setUpWithError() throws {
        container = try makeTestContainer()
        context = ModelContext(container)
        service = CurrencyManageService(context: context)
    }

    // MARK: - Tests

    func testFetchByCode() {
        let usd = Currency(code: "USD", symbol: "$", name: "US Dollar")
        let eur = Currency(code: "EUR", symbol: "€", name: "Euro")

        service.save(usd)
        service.save(eur)

        let result = service.fetchByCode(by: "EUR")

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.symbol, "€")
    }

    func testDefaultCurrencyReturnsExisting() {
        let usd = Currency(code: "USD", symbol: "$", name: "US Dollar")
        service.save(usd)

        let result = service.defaultCurrency()

        XCTAssertEqual(result.code, "USD")
    }

    func testDefaultCurrencyCreatesIfMissing() {
        let result = service.defaultCurrency()

        XCTAssertEqual(result.code, "USD")

        let all = service.fetchAll()
        XCTAssertEqual(all.count, 1)
    }
}

