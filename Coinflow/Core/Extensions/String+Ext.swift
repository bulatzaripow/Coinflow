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

    func localized(in locale: String) -> String {
        guard
            let path = Bundle.main.path(forResource: locale, ofType: "lproj"),
            let bundle = Bundle(path: path)
        else { return self }

        return bundle.localizedString(forKey: self, value: self, table: nil)
    }

    var asDouble: Double? {
        let normalized = self.replacingOccurrences(of: ",", with: ".")
        return Double(normalized)
    }
}
