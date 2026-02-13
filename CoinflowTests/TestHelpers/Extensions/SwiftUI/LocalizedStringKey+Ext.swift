//
//  LocalizedStringKey+Ext.swift
//  CoinflowTests
//
//  Created by Bulat Zaripov on 07.02.2026.
//

import SwiftUI

extension LocalizedStringKey {
    var stringKey: String? {
        let mirror = Mirror(reflecting: self)
        guard let key = mirror.children.first(where: { $0.label == "key" })?.value as? String else {
            return nil
        }
        return key
    }
}
