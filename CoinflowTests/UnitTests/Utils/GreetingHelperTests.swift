//
//  GreetingHelperTests.swift
//  CoinflowTests
//
//  Created by Bulat Zaripov on 06.02.2026.
//

import XCTest
@testable import Coinflow
import SwiftUI

final class GreetingHelperTests: XCTestCase {
    
    private let expectedGreetings = [
        "Good morning",
        "Good afternoon",
        "Good evening",
        "Good night"
    ]
    
    func testGreeting_morning_5to12() {
        let dates = [
            createDate(hour: 5, minute: 0),
            createDate(hour: 8, minute: 30),
            createDate(hour: 11, minute: 59),
        ]
        
        for date in dates {
            let greeting = GreetingHelper.greeting(for: date)
            XCTAssertEqual(greeting.stringKey, "Good morning")
        }
    }
    
    func testGreeting_afternoon_12to17() {
        let dates = [
            createDate(hour: 12, minute: 0),
            createDate(hour: 14, minute: 30),
            createDate(hour: 16, minute: 59),
        ]
        for date in dates {
            let greeting = GreetingHelper.greeting(for: date)
            XCTAssertEqual(greeting.stringKey, "Good afternoon")
        }
    }
    
    func testGreeting_evening_17to22() {
        let dates = [
            createDate(hour: 17, minute: 0),
            createDate(hour: 19, minute: 30),
            createDate(hour: 21, minute: 59),
        ]
        for date in dates {
            let greeting = GreetingHelper.greeting(for: date)
            XCTAssertEqual(greeting.stringKey, "Good evening")
        }
    }
    
    func testGreeting_night() {
        let dates = [
            createDate(hour: 0, minute: 0),
            createDate(hour: 2, minute: 30),
            createDate(hour: 4, minute: 59),
            createDate(hour: 22, minute: 0),
            createDate(hour: 23, minute: 59),
        ]
        for date in dates {
            let greeting = GreetingHelper.greeting(for: date)
            XCTAssertEqual(greeting.stringKey, "Good night")
        }
    }
    
    func testGreeting_returnsOneOfExpectedValues() {
        let greeting = GreetingHelper.greeting()
        let greetingString = greeting.stringKey ?? "testGreeting_returnsOneOfExpectedValues: no stringKey"
        XCTAssertTrue(expectedGreetings.contains(greetingString), "Expected one of \(expectedGreetings), got '\(greetingString)'")
    }
    
    private func createDate(hour: Int, minute: Int) -> Date {
        var components = DateComponents()
        components.year = 2025
        components.month = 1
        components.day = 15
        components.hour = hour
        components.minute = minute
        return Calendar.current.date(from: components)!
    }
}
