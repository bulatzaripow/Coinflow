//
//  DateExtensionTests.swift
//  CoinflowTests
//
//  Created by Bulat Zaripov on 06.02.2026.
//

import XCTest
@testable import Coinflow

final class DateExtensionTests: XCTestCase {
    
    var calendar: Calendar!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        calendar = Calendar.current
    }
    
    func testStartOfCurrentMonth() {
        let start = Date.startOfCurrentMonth
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: start)
        XCTAssertEqual(components.day, 1)
        XCTAssertEqual(components.hour, 0)
        XCTAssertEqual(components.minute, 0)
        XCTAssertEqual(components.second, 0)
    }
    
    func testEndOfCurrentMonth() {
        let end = Date.endOfCurrentMonth
        let monthInterval = calendar.dateInterval(of: .month, for: end)
        XCTAssertNotNil(monthInterval)
        if let interval = monthInterval {
            XCTAssertTrue(end >= interval.start && end < interval.end)
        }
    }
    
    func testStartOfCurrentWeek() {
        let start = Date.startOfCurrentWeek
        let weekday = calendar.component(.weekday, from: start)
        let firstWeekday = calendar.firstWeekday
        XCTAssertEqual(weekday, firstWeekday)
    }
    
    func testEndOfCurrentWeek() {
        let end = Date.endOfCurrentWeek
        let weekInterval = calendar.dateInterval(of: .weekOfYear, for: end)
        XCTAssertNotNil(weekInterval)
    }
    
    func testStartOfCurrentYear() {
        let start = Date.startOfCurrentYear
        let components = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: start)
        XCTAssertEqual(components.month, 1)
        XCTAssertEqual(components.day, 1)
        XCTAssertEqual(components.hour, 0)
    }
    
    func testFormatDateRange_sameDay() {
        let date = Date()
        let result = Date.formatDateRange(startDate: date, endDate: date)
        XCTAssertFalse(result.isEmpty)
    }
    
    func testFormatDateRange_fullMonth() {
        var components = DateComponents()
        components.year = 2025
        components.month = 3
        components.day = 1
        let monthStart = calendar.date(from: components)!
        let monthEnd = calendar.date(byAdding: .day, value: -1, to: calendar.date(byAdding: .month, value: 1, to: monthStart)!)!
        
        let result = Date.formatDateRange(startDate: monthStart, endDate: monthEnd)
        XCTAssertTrue(result.contains("2025") || result.contains("March") || result.contains("март"))
    }
    
    func testFormatDateRange_differentDays() {
        var components = DateComponents()
        components.year = 2025
        components.month = 1
        components.day = 10
        let start = calendar.date(from: components)!
        components.day = 20
        let end = calendar.date(from: components)!
        
        let result = Date.formatDateRange(startDate: start, endDate: end)
        XCTAssertTrue(result.contains("-") || result.contains("10") || result.contains("20"))
    }
}
