//
//  AccountManageServiceProtocol.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 29.12.2025.
//

import Foundation

protocol AccountManageServiceProtocol {
    func accountsCount() -> Int
    func saveAccount(_ account: Account)
}
