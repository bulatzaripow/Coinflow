//
//  AccountValidationError.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 02.02.2026.
//

import Foundation

enum AccountValidationError: LocalizedError {

    case emptyName
    case nameStartsWithDigit
    case invalidBalance

    var errorDescription: String? {
        switch self {
        case .emptyName:
            return "Account name cannot be empty"
        case .nameStartsWithDigit:
            return "Account name must not start with a number"
        case .invalidBalance:
            return "Balance must be a valid number"
        }
    }
}
