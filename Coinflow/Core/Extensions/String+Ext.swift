//
//  String+Ext.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 19.12.2025.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }

    var asDouble: Double? {
        let normalized = self.replacingOccurrences(of: ",", with: ".")
        return Double(normalized)
    }
}
