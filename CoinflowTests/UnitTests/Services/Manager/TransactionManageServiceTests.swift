//
//  TransactionManageServiceTests.swift
//  CoinflowTests
//
//  Created by Bulat Zaripov on 10.02.2026.
//

import XCTest
import SwiftData
@testable import Coinflow

@MainActor
final class TransactionManageServiceTests: XCTestCase {

    // MARK: - Props

    var container: ModelContainer!
    var context: ModelContext!
    var service: TransactionManageService!

    // MARK: - Setup

    override func setUpWithError() throws {
        container = try makeTestContainer()
        context = ModelContext(container)
        service = TransactionManageService(context: context)
    }

    // MARK: - Tests

    func testExpenseTransactionDecreasesBalance() {
        let account = makeAccount(context: context, balance: 100)
        let transaction = Transaction()

        service.save(
            transaction,
            amount: 50,
            note: "",
            type: .expense,
            date: .now,
            category: nil,
            account: account
        )

        XCTAssertEqual(account.balance, 50)
    }

    func testIncomeTransactionIncreasesBalance() {
        let account = makeAccount(context: context, balance: 100)
        let transaction = Transaction()

        service.save(
            transaction,
            amount: 30,
            note: "",
            type: .income,
            date: .now,
            category: nil,
            account: account
        )

        XCTAssertEqual(account.balance, 130)
    }

    func testTransferTransactionMovesBalance() {
        let from = makeAccount(context: context, balance: 100)
        let to = makeAccount(context: context, balance: 20)

        let transaction = Transaction()

        service.save(
            transaction,
            amount: 40,
            note: "",
            type: .transfer,
            date: .now,
            category: nil,
            account: from,
            toAccount: to
        )

        XCTAssertEqual(from.balance, 60)
        XCTAssertEqual(to.balance, 60)
    }

    func testEditTransactionRevertsPreviousBalance() {
        let account = makeAccount(context: context, balance: 100)
        let transaction = Transaction()

        service.save(
            transaction,
            amount: 20,
            note: "",
            type: .expense,
            date: .now,
            category: nil,
            account: account
        )

        service.save(
            transaction,
            amount: 10,
            note: "",
            type: .expense,
            date: .now,
            category: nil,
            account: account
        )

        XCTAssertEqual(account.balance, 90)
    }

    func testDeleteTransactionRevertsBalance() {
        let account = makeAccount(context: context, balance: 100)
        let transaction = Transaction()

        service.save(
            transaction,
            amount: 30,
            note: "",
            type: .expense,
            date: .now,
            category: nil,
            account: account
        )

        service.delete(transaction)

        XCTAssertEqual(account.balance, 100)
    }

    func testFetchByAccountAndDateRange() {
        let account = makeAccount(context: context, balance: 100)

        let tx1 = Transaction(date: Date(timeIntervalSince1970: 1000), account: account)
        let tx2 = Transaction(date: Date(timeIntervalSince1970: 2000), account: account)

        context.insert(tx1)
        context.insert(tx2)
        try? context.save()

        let result = service.fetchByAccountAndDateRange(
            account: account,
            startDate: Date(timeIntervalSince1970: 500),
            endDate: Date(timeIntervalSince1970: 1500)
        )

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.date, tx1.date)
    }
}
