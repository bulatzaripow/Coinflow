//
//  AppColors.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 28.12.2025.
//

import SwiftUI

enum AppColors: String, CaseIterable, Identifiable {
    case sunset
    case ocean
    case forest
    case neon
    case sunrise
    case lavender
    case mint
    case coral
    case galaxy
    case twilight
    case fire
    case ice
    case spring
    case autumn

    var id: String { self.rawValue }

    var colors: [Color] {
        switch self {
        case .sunset:
            return [
                Color(red: 1.0, green: 0.6, blue: 0.0),
                Color(red: 1.0, green: 0.2, blue: 0.5),
                Color(red: 0.6, green: 0.0, blue: 0.8)
            ]

        case .ocean:
            return [
                Color(red: 0.0, green: 0.3, blue: 0.6),
                Color(red: 0.0, green: 0.7, blue: 0.9),
                Color(red: 0.5, green: 0.9, blue: 1.0)
            ]

        case .forest:
            return [
                Color(red: 0.0, green: 0.4, blue: 0.2),
                Color(red: 0.2, green: 0.6, blue: 0.3),
                Color(red: 0.5, green: 0.8, blue: 0.4)
            ]

        case .neon:
            return [.blue, .purple, .pink]

        case .sunrise:
            return [
                Color(red: 0.5, green: 0.0, blue: 0.5),
                Color(red: 1.0, green: 0.4, blue: 0.0),
                Color(red: 1.0, green: 0.9, blue: 0.0)
            ]

        case .lavender:
            return [
                Color(red: 0.7, green: 0.6, blue: 1.0),
                Color(red: 0.9, green: 0.8, blue: 1.0),
                Color(red: 1.0, green: 0.9, blue: 1.0)
            ]

        case .mint:
            return [.mint, .cyan, .teal]

        case .coral:
            return [
                Color(red: 1.0, green: 0.4, blue: 0.4),
                Color(red: 1.0, green: 0.6, blue: 0.6),
                Color(red: 1.0, green: 0.8, blue: 0.8)
            ]

        case .galaxy:
            return [
                .black,
                Color(red: 0.2, green: 0.0, blue: 0.4),
                Color(red: 0.1, green: 0.0, blue: 0.3)
            ]

        case .twilight:
            return [
                Color(red: 0.2, green: 0.0, blue: 0.5),
                Color(red: 0.6, green: 0.2, blue: 0.7),
                Color(red: 0.9, green: 0.4, blue: 0.4)
            ]

        case .fire:
            return [.red, .orange, .yellow]

        case .ice:
            return [.blue, .cyan]

        case .spring:
            return [.pink, .yellow, .green]

        case .autumn:
            return [.orange, .brown, .red]
        }
    }

    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
