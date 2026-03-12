//
//  StringExtensionTests.swift
//  CoinflowTests
//
//  Created by Bulat Zaripov on 28.02.2026.
//

import XCTest
@testable import Coinflow

class StringExtensionTests: XCTestCase {
    
    // MARK: - AsDouble Tests
    
    func testAsDouble_withVariousInputs() {
        // Given
        let testCases: [(input: String, expected: Double?)] = [
            ("42", 42.0),
            ("3.14", 3.14),
            ("5,67", 5.67),
            ("-10.5", -10.5),
            ("007.5", 7.5),
            ("42.500", 42.5),
            ("1e3", 1000.0),
            ("not a number", nil),
            ("", nil),
            (",", nil),
            ("1.2.3", nil),
            ("1,2,3", nil),
            (" 42 ", nil),
            
            ("inf", Double.infinity),
            ("+inf", Double.infinity),
            ("-inf", -Double.infinity),
            ("infinity", Double.infinity),
            ("nan", Double.nan),
            ("NaN", Double.nan),
            ("+nan", Double.nan),
            ("-nan", Double.nan),
        ]
        
        // When & Then
        for (input, expected) in testCases {
            guard let expected = expected else {
                continue
            }
            
            let result = input.asDouble
            
            if expected.isNaN {
                XCTAssertTrue(result?.isNaN == true, "Input: '\(input)' should be NaN, got \(String(describing: result))")
            } else {
                XCTAssertEqual(result, expected, "Input: '\(input)' should return \(String(describing: expected))")
            }
        }
    }

}
