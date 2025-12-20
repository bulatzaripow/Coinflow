//
//  String+Ext.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 19.12.2025.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, tableName: nil, bundle: .main, comment: "")
    }
}
