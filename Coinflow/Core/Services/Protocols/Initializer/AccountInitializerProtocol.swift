//
//  AccountInitializerProtocol.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 21.12.2025.
//

import SwiftData

protocol AccountInitializerProtocol {
    
    // MARK: - Props
    
    var context: ModelContext { get }
    
    // MARK: - Methods
    
    func setupDefaultAccountIfNeeded()
}
