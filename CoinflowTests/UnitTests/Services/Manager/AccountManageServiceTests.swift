//
//  AccountManageServiceTests.swift
//  CoinflowTests
//
//  Created by Bulat Zaripov on 10.02.2026.
//

import XCTest
import SwiftData
@testable import Coinflow

@MainActor
final class AccountManageServiceTests: XCTestCase {
    
    // MARK: - Props
    
    var container: ModelContainer!
    var context: ModelContext!
    var service: AccountManageService!
    
    // MARK: - Setup

    override func setUpWithError() throws {
        container = try makeTestContainer()
        context = ModelContext(container)
        service = AccountManageService(context: context)
    }

    override func tearDown() {
        container = nil
        context = nil
        service = nil
    }
    
    // MARK: - Tests

    func testSaveAccount() {
        let currency = makeCurrency(context: context)

        let account = Account(
            name: "Cash",
            balance: 100,
            currency: currency,
            icon: "cash",
            sortIndex: 1
        )

        service.save(account)

        let accounts = service.fetchAll()

        XCTAssertEqual(accounts.count, 1)
        XCTAssertEqual(accounts.first?.name, "Cash")
        XCTAssertEqual(accounts.first?.currency.code, "USD")
    }

    func testFetchAccountById() {
        let currency = makeCurrency(context: context)

        let account = Account(
            name: "Card",
            balance: 0,
            currency: currency,
            icon: "card",
            sortIndex: 1
        )

        service.save(account)

        let fetched = service.fetchById(account.id)

        XCTAssertNotNil(fetched)
        XCTAssertEqual(fetched?.id, account.id)
    }

    func testOnlyOneDefaultAccountAllowed() {
        let currency = makeCurrency(context: context)

        let first = Account(
            name: "Cash",
            balance: 0,
            currency: currency,
            icon: "cash",
            sortIndex: 1,
            isDefault: 1
        )

        let second = Account(
            name: "Card",
            balance: 0,
            currency: currency,
            icon: "card",
            sortIndex: 2,
            isDefault: 1
        )

        service.save(first)
        service.save(second)

        let accounts = service.fetchAll()
        let defaultAccounts = accounts.filter { $0.isDefault == 1 }

        XCTAssertEqual(defaultAccounts.count, 1)
        XCTAssertEqual(defaultAccounts.first?.name, "Card")
    }

    func testFetchAllSortedBySortIndex() {
        let currency = makeCurrency(context: context)

        let a = Account(
            name: "A",
            balance: 0,
            currency: currency,
            icon: "a",
            sortIndex: 2
        )

        let b = Account(
            name: "B",
            balance: 0,
            currency: currency,
            icon: "b",
            sortIndex: 1
        )

        service.save(a)
        service.save(b)

        let accounts = service.fetchAll()

        XCTAssertEqual(accounts.map(\.name), ["B", "A"])
    }

    func testNextSortIndex() {
        let currency = makeCurrency(context: context)

        let a = Account(
            name: "A",
            balance: 0,
            currency: currency,
            icon: "a",
            sortIndex: 1
        )

        let b = Account(
            name: "B",
            balance: 0,
            currency: currency,
            icon: "b",
            sortIndex: 3
        )

        service.save(a)
        service.save(b)

        let nextIndex = service.nextSortIndex()

        XCTAssertEqual(nextIndex, 3)
    }

    func testDeleteAccount() {
        let currency = makeCurrency(context: context)

        let account = Account(
            name: "Cash",
            balance: 0,
            currency: currency,
            icon: "cash",
            sortIndex: 1
        )

        service.save(account)
        service.delete(account)

        let accounts = service.fetchAll()

        XCTAssertTrue(accounts.isEmpty)
    }

    func testCascadeDeleteTransactions() {
        let currency = makeCurrency(context: context)

        let account = Account(
            name: "Cash",
            balance: 0,
            currency: currency,
            icon: "cash",
            sortIndex: 1
        )

        let transaction = Transaction(
            amount: 100,
            type: .expense,
            account: account
        )

        service.save(account)
        context.insert(transaction)
        try? context.save()

        service.delete(account)

        let txDescriptor = FetchDescriptor<Transaction>()
        let transactions = try? context.fetch(txDescriptor)

        XCTAssertTrue(transactions?.isEmpty ?? false)
    }

}
