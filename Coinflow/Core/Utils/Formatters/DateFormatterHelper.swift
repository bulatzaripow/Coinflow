//
//  DateFormatterHelper.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 20.12.2025.
//

import Foundation

struct DateFormatterHelper {
    // Format as "Wednesday, 24 Oct"
    static func formatDayMonth(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMM"
        formatter.locale = Locale.current
        return formatter.string(from: date)
    }
}
